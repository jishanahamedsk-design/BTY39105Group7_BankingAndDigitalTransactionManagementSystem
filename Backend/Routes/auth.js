const express = require("express");
const bcrypt = require("bcrypt");
const crypto = require("crypto");
const jwt = require("jsonwebtoken");

const {
    sendVerificationEmail,
    sendPasswordResetEmail,
    sendPasswordResetConfirmationEmail
} = require("../../utils/emailService");

const {
    requireAuth,
    requireAdmin,
    requireMainAdmin
} = require("../middleware/auth");

const router = express.Router();

const OTP_MINUTES = 10;
const MAX_OTP_ATTEMPTS = 5;
const JWT_EXPIRY = "30m";
const RESET_TOKEN_EXPIRY = "5m";

// =========================================================
// GENERAL HELPERS
// =========================================================

const normalizeEmail = value =>
    String(value || "").trim().toLowerCase();

const normalizeText = value =>
    String(value || "").trim();

const normalizePhone = value =>
    String(value || "").trim();

function isValidEmail(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

function isDuplicateEntry(error) {
    return error && error.code === "ER_DUP_ENTRY";
}

function getDb(req) {
    const db = req.app.get("db");
    if (!db) throw new Error("Database was not configured in server.js.");
    return db;
}

async function queryDatabase(db, sql, params = []) {
    if (typeof db.promise === "function") {
        return db.promise().query(sql, params);
    }

    return new Promise((resolve, reject) => {
        db.query(sql, params, (error, results) => {
            if (error) return reject(error);
            resolve([results, undefined]);
        });
    });
}

async function getConnection(db) {
    if (
        typeof db.getConnection === "function" &&
        typeof db.promise === "function"
    ) {
        return db.promise().getConnection();
    }

    return db;
}

async function queryConnection(connection, sql, params = []) {
    if (
        connection.constructor &&
        /Promise/.test(connection.constructor.name)
    ) {
        return connection.query(sql, params);
    }

    if (typeof connection.promise === "function") {
        return connection.promise().query(sql, params);
    }

    return new Promise((resolve, reject) => {
        connection.query(sql, params, (error, results) => {
            if (error) return reject(error);
            resolve([results, undefined]);
        });
    });
}

function releaseConnection(connection) {
    if (connection && typeof connection.release === "function") {
        connection.release();
    }
}

async function beginTransaction(connection) {
    if (
        connection.constructor &&
        /Promise/.test(connection.constructor.name)
    ) {
        return connection.beginTransaction();
    }

    if (typeof connection.promise === "function") {
        return connection.promise().beginTransaction();
    }

    return new Promise((resolve, reject) => {
        connection.beginTransaction(error => {
            if (error) return reject(error);
            resolve();
        });
    });
}

async function commitTransaction(connection) {
    if (
        connection.constructor &&
        /Promise/.test(connection.constructor.name)
    ) {
        return connection.commit();
    }

    if (typeof connection.promise === "function") {
        return connection.promise().commit();
    }

    return new Promise((resolve, reject) => {
        connection.commit(error => {
            if (error) return reject(error);
            resolve();
        });
    });
}

async function rollbackTransaction(connection) {
    if (
        connection.constructor &&
        /Promise/.test(connection.constructor.name)
    ) {
        return connection.rollback();
    }

    if (typeof connection.promise === "function") {
        return connection.promise().rollback();
    }

    return new Promise((resolve, reject) => {
        connection.rollback(error => {
            if (error) return reject(error);
            resolve();
        });
    });
}

function sendServerError(res, error, message) {
    console.error(message, error.message || "Unknown error");

    const response = { success: false, message };

    if (process.env.NODE_ENV === "development") {
        response.error = error.message;
        response.code = error.code || null;
    }

    return res.status(500).json(response);
}

function validateJwtConfiguration(res) {
    if (!process.env.JWT_SECRET) {
        res.status(500).json({
            success: false,
            message: "Authentication is not configured."
        });
        return false;
    }

    return true;
}

// =========================================================
// PASSWORD HELPERS
// =========================================================

function isStrongPassword(password) {
    if (typeof password !== "string") {
        return false;
    }

    return (
        password.length >= 6 &&
        password.length <= 128 &&
        /[A-Z]/.test(password) &&
        /[a-z]/.test(password) &&
        /[0-9]/.test(password) &&
        /[^A-Za-z0-9]/.test(password)
    );
}

async function verifyPassword(password, storedPassword) {
    if (storedPassword == null || storedPassword === "") {
        return false;
    }

    const stored = String(storedPassword);
    const supplied = String(password);

    if (/^\$2[aby]\$/.test(stored)) {
        try {
            return await bcrypt.compare(supplied, stored);
        } catch {
            return false;
        }
    }

    // Legacy plaintext support; successful login upgrades the hash.
    return supplied === stored;
}

async function upgradeLegacyPassword(db, user, password) {
    const stored = String(user.password || "");

    if (/^\$2[aby]\$/.test(stored)) {
        return;
    }

    const hash = await bcrypt.hash(String(password), 12);

    await queryDatabase(
        db,
        `UPDATE users SET password = ? WHERE user_id = ?`,
        [hash, user.user_id]
    );

    user.password = hash;
}

// =========================================================
// OTP HELPERS
// =========================================================

function createOtp() {
    return crypto.randomInt(100000, 1000000).toString();
}

function hashOtp(email, purpose, code) {
    if (!process.env.JWT_SECRET) {
        throw new Error("JWT_SECRET is not configured.");
    }

    return crypto
        .createHmac("sha256", process.env.JWT_SECRET)
        .update(`${email}|${purpose}|${code}`)
        .digest("hex");
}

async function issueOtp(db, user, purpose) {
    const email = normalizeEmail(user.email);
    const code = createOtp();
    const codeHash = hashOtp(email, purpose, code);

    await queryDatabase(
        db,
        `UPDATE email_verification_codes
         SET consumed_at = NOW()
         WHERE email = ?
           AND purpose = ?
           AND consumed_at IS NULL`,
        [email, purpose]
    );

    await queryDatabase(
        db,
        `INSERT INTO email_verification_codes
            (user_id, email, purpose, code_hash, expires_at, attempts)
         VALUES (?, ?, ?, ?,
                 DATE_ADD(NOW(), INTERVAL ${OTP_MINUTES} MINUTE), 0)`,
        [user.user_id || null, email, purpose, codeHash]
    );

    try {
        if (purpose === "password_reset") {
            await sendPasswordResetEmail(email, code);
        } else {
            await sendVerificationEmail(email, code);
        }
    } catch (error) {
        await queryDatabase(
            db,
            `UPDATE email_verification_codes
             SET consumed_at = NOW()
             WHERE email = ?
               AND purpose = ?
               AND code_hash = ?
               AND consumed_at IS NULL`,
            [email, purpose, codeHash]
        );

        throw error;
    }
}

async function findValidOtp(db, email, purpose, code) {
    const [rows] = await queryDatabase(
        db,
        `SELECT id, user_id, code_hash, attempts
         FROM email_verification_codes
         WHERE email = ?
           AND purpose = ?
           AND consumed_at IS NULL
         ORDER BY id DESC
         LIMIT 1`,
        [email, purpose]
    );

    if (!rows.length) {
        return {
            valid: false,
            message: "Invalid or expired verification code."
        };
    }

    const record = rows[0];

    if (Number(record.attempts) >= MAX_OTP_ATTEMPTS) {
        return {
            valid: false,
            message: "Too many attempts. Request a new code."
        };
    }

    const [activeRows] = await queryDatabase(
        db,
        `SELECT id
         FROM email_verification_codes
         WHERE id = ?
           AND expires_at > NOW()
           AND consumed_at IS NULL`,
        [record.id]
    );

    if (!activeRows.length) {
        return {
            valid: false,
            message: "The code expired. Request a new one."
        };
    }

    const expected = String(record.code_hash || "");
    const supplied = hashOtp(email, purpose, code);

    const matches =
        /^[a-f0-9]{64}$/i.test(expected) &&
        crypto.timingSafeEqual(
            Buffer.from(expected, "hex"),
            Buffer.from(supplied, "hex")
        );

    if (!matches) {
        await queryDatabase(
            db,
            `UPDATE email_verification_codes
             SET attempts = attempts + 1
             WHERE id = ?
               AND consumed_at IS NULL`,
            [record.id]
        );

        return {
            valid: false,
            message: "Invalid verification code."
        };
    }

    return { valid: true, record };
}

async function consumeOtp(db, id) {
    const [result] = await queryDatabase(
        db,
        `UPDATE email_verification_codes
         SET consumed_at = NOW()
         WHERE id = ?
           AND consumed_at IS NULL
           AND expires_at > NOW()`,
        [id]
    );

    return result.affectedRows === 1;
}

// =========================================================
// TOKEN HELPERS
// =========================================================

function createAccessToken(user) {
    if (!process.env.JWT_SECRET) {
        throw new Error("JWT_SECRET is not configured.");
    }

    return jwt.sign(
        {
            userId: Number(user.user_id),
            role: String(user.role || "").trim().toLowerCase(),
            tokenVersion: Number(user.token_version || 0)
        },
        process.env.JWT_SECRET,
        {
            algorithm: "HS256",
            expiresIn: JWT_EXPIRY
        }
    );
}

function publicUser(user) {
    return {
        user_id: user.user_id,
        name: user.name,
        email: user.email,
        phone: user.phone,
        role: String(user.role || "").trim().toLowerCase()
    };
}

// =========================================================
// MAIN ADMIN â€” EMPLOYEE ADMIN MANAGEMENT
// =========================================================

router.get(
    "/admin/employee-admins",
    requireAuth,
    requireMainAdmin,
    async (req, res) => {
        try {
            const [admins] = await queryDatabase(
                getDb(req),
                `SELECT user_id, name, email, phone, role,
                        is_active, email_verified_at
                 FROM users
                 WHERE LOWER(TRIM(role)) = 'admin'
                 ORDER BY name ASC`
            );

            return res.json({
                success: true,
                employeeAdmins: admins
            });
        } catch (error) {
            return sendServerError(
                res,
                error,
                "Could not load employee administrators."
            );
        }
    }
);

router.post(
    "/admin/employee-admins",
    requireAuth,
    requireMainAdmin,
    async (req, res) => {
        try {
            const name = normalizeText(req.body.name);
            const email = normalizeEmail(req.body.email);
            const phone = normalizePhone(req.body.phone);

            if (!name || !email || !phone) {
                return res.status(400).json({
                    success: false,
                    message: "Name, email, and phone are required."
                });
            }

            if (
                name.length > 150 ||
                phone.length > 30 ||
                !isValidEmail(email) ||
                email.length > 254
            ) {
                return res.status(400).json({
                    success: false,
                    message: "Enter valid name, email, and phone details."
                });
            }

            const db = getDb(req);

            const [users] = await queryDatabase(
                db,
                `SELECT user_id
                 FROM users
                 WHERE LOWER(TRIM(email)) = ?
                    OR TRIM(phone) = ?
                 LIMIT 1`,
                [email, phone]
            );

            const [customers] = await queryDatabase(
                db,
                `SELECT customer_id
                 FROM Customer
                 WHERE LOWER(TRIM(email)) = ?
                    OR TRIM(phone) = ?
                 LIMIT 1`,
                [email, phone]
            );

            if (users.length || customers.length) {
                return res.status(409).json({
                    success: false,
                    message: "This email or phone is already registered."
                });
            }

            const randomSecret = crypto.randomBytes(48).toString("hex");
            const passwordHash = await bcrypt.hash(randomSecret, 12);

            const [inserted] = await queryDatabase(
                db,
                `INSERT INTO users
                    (name, email, phone, password, role,
                     email_verified_at, token_version, is_active)
                 VALUES (?, ?, ?, ?, 'admin', NOW(), 0, 1)`,
                [name, email, phone, passwordHash]
            );

            return res.status(201).json({
                success: true,
                message:
                    "Employee administrator created. They must use Forgot Password to set a password.",
                employeeAdmin: {
                    user_id: inserted.insertId,
                    name,
                    email,
                    phone,
                    role: "admin",
                    is_active: 1
                }
            });
        } catch (error) {
            if (isDuplicateEntry(error)) {
                return res.status(409).json({
                    success: false,
                    message: "This email or phone is already registered."
                });
            }

            return sendServerError(
                res,
                error,
                "Could not create the employee administrator."
            );
        }
    }
);

router.patch(
    "/admin/employee-admins/:id/status",
    requireAuth,
    requireMainAdmin,
    async (req, res) => {
        try {
            const employeeId = Number(req.params.id);
            const isActive = req.body.is_active;

            if (
                !Number.isSafeInteger(employeeId) ||
                employeeId <= 0
            ) {
                return res.status(400).json({
                    success: false,
                    message: "Invalid employee administrator ID."
                });
            }

            if (typeof isActive !== "boolean") {
                return res.status(400).json({
                    success: false,
                    message: "is_active must be true or false."
                });
            }

            if (employeeId === Number(req.auth.userId)) {
                return res.status(403).json({
                    success: false,
                    message:
                        "You cannot change your own account status here."
                });
            }

            const db = getDb(req);

            const [result] = await queryDatabase(
                db,
                `UPDATE users
                 SET is_active = ?,
                     token_version = COALESCE(token_version, 0) + 1
                 WHERE user_id = ?
                   AND LOWER(TRIM(role)) = 'admin'`,
                [isActive ? 1 : 0, employeeId]
            );

            if (!result.affectedRows) {
                const [existing] = await queryDatabase(
                    db,
                    `SELECT user_id
                     FROM users
                     WHERE user_id = ?
                       AND LOWER(TRIM(role)) = 'admin'`,
                    [employeeId]
                );

                if (!existing.length) {
                    return res.status(404).json({
                        success: false,
                        message: "Employee administrator not found."
                    });
                }
            }

            return res.json({
                success: true,
                message: isActive
                    ? "Employee administrator activated."
                    : "Employee administrator deactivated. Existing sessions have been revoked."
            });
        } catch (error) {
            return sendServerError(
                res,
                error,
                "Could not update the employee administrator."
            );
        }
    }
);

// =========================================================
// CUSTOMER SIGNUP â€” SEND VERIFICATION CODE
// =========================================================

router.post("/send-verification-code", async (req, res) => {
    try {
        const email = normalizeEmail(req.body.email);

        if (!isValidEmail(email)) {
            return res.status(400).json({
                success: false,
                message: "Enter a valid email address."
            });
        }

        const db = getDb(req);

        const [customers] = await queryDatabase(
            db,
            `SELECT customer_id, status
             FROM Customer
             WHERE LOWER(TRIM(email)) = ?
             LIMIT 1`,
            [email]
        );

        if (!customers.length) {
            return res.status(404).json({
                success: false,
                message:
                    "No existing bank customer was found for this email."
            });
        }

        if (
            customers[0].status &&
            String(customers[0].status).toLowerCase() !== "active"
        ) {
            return res.status(403).json({
                success: false,
                message: "Your bank customer profile is not active."
            });
        }

        const [users] = await queryDatabase(
            db,
            `SELECT user_id
             FROM users
             WHERE LOWER(TRIM(email)) = ?
             LIMIT 1`,
            [email]
        );

        if (users.length) {
            return res.status(409).json({
                success: false,
                message: "This email is already registered. Please log in."
            });
        }

        await issueOtp(db, { email }, "signup");

        return res.json({
            success: true,
            message: "If eligible, a verification code has been sent."
        });
    } catch (error) {
        return sendServerError(
            res,
            error,
            "Could not send the signup verification code."
        );
    }
});

// =========================================================
// VERIFY CUSTOMER SIGNUP EMAIL
// =========================================================

router.post("/verify-email", async (req, res) => {
    try {
        const email = normalizeEmail(req.body.email);
        const code = String(req.body.code || req.body.otp || "").trim();

        if (!isValidEmail(email) || !/^\d{6}$/.test(code)) {
            return res.status(400).json({
                success: false,
                message: "Enter a valid email and six-digit code."
            });
        }

        const db = getDb(req);
        const result = await findValidOtp(db, email, "signup", code);

        if (!result.valid) {
            return res.status(400).json({
                success: false,
                message: result.message
            });
        }

        const [updated] = await queryDatabase(
            db,
            `UPDATE email_verification_codes
             SET code_hash = 'VERIFIED'
             WHERE id = ?
               AND purpose = 'signup'
               AND consumed_at IS NULL
               AND expires_at > NOW()`,
            [result.record.id]
        );

        if (updated.affectedRows !== 1) {
            return res.status(400).json({
                success: false,
                message: "The code expired or was already used."
            });
        }

        return res.json({
            success: true,
            message:
                "Email verified. You may now complete registration."
        });
    } catch (error) {
        return sendServerError(res, error, "Email verification failed.");
    }
});

// =========================================================
// CUSTOMER SIGNUP
// =========================================================

router.post("/signup", async (req, res) => {
    try {
        const name = normalizeText(req.body.name);
        const email = normalizeEmail(req.body.email);
        const phone = normalizePhone(req.body.phone);
        const password = String(req.body.password || "");

        if (!name || !email || !phone || !password.trim()) {
            return res.status(400).json({
                success: false,
                message: "Please fill in all required fields."
            });
        }

        if (!isValidEmail(email)) {
            return res.status(400).json({
                success: false,
                message: "Enter a valid email address."
            });
        }

        if (!isStrongPassword(password)) {
            return res.status(400).json({
                success: false,
                code: "WEAK_PASSWORD",
                message:
                    "Password must be 6 to 128 characters and contain at least one uppercase letter, one lowercase letter, one number, and one special character."
            });
        }

        const db = getDb(req);

        const [customers] = await queryDatabase(
            db,
            `SELECT customer_id, name, email, phone, status
             FROM Customer
             WHERE LOWER(TRIM(email)) = ?
             LIMIT 1`,
            [email]
        );

        if (!customers.length) {
            return res.status(403).json({
                success: false,
                message:
                    "No existing bank customer was found for this email."
            });
        }

        const customer = customers[0];

        if (
            customer.status &&
            String(customer.status).toLowerCase() !== "active"
        ) {
            return res.status(403).json({
                success: false,
                message: "Your customer profile is not active."
            });
        }

        if (
            normalizeText(customer.name).toLowerCase() !== name.toLowerCase() ||
            normalizePhone(customer.phone) !== phone
        ) {
            return res.status(403).json({
                success: false,
                message:
                    "Your name or phone does not match the bank's existing record."
            });
        }

        const [existingusers] = await queryDatabase(
            db,
            `SELECT user_id
             FROM users
             WHERE LOWER(TRIM(email)) = ?
                OR TRIM(phone) = ?
             LIMIT 1`,
            [email, phone]
        );

        if (existingusers.length) {
            return res.status(409).json({
                success: false,
                message:
                    "This email or phone is already registered."
            });
        }

        const [markers] = await queryDatabase(
            db,
            `SELECT id
             FROM email_verification_codes
             WHERE email = ?
               AND purpose = 'signup'
               AND code_hash = 'VERIFIED'
               AND consumed_at IS NULL
               AND expires_at > NOW()
             ORDER BY id DESC
             LIMIT 1`,
            [email]
        );

        if (!markers.length) {
            return res.status(403).json({
                success: false,
                code: "EMAIL_NOT_VERIFIED",
                message:
                    "Verify your email before creating your login."
            });
        }

        const passwordHash = await bcrypt.hash(password, 12);
        const connection = await getConnection(db);
        let started = false;

        try {
            await beginTransaction(connection);
            started = true;

            const [locked] = await queryConnection(
                connection,
                `SELECT id
                 FROM email_verification_codes
                 WHERE id = ?
                   AND email = ?
                   AND purpose = 'signup'
                   AND code_hash = 'VERIFIED'
                   AND consumed_at IS NULL
                   AND expires_at > NOW()
                 FOR UPDATE`,
                [markers[0].id, email]
            );

            if (!locked.length) {
                await rollbackTransaction(connection);
                started = false;

                return res.status(403).json({
                    success: false,
                    message:
                        "Signup verification expired or was already used."
                });
            }

            await queryConnection(
                connection,
                `UPDATE email_verification_codes
                 SET consumed_at = NOW()
                 WHERE id = ?`,
                [markers[0].id]
            );

            await queryConnection(
                connection,
                `INSERT INTO users
                    (name, email, phone, password, role, email_verified_at)
                 VALUES (?, ?, ?, ?, 'user', NOW())`,
                [
                    customer.name,
                    customer.email,
                    customer.phone,
                    passwordHash
                ]
            );

            await commitTransaction(connection);
            started = false;
        } catch (error) {
            if (started) await rollbackTransaction(connection);
            throw error;
        } finally {
            releaseConnection(connection);
        }

        return res.status(201).json({
            success: true,
            message:
                "Email verified and registration successful. Please log in."
        });
    } catch (error) {
        if (isDuplicateEntry(error)) {
            return res.status(409).json({
                success: false,
                message:
                    "This email or phone is already registered."
            });
        }

        return sendServerError(res, error, "Registration failed.");
    }
});

// =========================================================
// CUSTOMER LOGIN â€” PASSWORD, THEN EMAIL OTP
// =========================================================

router.post("/login", async (req, res) => {
    try {
        const email = normalizeEmail(req.body.email);
        const password = String(req.body.password || "");

        if (!email || !password) {
            return res.status(400).json({
                success: false,
                message: "Enter your email and password."
            });
        }

        if (!validateJwtConfiguration(res)) return;

        const db = getDb(req);

        const [users] = await queryDatabase(
            db,
            `SELECT user_id, name, email, phone, password, role,
                    email_verified_at, token_version
             FROM users
             WHERE LOWER(TRIM(email)) = ?
               AND LOWER(TRIM(role)) = 'user'
             LIMIT 1`,
            [email]
        );

        if (
            !users.length ||
            !(await verifyPassword(password, users[0].password))
        ) {
            return res.status(401).json({
                success: false,
                message: "Invalid email or password."
            });
        }

        const user = users[0];

        const [customers] = await queryDatabase(
            db,
            `SELECT customer_id, status
             FROM Customer
             WHERE LOWER(TRIM(email)) = ?
             LIMIT 1`,
            [email]
        );

        if (
            !customers.length ||
            String(customers[0].status || "").toLowerCase() !== "active"
        ) {
            return res.status(403).json({
                success: false,
                message:
                    "Your bank customer profile is unavailable or inactive."
            });
        }

        await upgradeLegacyPassword(db, user, password);
        await issueOtp(db, user, "login");

        return res.json({
            success: true,
            otpRequired: true,
            message:
                "A login verification code has been sent to your email."
        });
    } catch (error) {
        return sendServerError(res, error, "Login failed. Please try again.");
    }
});

// =========================================================
// ADMIN LOGIN â€” PASSWORD, THEN EMAIL OTP
// =========================================================

router.post("/admin-login", async (req, res) => {
    try {
        const email = normalizeEmail(req.body.email);
        const password = String(req.body.password || "");

        if (!email || !password) {
            return res.status(400).json({
                success: false,
                message:
                    "Enter the administrator email and password."
            });
        }

        if (!validateJwtConfiguration(res)) return;

        const db = getDb(req);

        const [admins] = await queryDatabase(
            db,
            `SELECT user_id, name, email, phone, password, role,
                    email_verified_at, token_version, is_active
             FROM users
             WHERE LOWER(TRIM(email)) = ?
               AND LOWER(TRIM(role)) IN ('admin', 'main_admin')
             LIMIT 1`,
            [email]
        );

        if (
            !admins.length ||
            !(await verifyPassword(password, admins[0].password))
        ) {
            return res.status(401).json({
                success: false,
                message:
                    "Invalid administrator email or password."
            });
        }

        const admin = admins[0];
        const role = String(admin.role || "").trim().toLowerCase();

        if (Number(admin.is_active) !== 1) {
            return res.status(403).json({
                success: false,
                message:
                    "This administrator account is inactive. Contact the Main Admin."
            });
        }

        if (!admin.email_verified_at) {
            return res.status(403).json({
                success: false,
                code: "EMAIL_NOT_VERIFIED",
                message: "Verify your email before logging in."
            });
        }

        await upgradeLegacyPassword(db, admin, password);
        admin.role = role;
        await issueOtp(db, admin, "login");

        return res.json({
            success: true,
            otpRequired: true,
            message:
                "An administrator verification code has been sent to your email."
        });
    } catch (error) {
        return sendServerError(
            res,
            error,
            "Administrator login failed."
        );
    }
});

// =========================================================
// RESEND LOGIN OTP
// =========================================================

router.post("/resend-login-code", async (req, res) => {
    try {
        const email = normalizeEmail(req.body.email);

        if (!isValidEmail(email)) {
            return res.status(400).json({
                success: false,
                message: "Enter a valid email address."
            });
        }

        const db = getDb(req);

        const [users] = await queryDatabase(
            db,
            `SELECT user_id, email, role, is_active, email_verified_at
             FROM users
             WHERE LOWER(TRIM(email)) = ?
             LIMIT 1`,
            [email]
        );

        if (!users.length) {
            return res.json({
                success: true,
                message: "If the account exists, a new code will be sent."
            });
        }

        const user = users[0];
        const role = String(user.role || "").trim().toLowerCase();

        if (!["user", "admin", "main_admin"].includes(role)) {
            return res.json({
                success: true,
                message: "If eligible, a new code will be sent."
            });
        }

        if (
            role !== "user" &&
            (Number(user.is_active) !== 1 || !user.email_verified_at)
        ) {
            return res.json({
                success: true,
                message: "If eligible, a new code will be sent."
            });
        }

        if (role === "user") {
            const [customers] = await queryDatabase(
                db,
                `SELECT customer_id, status
                 FROM Customer
                 WHERE LOWER(TRIM(email)) = ?
                 LIMIT 1`,
                [email]
            );

            if (
                !customers.length ||
                String(customers[0].status || "").toLowerCase() !== "active"
            ) {
                return res.json({
                    success: true,
                    message: "If eligible, a new code will be sent."
                });
            }
        }

        await issueOtp(db, user, "login");

        return res.json({
            success: true,
            message: "If eligible, a new login code has been sent."
        });
    } catch (error) {
        return sendServerError(
            res,
            error,
            "Could not resend the login code."
        );
    }
});

// =========================================================
// VERIFY LOGIN OTP â€” ISSUE JWT
// =========================================================

router.post("/verify-email-code", async (req, res) => {
    try {
        if (!validateJwtConfiguration(res)) return;

        const email = normalizeEmail(req.body.email);
        const code = String(req.body.code || req.body.otp || "").trim();

        if (!isValidEmail(email) || !/^\d{6}$/.test(code)) {
            return res.status(400).json({
                success: false,
                message: "Enter a valid email and six-digit code."
            });
        }

        const db = getDb(req);
        const result = await findValidOtp(db, email, "login", code);

        if (!result.valid) {
            return res.status(400).json({
                success: false,
                message: result.message
            });
        }

        const [users] = await queryDatabase(
            db,
            `SELECT user_id, name, email, phone, role,
                    email_verified_at, token_version, is_active
             FROM users
             WHERE user_id = ?
               AND LOWER(TRIM(email)) = ?
             LIMIT 1`,
            [result.record.user_id, email]
        );

        if (!users.length) {
            return res.status(401).json({
                success: false,
                message:
                    "Account not found. Please log in again."
            });
        }

        const user = users[0];
        const role = String(user.role || "").trim().toLowerCase();

        if (!["user", "admin", "main_admin"].includes(role)) {
            return res.status(403).json({
                success: false,
                message: "This account has an invalid role."
            });
        }

        if (
            role !== "user" &&
            (Number(user.is_active) !== 1 || !user.email_verified_at)
        ) {
            return res.status(403).json({
                success: false,
                message:
                    "This administrator account is inactive or its email is unverified."
            });
        }

        if (role === "user") {
            const [customers] = await queryDatabase(
                db,
                `SELECT customer_id, status
                 FROM Customer
                 WHERE LOWER(TRIM(email)) = ?
                 LIMIT 1`,
                [email]
            );

            if (
                !customers.length ||
                String(customers[0].status || "").toLowerCase() !== "active"
            ) {
                return res.status(403).json({
                    success: false,
                    message:
                        "Your bank customer profile is unavailable or inactive."
                });
            }
        }

        if (!(await consumeOtp(db, result.record.id))) {
            return res.status(400).json({
                success: false,
                message: "The code expired or was already used."
            });
        }

        await queryDatabase(
            db,
            `UPDATE users
             SET email_verified_at = COALESCE(email_verified_at, NOW())
             WHERE user_id = ?`,
            [user.user_id]
        );

        user.role = role;
        const token = createAccessToken(user);

        return res.json({
            success: true,
            message: "Email verified. Login successful.",
            token,
            user: publicUser(user)
        });
    } catch (error) {
        return sendServerError(
            res,
            error,
            "Login verification failed."
        );
    }
});

// =========================================================
// FORGOT PASSWORD â€” SEND RESET CODE
// =========================================================

router.post("/forgot-password", async (req, res) => {
    try {
        const email = normalizeEmail(req.body.email);

        if (!isValidEmail(email)) {
            return res.status(400).json({
                success: false,
                message: "Enter a valid email address."
            });
        }

        const db = getDb(req);

        const [users] = await queryDatabase(
            db,
            `SELECT user_id, email, role, is_active
             FROM users
             WHERE LOWER(TRIM(email)) = ?
             LIMIT 1`,
            [email]
        );

        // Do not reveal whether an account exists.
        if (!users.length) {
            return res.json({
                success: true,
                message:
                    "If the account exists, a reset code will be sent."
            });
        }

        const role = String(users[0].role || "").trim().toLowerCase();

        if (!["user", "admin", "main_admin"].includes(role)) {
            return res.json({
                success: true,
                message:
                    "If the account exists, a reset code will be sent."
            });
        }

        if (role !== "user" && Number(users[0].is_active) !== 1) {
            return res.json({
                success: true,
                message:
                    "If the account exists, a reset code will be sent."
            });
        }

        await issueOtp(db, users[0], "password_reset");

        return res.json({
            success: true,
            message:
                "If the account exists, a reset code will be sent."
        });
    } catch (error) {
        return sendServerError(
            res,
            error,
            "Could not process the password reset."
        );
    }
});

// =========================================================
// VERIFY PASSWORD-RESET OTP
// =========================================================

router.post("/verify-password-reset-code", async (req, res) => {
    try {
        if (!validateJwtConfiguration(res)) return;

        const email = normalizeEmail(req.body.email);
        const code = String(req.body.code || req.body.otp || "").trim();

        if (!isValidEmail(email) || !/^\d{6}$/.test(code)) {
            return res.status(400).json({
                success: false,
                message: "Enter a valid email and six-digit code."
            });
        }

        const db = getDb(req);
        const result = await findValidOtp(
            db,
            email,
            "password_reset",
            code
        );

        if (!result.valid) {
            return res.status(400).json({
                success: false,
                message: result.message
            });
        }

        const [users] = await queryDatabase(
            db,
            `SELECT user_id, email, role, is_active
             FROM users
             WHERE user_id = ?
               AND LOWER(TRIM(email)) = ?
             LIMIT 1`,
            [result.record.user_id, email]
        );

        if (!users.length) {
            return res.status(400).json({
                success: false,
                message:
                    "The account is unavailable. Request a new reset code."
            });
        }

        const user = users[0];
        const role = String(user.role || "").trim().toLowerCase();

        if (
            !["user", "admin", "main_admin"].includes(role) ||
            (role !== "user" && Number(user.is_active) !== 1)
        ) {
            return res.status(400).json({
                success: false,
                message: "The account is unavailable or inactive."
            });
        }

        const [active] = await queryDatabase(
            db,
            `SELECT id
             FROM email_verification_codes
             WHERE id = ?
               AND user_id = ?
               AND email = ?
               AND purpose = 'password_reset'
               AND consumed_at IS NULL
               AND expires_at > NOW()
               AND attempts < ?
             LIMIT 1`,
            [
                result.record.id,
                user.user_id,
                email,
                MAX_OTP_ATTEMPTS
            ]
        );

        if (!active.length) {
            return res.status(400).json({
                success: false,
                message: "The reset code expired or was already used."
            });
        }

        const resetToken = jwt.sign(
            {
                purpose: "password_reset",
                userId: Number(user.user_id),
                email,
                otpId: Number(result.record.id)
            },
            process.env.JWT_SECRET,
            {
                algorithm: "HS256",
                expiresIn: RESET_TOKEN_EXPIRY
            }
        );

        return res.json({
            success: true,
            verified: true,
            resetToken,
            message:
                "Email verified. You can now create a new password."
        });
    } catch (error) {
        return sendServerError(
            res,
            error,
            "Password-reset verification failed."
        );
    }
});

// =========================================================
// RESET PASSWORD
// =========================================================

router.post("/reset-password", async (req, res) => {
    try {
        if (!validateJwtConfiguration(res)) return;

        const email = normalizeEmail(req.body.email);
        const resetToken = String(req.body.resetToken || "");
        const newPassword = String(req.body.newPassword || "");
        const confirmPassword = String(req.body.confirmPassword || "");

        if (!isValidEmail(email) || !resetToken) {
            return res.status(400).json({
                success: false,
                message:
                    "Verify your email code before resetting your password."
            });
        }

        if (!isStrongPassword(newPassword)) {
            return res.status(400).json({
                success: false,
                code: "WEAK_PASSWORD",
                message:
                    "Password must be 6 to 128 characters and contain at least one uppercase letter, one lowercase letter, one number, and one special character."
            });
        }

        if (newPassword !== confirmPassword) {
            return res.status(400).json({
                success: false,
                message: "The passwords do not match."
            });
        }

        let claims;

        try {
            claims = jwt.verify(
                resetToken,
                process.env.JWT_SECRET,
                { algorithms: ["HS256"] }
            );
        } catch {
            return res.status(401).json({
                success: false,
                code: "RESET_TOKEN_INVALID",
                message:
                    "Your password-reset verification expired. Please verify a new code."
            });
        }

        if (
            claims.purpose !== "password_reset" ||
            normalizeEmail(claims.email) !== email ||
            !Number.isSafeInteger(Number(claims.userId)) ||
            !Number.isSafeInteger(Number(claims.otpId))
        ) {
            return res.status(401).json({
                success: false,
                message:
                    "Invalid password-reset authorization. Verify your code again."
            });
        }

        const passwordHash = await bcrypt.hash(newPassword, 12);
        const db = getDb(req);
        const connection = await getConnection(db);
        let started = false;

        try {
            await beginTransaction(connection);
            started = true;

            // Lock the exact OTP record to prevent concurrent reuse.
            const [codes] = await queryConnection(
                connection,
                `SELECT id, user_id
                 FROM email_verification_codes
                 WHERE id = ?
                   AND user_id = ?
                   AND email = ?
                   AND purpose = 'password_reset'
                   AND consumed_at IS NULL
                   AND expires_at > NOW()
                   AND attempts < ?
                 FOR UPDATE`,
                [
                    Number(claims.otpId),
                    Number(claims.userId),
                    email,
                    MAX_OTP_ATTEMPTS
                ]
            );

            if (!codes.length) {
                await rollbackTransaction(connection);
                started = false;

                return res.status(400).json({
                    success: false,
                    message:
                        "The reset code expired or was already used. Request a new code."
                });
            }

            const [updated] = await queryConnection(
                connection,
                `UPDATE users
                 SET password = ?,
                     token_version = COALESCE(token_version, 0) + 1
                 WHERE user_id = ?
                   AND LOWER(TRIM(email)) = ?
                   AND (
                       LOWER(TRIM(role)) = 'user'
                       OR (
                           LOWER(TRIM(role)) IN ('admin', 'main_admin')
                           AND is_active = 1
                       )
                   )`,
                [passwordHash, Number(claims.userId), email]
            );

            if (updated.affectedRows !== 1) {
                await rollbackTransaction(connection);
                started = false;

                return res.status(400).json({
                    success: false,
                    message: "The account is unavailable or inactive."
                });
            }

            // Consume this OTP and all other pending codes for the email.
            await queryConnection(
                connection,
                `UPDATE email_verification_codes
                 SET consumed_at = NOW()
                 WHERE id = ?
                   AND consumed_at IS NULL`,
                [Number(claims.otpId)]
            );

            await queryConnection(
                connection,
                `UPDATE email_verification_codes
                 SET consumed_at = NOW()
                 WHERE email = ?
                   AND consumed_at IS NULL`,
                [email]
            );

            await commitTransaction(connection);
            started = false;
        } catch (error) {
            if (started) await rollbackTransaction(connection);
            throw error;
        } finally {
            releaseConnection(connection);
        }

        // The password is committed. Email failure must not undo the reset.
        let confirmationEmailSent = true;


try {
    await sendPasswordResetConfirmationEmail(email);
} catch (emailError) {
    confirmationEmailSent = false;

    console.error(
        "[IBI AUTH] Password-change confirmation email failed:",
        {
            name: emailError.name,
            code: emailError.code,
            responseCode: emailError.responseCode,
            command: emailError.command,
            message: emailError.message
        }
    );
}

        return res.json({
            success: true,
            passwordChanged: true,
            confirmationEmailSent,
            message: confirmationEmailSent
                ? "Password changed successfully. A confirmation email has been sent to your registered email address. Please log in."
                : "Password changed successfully, but the confirmation email could not be sent. Please log in and check your email settings."
        });
    } catch (error) {
        return sendServerError(
            res,
            error,
            "Password reset failed."
        );
    }
});

// =========================================================
// ADMIN ACCOUNT OPTIONS
// =========================================================

router.get(
    "/admin/account-options",
    requireAuth,
    requireAdmin,
    async (req, res) => {
        try {
            const db = getDb(req);

            const [branches] = await queryDatabase(
                db,
                `SELECT branch_id, branch_name, city
                 FROM Branch
                 ORDER BY branch_name`
            );

            const [accountTypes] = await queryDatabase(
                db,
                `SELECT account_type_id, type_name,
                        minimum_balance, interest_rate
                 FROM Account_Type
                 ORDER BY type_name`
            );

            return res.json({
                success: true,
                branches,
                accountTypes
            });
        } catch (error) {
            return sendServerError(
                res,
                error,
                "Could not load branch and account-type options."
            );
        }
    }
);

// =========================================================
// ADMIN CREATE BANK ACCOUNT
// =========================================================

router.post(
    "/admin/create-account",
    requireAuth,
    requireAdmin,
    async (req, res) => {
        let connection;
        let started = false;

        try {
            const name = normalizeText(req.body.name);
            const email = normalizeEmail(req.body.email);
            const phone = normalizePhone(req.body.phone);
            const address = normalizeText(req.body.address);
            const branchId = Number(req.body.branch_id);
            const accountTypeId = Number(req.body.account_type_id);
            const openingBalance = Number(req.body.opening_balance);

            if (
                !name ||
                !email ||
                !phone ||
                !address ||
                !req.body.branch_id ||
                !req.body.account_type_id ||
                req.body.opening_balance === undefined ||
                String(req.body.opening_balance).trim() === ""
            ) {
                return res.status(400).json({
                    success: false,
                    message: "Please fill in all required fields."
                });
            }

            if (!isValidEmail(email)) {
                return res.status(400).json({
                    success: false,
                    message: "Enter a valid customer email address."
                });
            }

            if (
                !Number.isInteger(branchId) ||
                branchId <= 0 ||
                !Number.isInteger(accountTypeId) ||
                accountTypeId <= 0
            ) {
                return res.status(400).json({
                    success: false,
                    message:
                        "Select a valid branch and account type."
                });
            }

            if (
                !Number.isFinite(openingBalance) ||
                openingBalance < 0
            ) {
                return res.status(400).json({
                    success: false,
                    message:
                        "Opening balance must be zero or greater."
                });
            }

            const db = getDb(req);
            connection = await getConnection(db);
            await beginTransaction(connection);
            started = true;

            const [branches] = await queryConnection(
                connection,
                `SELECT branch_id, branch_name, city
                 FROM Branch
                 WHERE branch_id = ?
                 LIMIT 1`,
                [branchId]
            );

            const [types] = await queryConnection(
                connection,
                `SELECT account_type_id, type_name, minimum_balance
                 FROM Account_Type
                 WHERE account_type_id = ?
                 LIMIT 1`,
                [accountTypeId]
            );

            if (!branches.length || !types.length) {
                await rollbackTransaction(connection);
                started = false;

                return res.status(400).json({
                    success: false,
                    message:
                        "The selected branch or account type does not exist."
                });
            }

            const minimum = Number(types[0].minimum_balance || 0);

            if (openingBalance < minimum) {
                await rollbackTransaction(connection);
                started = false;

                return res.status(400).json({
                    success: false,
                    message: `Minimum opening balance is ${minimum}.`
                });
            }

            const [users] = await queryConnection(
                connection,
                `SELECT user_id, email, phone, role
                 FROM users
                 WHERE LOWER(TRIM(email)) = ?
                    OR TRIM(phone) = ?
                 FOR UPDATE`,
                [email, phone]
            );

            const emailUser = users.find(
                user => normalizeEmail(user.email) === email
            );

            const phoneConflict = users.some(
                user =>
                    normalizePhone(user.phone) === phone &&
                    normalizeEmail(user.email) !== email
            );

            if (
                phoneConflict ||
                (
                    emailUser &&
                    String(emailUser.role).trim().toLowerCase() !== "user"
                )
            ) {
                await rollbackTransaction(connection);
                started = false;

                return res.status(409).json({
                    success: false,
                    message:
                        "The email or phone belongs to another login."
                });
            }

            const [customers] = await queryConnection(
                connection,
                `SELECT customer_id, name, email, phone, address, status
                 FROM Customer
                 WHERE LOWER(TRIM(email)) = ?
                    OR TRIM(phone) = ?
                 FOR UPDATE`,
                [email, phone]
            );

            const emailCustomer = customers.find(
                customer => normalizeEmail(customer.email) === email
            );

            const phoneCustomerConflict = customers.some(
                customer =>
                    normalizePhone(customer.phone) === phone &&
                    normalizeEmail(customer.email) !== email
            );

            if (phoneCustomerConflict) {
                await rollbackTransaction(connection);
                started = false;

                return res.status(409).json({
                    success: false,
                    message:
                        "The phone number belongs to a different customer."
                });
            }

            let customerId;
            let customer;

            if (emailCustomer) {
                if (
                    emailCustomer.status &&
                    String(emailCustomer.status).toLowerCase() !== "active"
                ) {
                    await rollbackTransaction(connection);
                    started = false;

                    return res.status(409).json({
                        success: false,
                        message: "The customer profile is not active."
                    });
                }

                if (
                    normalizeText(emailCustomer.name).toLowerCase() !==
                        name.toLowerCase() ||
                    normalizePhone(emailCustomer.phone) !== phone
                ) {
                    await rollbackTransaction(connection);
                    started = false;

                    return res.status(409).json({
                        success: false,
                        message:
                            "Name or phone does not match the existing customer record."
                    });
                }

                customerId = emailCustomer.customer_id;
                customer = emailCustomer;
            } else {
                const [inserted] = await queryConnection(
                    connection,
                    `INSERT INTO Customer
                        (name, email, phone, address, status)
                     VALUES (?, ?, ?, ?, 'Active')`,
                    [name, email, phone, address]
                );

                customerId = inserted.insertId;
                customer = {
                    customer_id: customerId,
                    name,
                    email,
                    phone,
                    address,
                    status: "Active"
                };
            }

            const [existingAccounts] = await queryConnection(
                connection,
                `SELECT account_id, account_number, account_type_id,
                        balance, status
                 FROM Account
                 WHERE customer_id = ?
                 FOR UPDATE`,
                [customerId]
            );

            if (existingAccounts.length) {
                await rollbackTransaction(connection);
                started = false;

                return res.status(409).json({
                    success: false,
                    message: "This customer already has a bank account.",
                    existingAccount: existingAccounts[0]
                });
            }

            let accountNumber;
            let accountResult;
            let created = false;

            for (let attempt = 0; attempt < 10; attempt++) {
                accountNumber = String(
                    crypto.randomInt(100000000000, 1000000000000)
                );

                try {
                    const [inserted] = await queryConnection(
                        connection,
                        `INSERT INTO Account
                            (customer_id, branch_id, account_type_id,
                             account_number, balance, status)
                         VALUES (?, ?, ?, ?, ?, 'Active')`,
                        [
                            customerId,
                            branchId,
                            accountTypeId,
                            accountNumber,
                            openingBalance
                        ]
                    );

                    accountResult = inserted;
                    created = true;
                    break;
                } catch (error) {
                    if (isDuplicateEntry(error)) continue;
                    throw error;
                }
            }

            if (!created) {
                throw new Error(
                    "Could not generate a unique account number."
                );
            }

            await commitTransaction(connection);
            started = false;

            return res.status(201).json({
                success: true,
                message: emailUser
                    ? "Bank account created and linked to the existing login."
                    : "Bank account created successfully.",
                linkedExistingLogin: Boolean(emailUser),
                customer: {
                    customer_id: customerId,
                    name: customer.name,
                    email: customer.email,
                    phone: customer.phone,
                    address: customer.address,
                    status: customer.status
                },
                account: {
                    account_id: accountResult.insertId,
                    account_number: accountNumber,
                    branch_id: branchId,
                    branch_name: branches[0].branch_name,
                    account_type_id: accountTypeId,
                    account_type: types[0].type_name,
                    balance: openingBalance,
                    status: "Active"
                }
            });
        } catch (error) {
            if (connection && started) {
                try {
                    await rollbackTransaction(connection);
                } catch (rollbackError) {
                    console.error(
                        "Rollback failed:",
                        rollbackError.message
                    );
                }
            }

            if (isDuplicateEntry(error)) {
                return res.status(409).json({
                    success: false,
                    message:
                        "A duplicate customer, login, or account was detected."
                });
            }

            return sendServerError(
                res,
                error,
                "Could not create the bank account."
            );
        } finally {
            if (connection) releaseConnection(connection);
        }
    }
);

// =========================================================
// EXPORT ROUTER
// =========================================================

module.exports = router;