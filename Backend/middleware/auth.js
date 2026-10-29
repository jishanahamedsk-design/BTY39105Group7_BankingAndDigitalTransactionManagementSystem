
"use strict";

const jwt = require("jsonwebtoken");

// =========================================================
// DATABASE HELPER
// =========================================================

function getDb(req) {
    return req.app.get("db");
}

// =========================================================
// AUTHENTICATION
// Verify the JWT and then verify the current account in MySQL.
// Never trust the role or active status from localStorage.
// =========================================================

function requireAuth(req, res, next) {
    const secret = process.env.JWT_SECRET;

    if (!secret) {
        console.error("JWT_SECRET is missing from Backend/.env");

        return res.status(500).json({
            success: false,
            message: "Authentication is not configured."
        });
    }

    const authorization = String(req.headers.authorization || "");
    const parts = authorization.trim().split(/\s+/);

    if (
        parts.length !== 2 ||
        parts[0].toLowerCase() !== "bearer" ||
        !parts[1]
    ) {
        return res.status(401).json({
            success: false,
            message: "Please log in to access this resource."
        });
    }

    let payload;

    try {
        payload = jwt.verify(parts[1], secret, {
            algorithms: ["HS256"]
        });
    } catch (error) {
        return res.status(401).json({
            success: false,
            message: "Your session is invalid or expired. Please log in again."
        });
    }

    if (
        !payload ||
        !Number.isSafeInteger(payload.userId) ||
        payload.userId <= 0 ||
        !Number.isSafeInteger(payload.tokenVersion) ||
        payload.tokenVersion < 0 ||
        typeof payload.role !== "string"
    ) {
        return res.status(401).json({
            success: false,
            message: "Invalid authentication token."
        });
    }

    const tokenRole = payload.role.trim().toLowerCase();

    if (!["user", "admin", "main_admin"].includes(tokenRole)) {
        return res.status(403).json({
            success: false,
            message: "This account role is not authorized."
        });
    }

    const db = getDb(req);

    if (!db || typeof db.query !== "function") {
        return res.status(500).json({
            success: false,
            message: "Database connection is unavailable."
        });
    }

    db.query(
        `SELECT
            user_id,
            name,
            email,
            phone,
            role,
            email_verified_at,
            token_version,
            is_active
         FROM Users
         WHERE user_id = ?
         LIMIT 1`,
        [payload.userId],
        (error, rows) => {
            if (error) {
                console.error(
                    "Authentication database error:",
                    error.message
                );

                return res.status(500).json({
                    success: false,
                    message: "Could not verify your account."
                });
            }

            if (!rows || rows.length !== 1) {
                return res.status(401).json({
                    success: false,
                    message: "Account not found. Please log in again."
                });
            }

            const user = rows[0];
            const databaseRole = String(user.role || "")
                .trim()
                .toLowerCase();

            // Reject inactive accounts, including existing sessions.
            if (Number(user.is_active) !== 1) {
                return res.status(403).json({
                    success: false,
                    message: "Your account is inactive. Contact the Main Admin."
                });
            }

            if (!["user", "admin", "main_admin"].includes(databaseRole)) {
                return res.status(403).json({
                    success: false,
                    message: "This account role is not authorized."
                });
            }

            // The current database role must match the role in the JWT.
            if (databaseRole !== tokenRole) {
                return res.status(401).json({
                    success: false,
                    message: "Your role has changed. Please log in again."
                });
            }

            const databaseTokenVersion = Number(user.token_version);

            if (
                !Number.isSafeInteger(databaseTokenVersion) ||
                databaseTokenVersion < 0 ||
                databaseTokenVersion !== payload.tokenVersion
            ) {
                return res.status(401).json({
                    success: false,
                    message: "Your session has been revoked. Please log in again."
                });
            }

            if (!user.email_verified_at) {
                return res.status(403).json({
                    success: false,
                    code: "EMAIL_NOT_VERIFIED",
                    message: "Verify your email before accessing your account."
                });
            }

            // Trusted, database-verified identity for downstream routes.
            req.auth = Object.freeze({
                userId: Number(user.user_id),
                name: user.name,
                email: user.email,
                phone: user.phone,
                role: databaseRole,
                tokenVersion: databaseTokenVersion
            });

            return next();
        }
    );
}

// =========================================================
// ROLE AUTHORIZATION
// Use these only after requireAuth.
// =========================================================

function requireRole(...allowedRoles) {
    const normalizedRoles = allowedRoles.map(role =>
        String(role).trim().toLowerCase()
    );

    return function (req, res, next) {
        if (!req.auth) {
            return res.status(401).json({
                success: false,
                message: "Authentication is required."
            });
        }

        if (!normalizedRoles.includes(req.auth.role)) {
            return res.status(403).json({
                success: false,
                message: "You do not have permission to perform this action."
            });
        }

        return next();
    };
}

// Customers only.
const requireCustomer = requireRole("user");

// Employee administrators and the Main Admin.
const requireAdmin = requireRole("admin", "main_admin");

// Main Admin only: employee administrator management.
const requireMainAdmin = requireRole("main_admin");

module.exports = {
    requireAuth,
    requireRole,
    requireCustomer,
    requireAdmin,
    requireMainAdmin
};
