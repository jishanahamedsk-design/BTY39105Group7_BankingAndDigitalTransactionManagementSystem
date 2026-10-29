
require("dotenv").config({
    path: require("path").join(__dirname, ".env")
});


const express = require("express");
const cors = require("cors");
const cron = require("node-cron");

const db = require("./db");
const authRoutes = require("./Routes/auth");

const app = express();

app.use((req, res, next) => {
    if (
        req.method === "POST" &&
        req.originalUrl.includes("/admin-login")
    ) {
        console.log(
            "[DEBUG] Request received:",
            req.method,
            req.originalUrl
        );
    }

    next();
});
app.use((req, res, next) => {
    if (
        req.method === "DELETE" &&
        req.originalUrl.startsWith("/api/beneficiaries/")
    ) {
        console.log("DELETE REQUEST RECEIVED:", req.originalUrl);
    }

    next();
});
const PORT = 5000;

/* =========================================================
   MIDDLEWARE
========================================================= */

app.use(cors());
app.use(express.json());
app.set("db", db);

/* =========================================================
   AUTH
========================================================= */

app.use("/api/auth", authRoutes);

/* =========================================================
   HOME
========================================================= */

app.get("/", (req, res) => {
    res.send("Banking and Digital Transaction Management System API is running!");
});

/* =========================================================
   CUSTOMERS
========================================================= */

app.get("/api/customers", (req, res) => {
    const sql = `
        SELECT customer_id, name, email, phone, address,
               COALESCE(status, 'Active') AS status
        FROM Customer
        ORDER BY customer_id ASC
    `;

    db.query(sql, (err, results) => {
        if (err) {
            return res.status(500).json({
                success: false,
                message: "Failed to fetch customers.",
                error: err.sqlMessage || err.message
            });
        }
        return res.status(200).json(results);
    });
});

/* CUSTOMER - DEACTIVATE OWN ACCOUNT */

app.put("/api/customer/deactivate", (req, res) => {
    const email = String(req.query.email || "").trim();

    if (!email) {
        return res.status(400).json({
            success: false,
            message: "Customer email is required"
        });
    }

    const sql = `
        UPDATE Customer
        SET status = 'Inactive'
        WHERE email = ? AND status = 'Active'
    `;

    db.query(sql, [email], (err, result) => {
        if (err) {
            return res.status(500).json({
                success: false,
                message: "Failed to deactivate customer account"
            });
        }

        if (result.affectedRows === 0) {
            return res.status(400).json({
                success: false,
                message: "Account is already inactive or customer was not found"
            });
        }

        return res.json({
            success: true,
            message: "Your account has been deactivated. Please contact the administrator to reactivate it.",
            status: "Inactive"
        });
    });
});

/* ADMIN: DEACTIVATE CUSTOMER */

app.put("/api/admin/customers/:id/deactivate", (req, res) => {
    const customerId = Number(req.params.id);

    if (!Number.isInteger(customerId) || customerId <= 0) {
        return res.status(400).json({
            success: false,
            message: "Invalid customer ID."
        });
    }

    const sql = "UPDATE Customer SET status = 'Inactive' WHERE customer_id = ?";

    db.query(sql, [customerId], (err, result) => {
        if (err) {
            return res.status(500).json({
                success: false,
                message: err.sqlMessage || "Failed to deactivate customer."
            });
        }

        if (result.affectedRows === 0) {
            return res.status(404).json({
                success: false,
                message: "Customer not found."
            });
        }

        return res.json({
            success: true,
            message: "Customer deactivated successfully.",
            status: "Inactive"
        });
    });
});

/* ADMIN: ACTIVATE CUSTOMER */

app.put("/api/admin/customers/:id/activate", (req, res) => {
    const customerId = Number(req.params.id);

    if (!Number.isInteger(customerId) || customerId <= 0) {
        return res.status(400).json({
            success: false,
            message: "Invalid customer ID."
        });
    }

    const sql = "UPDATE Customer SET status = 'Active' WHERE customer_id = ?";

    db.query(sql, [customerId], (err, result) => {
        if (err) {
            return res.status(500).json({
                success: false,
                message: err.sqlMessage || "Failed to activate customer."
            });
        }

        if (result.affectedRows === 0) {
            return res.status(404).json({
                success: false,
                message: "Customer not found or status unchanged."
            });
        }

        return res.json({
            success: true,
            message: "Customer activated successfully.",
            status: "Active"
        });
    });
});

/* =========================================================
   ACCOUNTS
========================================================= */

app.get("/api/accounts", (req, res) => {
    const sql = `
        SELECT
            a.account_id,
            a.customer_id,
            c.name,
            c.email,
            c.phone,
            c.status AS customer_status,
            a.account_number,
            a.balance,
            CASE
                WHEN LOWER(TRIM(COALESCE(a.status, ''))) <> 'active'
                    THEN a.status
                WHEN LOWER(TRIM(COALESCE(c.status, ''))) <> 'active'
                    THEN 'Inactive'
                ELSE 'Active'
            END AS status,
            b.branch_id,
            b.branch_name,
            b.IFSC,
            at.account_type_id,
            at.type_name,
            at.interest_rate,
            at.minimum_balance
        FROM Account AS a
        INNER JOIN Customer AS c ON a.customer_id = c.customer_id
        INNER JOIN Branch AS b ON a.branch_id = b.branch_id
        INNER JOIN Account_Type AS at ON a.account_type_id = at.account_type_id
        ORDER BY a.account_id ASC
    `;

    db.query(sql, (err, results) => {
        if (err) {
            return res.status(500).json({
                error: "Failed to fetch accounts"
            });
        }
        return res.status(200).json(results);
    });
});

/* =========================================================
   ACCOUNT TYPES
========================================================= */

app.get("/api/account-types", (req, res) => {
    const sql = `
        SELECT account_type_id, type_name, interest_rate, minimum_balance
        FROM Account_Type
        ORDER BY account_type_id
    `;

    db.query(sql, (err, results) => {
        if (err) {
            return res.status(500).json({
                success: false,
                message: "Failed to fetch account types"
            });
        }
        res.json(results);
    });
});

/* =========================================
   GET BRANCHES
========================================= */
app.get("/api/branches", (req, res) => {
    const sql = `
        SELECT branch_id, branch_name, IFSC, city
        FROM Branch
        ORDER BY branch_id ASC
    `;

    db.query(sql, (err, results) => {
        if (err) {
            console.error("Failed to fetch branches:", err);

            return res.status(500).json({
                success: false,
                message: "Failed to fetch branches."
            });
        }

        return res.json(results);
    });
});
/* =========================================================
   TRANSACTIONS
========================================================= */

app.get("/api/transactions", (req, res) => {
    const sql = `
        SELECT
            t.transaction_id,
            t.account_id,
            a.account_number,
            c.customer_id,
            c.name,
            c.email,
            t.transaction_type,
            t.amount,
            t.transaction_date,
            t.description
        FROM \`Transaction\` t
        INNER JOIN Account a ON t.account_id = a.account_id
        INNER JOIN Customer c ON a.customer_id = c.customer_id
        ORDER BY t.transaction_date DESC
    `;

    db.query(sql, (err, results) => {
        if (err) {
            return res.status(500).json({
                error: "Failed to fetch transactions"
            });
        }
        res.json(results);
    });
});

/* =========================================================
   ALL BENEFICIARIES
========================================================= */

app.get("/api/beneficiaries", (req, res) => {
    const sql = `
        SELECT
            b.beneficiary_id,
            b.account_id,
            owner.account_number AS owner_account_number,
            owner.customer_id,
            owner_customer.name AS owner_name,
            owner_customer.email AS owner_email,
            b.beneficiary_name,
            b.beneficiary_account_no,
            b.bank_name,
            b.IFSC,
            b.account_type_id,
            at.type_name AS account_type,
            b.status
        FROM Beneficiary b
        INNER JOIN Account owner ON b.account_id = owner.account_id
        INNER JOIN Customer owner_customer ON owner.customer_id = owner_customer.customer_id
        LEFT JOIN Account_Type at ON b.account_type_id = at.account_type_id
        ORDER BY b.beneficiary_id
    `;

    db.query(sql, (err, results) => {
        if (err) {
            return res.status(500).json({
                success: false,
                error: "Failed to fetch beneficiaries"
            });
        }
        res.json(results);
    });
});


/* =========================================================
   MY BENEFICIARIES
   - Fetch beneficiaries belonging to the logged-in customer
   - Hide soft-deleted beneficiaries
   - Preserve existing beneficiary and transfer history
========================================================= */

app.get("/api/my-beneficiaries", (req, res) => {
    const email = String(req.query.email || "").trim();

    if (!email) {
        return res.status(400).json({
            success: false,
            message: "Email is required"
        });
    }

    const sql = `
        SELECT
            b.beneficiary_id,
            b.account_id,
            owner.account_number AS owner_account_number,
            b.beneficiary_name,
            b.beneficiary_account_no,
            b.bank_name,
            b.IFSC,
            b.account_type_id,
            at.type_name AS account_type,
            b.status
        FROM Beneficiary b

        INNER JOIN Account owner
            ON b.account_id = owner.account_id

        INNER JOIN Customer c
            ON owner.customer_id = c.customer_id

        LEFT JOIN Account_Type at
            ON b.account_type_id = at.account_type_id

        WHERE LOWER(TRIM(c.email)) = LOWER(TRIM(?))
          AND b.deleted_at IS NULL

        ORDER BY b.beneficiary_id DESC
    `;

    db.query(sql, [email], (err, results) => {
        if (err) {
            console.error(
                "Failed to fetch beneficiaries:",
                err.message
            );

            return res.status(500).json({
                success: false,
                message: "Failed to fetch your beneficiaries"
            });
        }

        return res.status(200).json(results);
    });
});

/* =========================================================
   ADD BENEFICIARY
   ONE ACTIVE BENEFICIARY PER CUSTOMER
========================================================= */

app.post("/api/beneficiaries", (req, res) => {
    const {
        customer_email,
        beneficiary_name,
        beneficiary_account_no
    } = req.body;

    const email = String(customer_email || "").trim();
    const name = String(beneficiary_name || "").trim();
    const accountNo = String(beneficiary_account_no || "").trim().toUpperCase();

    if (!email) {
        return res.status(400).json({
            success: false,
            message: "Customer email is required"
        });
    }

    if (!name || name.length < 2 || name.length > 100) {
        return res.status(400).json({
            success: false,
            message: "Please enter a valid beneficiary name"
        });
    }

    if (!accountNo || accountNo.length < 5 || accountNo.length > 20) {
        return res.status(400).json({
            success: false,
            message: "Please enter a valid beneficiary account number"
        });
    }

    const ownerSQL = `
        SELECT
            c.customer_id,
            c.name AS customer_name,
            c.email,
            c.status AS customer_status,
            a.account_id,
            a.account_number,
            a.status
        FROM Customer c
        INNER JOIN Account a ON c.customer_id = a.customer_id
        WHERE c.email = ?
        ORDER BY a.account_id
        LIMIT 1
    `;

    db.query(ownerSQL, [email], (ownerError, ownerResults) => {
        if (ownerError) {
            return res.status(500).json({
                success: false,
                message: "Failed to find customer account"
            });
        }

        if (ownerResults.length === 0) {
            return res.status(404).json({
                success: false,
                message: "Customer account not found"
            });
        }

        const owner = ownerResults[0];

        if (String(owner.customer_status).toLowerCase() !== "active") {
            return res.status(403).json({
                success: false,
                message: "Your customer account is inactive. Please contact the administrator."
            });
        }

        if (owner.status !== "Active") {
            return res.status(400).json({
                success: false,
                message: "Your bank account is not active"
            });
        }

        const activeSQL = `
            SELECT COUNT(*) AS active_count
            FROM Beneficiary b
            INNER JOIN Account a ON b.account_id = a.account_id
            WHERE a.customer_id = ?
              AND b.status = 'Active'
        `;

        db.query(activeSQL, [owner.customer_id], (activeError, activeResults) => {
            if (activeError) {
                return res.status(500).json({
                    success: false,
                    message: "Failed to check active beneficiary"
                });
            }

            if (Number(activeResults[0].active_count) >= 1) {
                return res.status(400).json({
                    success: false,
                    message: "You can have only one active beneficiary at a time. Deactivate the current beneficiary before adding another."
                });
            }

            const beneficiarySQL = `
                SELECT
                    a.account_id,
                    a.account_number,
                    a.customer_id,
                    a.account_type_id,
                    a.branch_id,
                    a.status,
                    c.name AS customer_name,
                    c.email AS customer_email,
                    at.type_name AS account_type,
                    br.branch_name,
                    br.IFSC
                FROM Account a
                INNER JOIN Customer c ON a.customer_id = c.customer_id
                INNER JOIN Account_Type at ON a.account_type_id = at.account_type_id
                LEFT JOIN Branch br ON a.branch_id = br.branch_id
                WHERE a.account_number = ?
                LIMIT 1
            `;

            db.query(beneficiarySQL, [accountNo], (beneficiaryError, beneficiaryResults) => {
                if (beneficiaryError) {
                    return res.status(500).json({
                        success: false,
                        message: "Failed to verify beneficiary account"
                    });
                }

                if (beneficiaryResults.length === 0) {
                    return res.status(404).json({
                        success: false,
                        message: "Beneficiary account does not exist"
                    });
                }

                const target = beneficiaryResults[0];

                if (Number(target.account_id) === Number(owner.account_id)) {
                    return res.status(400).json({
                        success: false,
                        message: "You cannot add your own account as beneficiary"
                    });
                }

                if (target.status !== "Active") {
                    return res.status(400).json({
                        success: false,
                        message: "The beneficiary account is not active"
                    });
                }

                const dbName = String(target.customer_name || "")
                    .trim().replace(/\s+/g, " ").toLowerCase();

                const enteredName = name
                    .trim().replace(/\s+/g, " ").toLowerCase();

                if (dbName !== enteredName) {
                    return res.status(400).json({
                        success: false,
                        message: "Beneficiary name does not match the account"
                    });
                }

                const duplicateSQL = `
                    SELECT b.beneficiary_id, b.status AS beneficiary_status
                    FROM Beneficiary b
                    INNER JOIN Account a ON b.account_id = a.account_id
                    WHERE a.customer_id = ?
                      AND b.beneficiary_account_no = ?
                    LIMIT 1
                `;

                db.query(duplicateSQL, [owner.customer_id, accountNo], (duplicateError, duplicateResults) => {
                    if (duplicateError) {
                        return res.status(500).json({
                            success: false,
                            message: "Failed to check existing beneficiary"
                        });
                    }

                    if (duplicateResults.length > 0) {
                        const existing = duplicateResults[0];

                        if (existing.beneficiary_status === "Active") {
                            return res.status(400).json({
                                success: false,
                                message: "This beneficiary is already active"
                            });
                        }

                        if (existing.beneficiary_status === "Inactive") {
                            return res.status(400).json({
                                success: false,
                                message: "This beneficiary already exists as inactive. Delete the inactive beneficiary before adding it again."
                            });
                        }
                    }

                    const insertSQL = `
                        INSERT INTO Beneficiary
                        (
                            account_id,
                            beneficiary_name,
                            beneficiary_account_no,
                            bank_name,
                            IFSC,
                            account_type_id,
                            status
                        )
                        VALUES (?, ?, ?, ?, ?, ?, 'Active')
                    `;

                    db.query(insertSQL, [
                        owner.account_id,
                        target.customer_name,
                        target.account_number,
                        target.branch_name || "Bank",
                        target.IFSC || "",
                        target.account_type_id
                    ], (insertError, insertResult) => {
                        if (insertError) {
                            return res.status(500).json({
                                success: false,
                                message: "Failed to add beneficiary"
                            });
                        }

                        res.status(201).json({
                            success: true,
                            message: "Beneficiary added successfully",
                            beneficiary_id: insertResult.insertId
                        });
                    });
                });
            });
        });
    });
});

/* =========================================================
   DEACTIVATE BENEFICIARY
========================================================= */

app.put("/api/beneficiaries/:id/deactivate", (req, res) => {
    const beneficiaryId = req.params.id;
    const email = String(req.query.email || "").trim();

    if (!email) {
        return res.status(400).json({
            success: false,
            message: "Customer email is required"
        });
    }

    const customerStatusSQL = `
        SELECT status FROM Customer WHERE email = ? LIMIT 1
    `;

    db.query(customerStatusSQL, [email], (customerStatusError, customerStatusResults) => {
        if (customerStatusError) {
            return res.status(500).json({
                success: false,
                message: "Failed to verify customer status"
            });
        }

        if (customerStatusResults.length === 0) {
            return res.status(404).json({
                success: false,
                message: "Customer not found"
            });
        }

        if (customerStatusResults[0].status !== "Active") {
            return res.status(403).json({
                success: false,
                message: "Your customer account is inactive. Please contact the administrator."
            });
        }

        const sql = `
            UPDATE Beneficiary b
            INNER JOIN Account a ON b.account_id = a.account_id
            INNER JOIN Customer c ON a.customer_id = c.customer_id
            SET b.status = 'Inactive'
            WHERE b.beneficiary_id = ?
              AND c.email = ?
              AND b.status = 'Active'
        `;

        db.query(sql, [beneficiaryId, email], (err, result) => {
            if (err) {
                return res.status(500).json({
                    success: false,
                    message: "Failed to deactivate beneficiary"
                });
            }

            if (result.affectedRows === 0) {
                return res.status(404).json({
                    success: false,
                    message: "Active beneficiary not found"
                });
            }

            res.json({
                success: true,
                message: "Beneficiary deactivated successfully"
            });
        });
    });
});





/* =====================================================
   DELETE INACTIVE BENEFICIARY
   IBI BANK — preserves existing transfer history
===================================================== */

app.delete("/api/beneficiaries/:id", (req, res) => {
    const beneficiaryId = Number(req.params.id);
    const email = String(req.query.email || "").trim();

    if (!Number.isInteger(beneficiaryId) || beneficiaryId <= 0) {
        return res.status(400).json({
            success: false,
            message: "Invalid beneficiary ID."
        });
    }

    if (!email) {
        return res.status(400).json({
            success: false,
            message: "Customer email is required."
        });
    }

    // Match the actual beneficiary row and verify ownership.
    const checkSql = `
        SELECT
            b.beneficiary_id,
            b.account_id,
            b.status,
            c.email
        FROM Beneficiary b
        INNER JOIN Account a
            ON a.account_id = b.account_id
        INNER JOIN Customer c
            ON c.customer_id = a.customer_id
        WHERE b.beneficiary_id = ?
          AND LOWER(TRIM(c.email)) = LOWER(TRIM(?))
        LIMIT 1
    `;

    db.query(checkSql, [beneficiaryId, email], (checkErr, rows) => {
        if (checkErr) {
            console.error("Beneficiary lookup error:", checkErr.sqlMessage || checkErr.message);
            return res.status(500).json({
                success: false,
                message: "Database error while checking beneficiary."
            });
        }

        if (!rows || rows.length === 0) {
            return res.status(404).json({
                success: false,
                message: "Beneficiary ID or customer email does not match."
            });
        }

        const beneficiary = rows[0];
        const status = String(beneficiary.status || "").trim().toLowerCase();

        if (status !== "inactive") {
            return res.status(400).json({
                success: false,
                message: "Only inactive beneficiaries can be deleted."
            });
        }

        const deleteSql = `
            UPDATE Beneficiary
            SET deleted_at = CURRENT_TIMESTAMP
            WHERE beneficiary_id = ?
              AND deleted_at IS NULL
        `;

        db.query(deleteSql, [beneficiaryId], (deleteErr, result) => {
            if (deleteErr) {
                console.error("Beneficiary delete error:", deleteErr.sqlMessage || deleteErr.message);
                return res.status(500).json({
                    success: false,
                    message: "Database error while deleting beneficiary."
                });
            }

            if (result.affectedRows !== 1) {
                return res.status(404).json({
                    success: false,
                    message: "This beneficiary was already deleted."
                });
            }

            return res.json({
                success: true,
                message: "Inactive beneficiary deleted successfully.",
                beneficiary_id: beneficiaryId
            });
        });
    });
});

/* =========================================================
   FUND TRANSFER HISTORY
========================================================= */

app.get("/api/transfers", (req, res) => {
    const sql = `
        SELECT
            ft.transfer_id,
            ft.sender_account_id,
            sender.account_number AS sender_account_number,
            ft.receiver_account_id,
            receiver.account_number AS receiver_account_number,
            ft.beneficiary_id,
            ben.beneficiary_name,
            ben.beneficiary_account_no,
            ft.amount,
            ft.transfer_date,
            ft.status,
            ft.reference_no
        FROM Fund_Transfer ft
        INNER JOIN Account sender ON ft.sender_account_id = sender.account_id
        LEFT JOIN Account receiver ON ft.receiver_account_id = receiver.account_id
        LEFT JOIN Beneficiary ben ON ft.beneficiary_id = ben.beneficiary_id
        ORDER BY ft.transfer_date DESC
    `;

    db.query(sql, (err, results) => {
        if (err) {
            return res.status(500).json({
                error: "Failed to fetch fund transfers"
            });
        }
        res.json(results);
    });
});

/* =========================================================
   LOANS
========================================================= */

app.get("/api/loans", (req, res) => {
    const sql = `
        SELECT
            l.loan_id,
            l.customer_id,
            c.name,
            c.email,
            l.loan_type,
            l.principal_amount,
            l.interest_rate,
            l.tenure_months,
            l.status
        FROM Loan l
        INNER JOIN Customer c ON l.customer_id = c.customer_id
        ORDER BY l.loan_id
    `;

    db.query(sql, (err, results) => {
        if (err) {
            return res.status(500).json({
                error: "Failed to fetch loans"
            });
        }
        res.json(results);
    });
});

/* =========================================================
   LOAN TYPES
========================================================= */

app.get("/api/loan-types", (req, res) => {
    const sql = `
        SELECT loan_type_id, loan_type, interest_rate
        FROM Loan_Type
        ORDER BY loan_type_id
    `;

    db.query(sql, (err, results) => {
        if (err) {
            return res.status(500).json({
                success: false,
                message: "Failed to fetch loan types"
            });
        }
        res.json(results);
    });
});

/* =========================================================
   APPLY FOR LOAN
========================================================= */

app.post("/api/loans/apply", (req, res) => {
    const {
        customer_email,
        loan_type_id,
        principal_amount,
        tenure_months
    } = req.body;

    const email = String(customer_email || "").trim();
    const loanTypeId = Number(loan_type_id);
    const principalAmount = Number(principal_amount);
    const tenureMonths = Number(tenure_months);

    if (!email) {
        return res.status(400).json({
            success: false,
            message: "Customer email is required"
        });
    }

    if (!Number.isInteger(loanTypeId) || loanTypeId <= 0) {
        return res.status(400).json({
            success: false,
            message: "Please select a valid loan type"
        });
    }

    if (!Number.isFinite(principalAmount) || principalAmount <= 0) {
        return res.status(400).json({
            success: false,
            message: "Please enter a valid loan amount"
        });
    }

    if (principalAmount < 10000) {
        return res.status(400).json({
            success: false,
            message: "Minimum loan amount is ₹10,000"
        });
    }

    if (principalAmount > 10000000) {
        return res.status(400).json({
            success: false,
            message: "Maximum loan amount is ₹1,00,00,000"
        });
    }

    if (!Number.isInteger(tenureMonths) || tenureMonths <= 0) {
        return res.status(400).json({
            success: false,
            message: "Please enter a valid loan tenure"
        });
    }

    if (tenureMonths < 6 || tenureMonths > 360) {
        return res.status(400).json({
            success: false,
            message: "Loan tenure must be between 6 and 360 months"
        });
    }

    const customerSQL = `
        SELECT customer_id, name, email, status
        FROM Customer
        WHERE email = ?
        LIMIT 1
    `;

    db.query(customerSQL, [email], (customerError, customerResults) => {
        if (customerError) {
            return res.status(500).json({
                success: false,
                message: "Failed to find customer"
            });
        }

        if (customerResults.length === 0) {
            return res.status(404).json({
                success: false,
                message: "Customer not found"
            });
        }

        const customer = customerResults[0];

        if (String(customer.status).toLowerCase() !== "active") {
            return res.status(403).json({
                success: false,
                message: "Your customer account is inactive. Please contact the administrator."
            });
        }

        const accountSQL = `
            SELECT account_id, account_number, status
            FROM Account
            WHERE customer_id = ?
              AND status = 'Active'
            ORDER BY account_id
            LIMIT 1
        `;

        db.query(accountSQL, [customer.customer_id], (accountError, accountResults) => {
            if (accountError) {
                return res.status(500).json({
                    success: false,
                    message: "Failed to verify customer account"
                });
            }

            if (accountResults.length === 0) {
                return res.status(400).json({
                    success: false,
                    message: "You need an active bank account to apply for a loan"
                });
            }

            const loanTypeSQL = `
                SELECT loan_type_id, loan_type, interest_rate
                FROM Loan_Type
                WHERE loan_type_id = ?
                LIMIT 1
            `;

            db.query(loanTypeSQL, [loanTypeId], (loanTypeError, loanTypeResults) => {
                if (loanTypeError) {
                    return res.status(500).json({
                        success: false,
                        message: "Failed to verify loan type"
                    });
                }

                if (loanTypeResults.length === 0) {
                    return res.status(404).json({
                        success: false,
                        message: "Selected loan type does not exist"
                    });
                }

                const selectedLoanType = loanTypeResults[0];

                const insertSQL = `
                    INSERT INTO Loan
                    (
                        customer_id,
                        loan_type,
                        principal_amount,
                        interest_rate,
                        tenure_months,
                        status
                    )
                    VALUES (?, ?, ?, ?, ?, 'Pending')
                `;

                db.query(insertSQL, [
                    customer.customer_id,
                    selectedLoanType.loan_type,
                    principalAmount,
                    selectedLoanType.interest_rate,
                    tenureMonths
                ], (insertError, insertResult) => {
                    if (insertError) {
                        return res.status(500).json({
                            success: false,
                            message: "Failed to submit loan application"
                        });
                    }

                    const monthlyRate = Number(selectedLoanType.interest_rate) / 12 / 100;
                    let monthlyEMI;

                    if (monthlyRate === 0) {
                        monthlyEMI = principalAmount / tenureMonths;
                    } else {
                        const power = Math.pow(1 + monthlyRate, tenureMonths);
                        monthlyEMI = principalAmount * monthlyRate * power / (power - 1);
                    }

                    monthlyEMI = Number(monthlyEMI.toFixed(2));

                    return res.status(201).json({
                        success: true,
                        message: "Loan application submitted successfully",
                        loan_id: insertResult.insertId,
                        loan_type: selectedLoanType.loan_type,
                        principal_amount: principalAmount,
                        interest_rate: Number(selectedLoanType.interest_rate),
                        tenure_months: tenureMonths,
                        monthly_emi: monthlyEMI,
                        status: "Pending"
                    });
                });
            });
        });
    });
});

/* =========================================================
   ADMIN - PENDING LOANS
========================================================= */

app.get("/api/admin/loans/pending", (req, res) => {
    const sql = `
        SELECT
            l.loan_id,
            l.customer_id,
            c.name AS customer_name,
            c.email AS customer_email,
            c.phone AS customer_phone,
            l.loan_type,
            l.principal_amount,
            l.interest_rate,
            l.tenure_months,
            l.status
        FROM Loan l
        INNER JOIN Customer c ON l.customer_id = c.customer_id
        WHERE l.status = 'Pending'
        ORDER BY l.loan_id ASC
    `;

    db.query(sql, (err, results) => {
        if (err) {
            return res.status(500).json({
                success: false,
                message: "Failed to fetch pending loans"
            });
        }

        res.json({
            success: true,
            loans: results
        });
    });
});

/* =========================================================
   ADMIN - ALL LOANS
========================================================= */

app.get("/api/admin/loans", (req, res) => {
    const sql = `
        SELECT
            l.loan_id,
            l.customer_id,
            c.name AS customer_name,
            c.email AS customer_email,
            c.phone AS customer_phone,
            l.loan_type,
            l.principal_amount,
            l.interest_rate,
            l.tenure_months,
            l.status
        FROM Loan l
        INNER JOIN Customer c ON l.customer_id = c.customer_id
        ORDER BY l.loan_id DESC
    `;

    db.query(sql, (err, results) => {
        if (err) {
            return res.status(500).json({
                success: false,
                message: "Failed to fetch loan records"
            });
        }

        res.json({
            success: true,
            loans: results
        });
    });
});

/* =========================================================
   ADMIN - APPROVE LOAN
========================================================= */


/* =========================================================
   ADMIN - APPROVE LOAN
========================================================= */

app.put("/api/admin/loans/:id/approve", async (req, res) => {
    const loanId = Number(req.params.id);

    if (!Number.isInteger(loanId) || loanId <= 0) {
        return res.status(400).json({
            success: false,
            message: "Invalid loan ID"
        });
    }

    let connection;
    let transactionStarted = false;
    let failureMessage = "Loan approval transaction failed";

    try {
        connection = await new Promise((resolve, reject) => {
            db.getConnection((err, conn) => {
                if (err) return reject(err);
                resolve(conn);
            });
        });

        const conn = connection.promise();

        await conn.beginTransaction();
        transactionStarted = true;

        failureMessage = "Failed to find loan";

        const [loanResults] = await conn.query(
            `SELECT
                loan_id, customer_id, loan_type, principal_amount,
                interest_rate, tenure_months, status
             FROM Loan
             WHERE loan_id = ?
             LIMIT 1
             FOR UPDATE`,
            [loanId]
        );

        if (loanResults.length === 0) {
            return await rollbackLoan(
                connection, null, res, "Loan application not found", 404
            );
        }

        const loan = loanResults[0];

        if (loan.status !== "Pending") {
            return await rollbackLoan(
                connection, null, res,
                "Only Pending loans can be approved", 400
            );
        }

        failureMessage = "Failed to check existing EMI records";

        const [existingEMIResults] = await conn.query(
            `SELECT COUNT(*) AS emi_count
             FROM EMI_Payment
             WHERE loan_id = ?`,
            [loanId]
        );

        if (Number(existingEMIResults[0].emi_count) > 0) {
            return await rollbackLoan(
                connection, null, res,
                "EMI schedule already exists for this loan", 400
            );
        }

        const principal = Number(loan.principal_amount);
        const annualInterest = Number(loan.interest_rate);
        const tenure = Number(loan.tenure_months);

        if (
            !Number.isFinite(principal) || principal <= 0 ||
            !Number.isFinite(annualInterest) || annualInterest < 0 ||
            !Number.isInteger(tenure) || tenure <= 0
        ) {
            return await rollbackLoan(
                connection, null, res,
                "Loan details are invalid", 400
            );
        }

        const monthlyRate = annualInterest / 12 / 100;
        let monthlyEMI;

        if (monthlyRate === 0) {
            monthlyEMI = principal / tenure;
        } else {
            const power = Math.pow(1 + monthlyRate, tenure);
            monthlyEMI = principal * monthlyRate * power / (power - 1);
        }

        monthlyEMI = Number(monthlyEMI.toFixed(2));

        failureMessage = "Failed to approve loan";

        const [updateLoanResult] = await conn.query(
            `UPDATE Loan
             SET status = 'Approved'
             WHERE loan_id = ?
               AND status = 'Pending'`,
            [loanId]
        );

        if (updateLoanResult.affectedRows === 0) {
            return await rollbackLoan(
                connection, null, res,
                "Loan is no longer pending", 400
            );
        }

        const emiValues = [];
        const firstDueDate = new Date();

        for (let i = 1; i <= tenure; i++) {
            const dueDate = new Date(firstDueDate);
            dueDate.setMonth(dueDate.getMonth() + i);

            const year = dueDate.getFullYear();
            const month = String(dueDate.getMonth() + 1).padStart(2, "0");
            const day = String(dueDate.getDate()).padStart(2, "0");
            const formattedDate = `${year}-${month}-${day}`;

            emiValues.push([
                loanId,
                formattedDate,
                monthlyEMI,
                null,
                "Pending"
            ]);
        }

        failureMessage = "Loan approved but EMI generation failed";

        const [emiResult] = await conn.query(
            `INSERT INTO EMI_Payment
                (loan_id, due_date, amount, payment_date, status)
             VALUES ?`,
            [emiValues]
        );

        failureMessage = "Loan approval transaction failed";

        await conn.commit();
        transactionStarted = false;

        connection.release();
        connection = null;

        return res.json({
            success: true,
            message: "Loan approved and EMI schedule generated successfully",
            loan_id: loanId,
            status: "Approved",
            loan_type: loan.loan_type,
            principal_amount: principal,
            interest_rate: annualInterest,
            tenure_months: tenure,
            monthly_emi: monthlyEMI,
            emi_count: emiResult.affectedRows
        });

    } catch (error) {
        console.error("Loan approval failed:", error.message);

        if (connection && transactionStarted) {
            return await rollbackLoan(
                connection, error, res, failureMessage, 500
            );
        }

        if (connection) {
            connection.release();
            connection = null;
        }

        if (!res.headersSent) {
            return res.status(500).json({
                success: false,
                message: failureMessage
            });
        }
    }
});

/* =========================================================
   ADMIN - REJECT LOAN
========================================================= */

app.put("/api/admin/loans/:id/reject", (req, res) => {
    const loanId = Number(req.params.id);

    if (!Number.isInteger(loanId) || loanId <= 0) {
        return res.status(400).json({
            success: false,
            message: "Invalid loan ID"
        });
    }

    const findSQL = `
        SELECT loan_id, status
        FROM Loan
        WHERE loan_id = ?
        LIMIT 1
    `;

    db.query(findSQL, [loanId], (findError, findResults) => {
        if (findError) {
            return res.status(500).json({
                success: false,
                message: "Failed to find loan"
            });
        }

        if (findResults.length === 0) {
            return res.status(404).json({
                success: false,
                message: "Loan application not found"
            });
        }

        if (findResults[0].status !== "Pending") {
            return res.status(400).json({
                success: false,
                message: "Only Pending loans can be rejected"
            });
        }

        const rejectSQL = `
            UPDATE Loan
            SET status = 'Rejected'
            WHERE loan_id = ?
              AND status = 'Pending'
        `;

        db.query(rejectSQL, [loanId], (rejectError, rejectResult) => {
            if (rejectError) {
                return res.status(500).json({
                    success: false,
                    message: "Failed to reject loan"
                });
            }

            if (rejectResult.affectedRows === 0) {
                return res.status(400).json({
                    success: false,
                    message: "Loan is no longer pending"
                });
            }

            return res.json({
                success: true,
                message: "Loan rejected successfully",
                loan_id: loanId,
                status: "Rejected"
            });
        });
    });
});

/* =========================================================
   EMI
========================================================= */

app.get("/api/emi", (req, res) => {
    const sql = `
        SELECT
            e.emi_id,
            e.loan_id,
            l.customer_id,
            c.name,
            c.email,
            e.due_date,
            e.amount,
            e.late_fee,
            e.payment_date,
            e.status
        FROM EMI_Payment e
        INNER JOIN Loan l ON e.loan_id = l.loan_id
        INNER JOIN Customer c ON l.customer_id = c.customer_id
        ORDER BY e.due_date
    `;

    db.query(sql, (err, results) => {
        if (err) {
            return res.status(500).json({
                error: "Failed to fetch EMI payments"
            });
        }
        res.json(results);
    });
});


/* =========================================================
   AUTOMATIC EMI PAYMENT SYSTEM
   LATE FEE = ₹250
========================================================= */

const EMI_LATE_FEE = 250;
let emiProcessingRunning = false;

/**
 * Process one EMI using a dedicated MySQL connection.
 * All transaction queries use the same connection.
 */
function processSingleEMI(emiId) {
    return new Promise(async (resolve) => {
        let connection = null;
        let transactionStarted = false;

        try {
            connection = await new Promise((resolveConnection, rejectConnection) => {
                db.getConnection((error, acquiredConnection) => {
                    if (error) {
                        return rejectConnection(error);
                    }

                    resolveConnection(acquiredConnection);
                });
            });

            const conn = connection.promise();

            await conn.beginTransaction();
            transactionStarted = true;

            const emiSQL = `
                SELECT
                    e.emi_id,
                    e.loan_id,
                    e.due_date,
                    e.amount,
                    e.late_fee,
                    e.payment_date,
                    e.status,
                    l.customer_id,
                    c.name AS customer_name,
                    c.email AS customer_email,
                    c.status AS customer_status
                FROM EMI_Payment e
                INNER JOIN Loan l ON e.loan_id = l.loan_id
                INNER JOIN Customer c ON l.customer_id = c.customer_id
                WHERE e.emi_id = ?
                LIMIT 1
                FOR UPDATE
            `;

            const [emiResults] = await conn.query(emiSQL, [emiId]);

            if (emiResults.length === 0) {
                await conn.rollback();
                transactionStarted = false;
                return;
            }

            const emi = emiResults[0];
            const emiStatus = String(emi.status || "").toLowerCase();

            if (emiStatus === "paid") {
                await conn.rollback();
                transactionStarted = false;
                return;
            }

            const accountSQL = `
                SELECT account_id, account_number, balance, status
                FROM Account
                WHERE customer_id = ?
                  AND status = 'Active'
                ORDER BY account_id
                LIMIT 1
                FOR UPDATE
            `;

            const [accountResults] = await conn.query(accountSQL, [
                emi.customer_id
            ]);

            const markOverdue = async () => {
                const overdueSQL = `
                    UPDATE EMI_Payment
                    SET status = 'Overdue',
                        late_fee = CASE
                            WHEN late_fee = 0 THEN ?
                            ELSE late_fee
                        END
                    WHERE emi_id = ?
                      AND status <> 'Paid'
                `;

                await conn.query(overdueSQL, [
                    EMI_LATE_FEE,
                    emi.emi_id
                ]);

                await conn.commit();
                transactionStarted = false;
            };

            if (accountResults.length === 0) {
                await markOverdue();
                return;
            }

            const account = accountResults[0];
            const emiAmount = Number(emi.amount);
            const currentBalance = Number(account.balance);
            const existingLateFee = Number(emi.late_fee || 0);

            if (
                !Number.isFinite(emiAmount) ||
                emiAmount <= 0 ||
                !Number.isFinite(currentBalance)
            ) {
                await conn.rollback();
                transactionStarted = false;
                return;
            }

            const lateFee = emiStatus === "overdue"
                ? (existingLateFee > 0 ? existingLateFee : EMI_LATE_FEE)
                : 0;

            const totalAmount = emiAmount + lateFee;

            if (currentBalance < totalAmount) {
                await markOverdue();
                return;
            }

            const updateAccountSQL = `
                UPDATE Account
                SET balance = balance - ?
                WHERE account_id = ?
                  AND balance >= ?
                  AND status = 'Active'
            `;

            const [accountUpdate] = await conn.query(updateAccountSQL, [
                totalAmount,
                account.account_id,
                totalAmount
            ]);

            if (accountUpdate.affectedRows === 0) {
                await markOverdue();
                return;
            }

            const paymentDate = new Date();

            const updateEMISQL = `
                UPDATE EMI_Payment
                SET status = 'Paid',
                    payment_date = ?,
                    late_fee = ?
                WHERE emi_id = ?
                  AND status <> 'Paid'
            `;

            const [emiUpdate] = await conn.query(updateEMISQL, [
                paymentDate,
                lateFee,
                emi.emi_id
            ]);

            if (emiUpdate.affectedRows === 0) {
                await conn.rollback();
                transactionStarted = false;
                return;
            }

            const description = lateFee > 0
                ? "Automatic EMI Payment + Late Fee"
                : "Automatic EMI Payment";

            const transactionSQL = `
                INSERT INTO \`Transaction\`
                    (account_id, transaction_type, amount, description)
                VALUES (?, 'EMI', ?, ?)
            `;

            await conn.query(transactionSQL, [
                account.account_id,
                totalAmount,
                description
            ]);

            await conn.commit();
            transactionStarted = false;

        } catch (error) {
            if (transactionStarted && connection) {
                try {
                    await connection.promise().rollback();
                    transactionStarted = false;
                } catch (rollbackError) {
                    console.error(
                        "Automatic EMI rollback failed:",
                        rollbackError.message
                    );
                }
            }

            console.error(
                "Automatic EMI processing failed:",
                error.message
            );

        } finally {
            if (connection) {
                connection.release();
            }

            resolve();
        }
    });
}

/* =========================================================
   PROCESS ALL DUE / OVERDUE EMIs
   FIXED: WAIT FOR THE DATABASE QUERY AND PROCESSING
========================================================= */

async function processDueEMIs() {
    if (emiProcessingRunning) {
        return;
    }

    emiProcessingRunning = true;

    const sql = `
        SELECT emi_id
        FROM EMI_Payment
        WHERE status <> 'Paid'
          AND due_date <= CURDATE()
        ORDER BY due_date ASC, emi_id ASC
    `;

    try {
        const results = await new Promise((resolve, reject) => {
            db.query(sql, (error, rows) => {
                if (error) {
                    reject(error);
                    return;
                }

                resolve(rows);
            });
        });

        for (const row of results) {
            await processSingleEMI(row.emi_id);
        }
    } catch (error) {
        // Do not print routine scheduler errors in the terminal.
        // The next scheduled run will retry.
    } finally {
        emiProcessingRunning = false;
    }
}

/* =========================================================
   AUTOMATIC EMI CHECK EVERY MINUTE
========================================================= */

cron.schedule("* * * * *", async () => {
    await processDueEMIs();
});

/* =========================================================
   FIRST EMI CHECK AFTER SERVER START
========================================================= */

setTimeout(() => {
    processDueEMIs();
}, 2000);

/* =========================================================
   FUND TRANSFER
========================================================= */


/* =========================================================
   FUND TRANSFER
   Dedicated MySQL connection for transaction safety
========================================================= */

app.post("/api/transfer", async (req, res) => {
    const {
        customer_email,
        beneficiary_id,
        receiver_account_no,
        amount
    } = req.body;

    const email = String(customer_email || "").trim();
    const receiverAccountNo = String(receiver_account_no || "")
        .trim()
        .toUpperCase();

    const hasBeneficiary =
        beneficiary_id !== null &&
        beneficiary_id !== undefined &&
        String(beneficiary_id).trim() !== "";

    const hasReceiverAccount = receiverAccountNo !== "";

    if (!email) {
        return res.status(400).json({
            success: false,
            message: "Customer email is required"
        });
    }

    const transferAmount = Number(amount);

    if (!Number.isFinite(transferAmount) || transferAmount <= 0) {
        return res.status(400).json({
            success: false,
            message: "Please enter a valid transfer amount"
        });
    }

    if (!hasBeneficiary && !hasReceiverAccount) {
        return res.status(400).json({
            success: false,
            message: "Please select an Active Beneficiary or enter Receiver Bank Account Number/ID"
        });
    }

    if (hasBeneficiary && hasReceiverAccount) {
        return res.status(400).json({
            success: false,
            message: "Please use either Active Beneficiary or Receiver Bank Account Number/ID, not both"
        });
    }

    if (
        hasBeneficiary &&
        (!Number.isInteger(Number(beneficiary_id)) ||
            Number(beneficiary_id) <= 0)
    ) {
        return res.status(400).json({
            success: false,
            message: "Invalid beneficiary"
        });
    }

    if (hasReceiverAccount && receiverAccountNo.length > 20) {
        return res.status(400).json({
            success: false,
            message: "Receiver account number is too long"
        });
    }

    let connection = null;
    let transactionStarted = false;

    try {
        connection = await new Promise((resolve, reject) => {
            db.getConnection((error, acquiredConnection) => {
                if (error) return reject(error);
                resolve(acquiredConnection);
            });
        });

        const conn = connection.promise();

        await conn.beginTransaction();
        transactionStarted = true;

        const [customerResults] = await conn.query(
            `SELECT customer_id, name, email, status
             FROM Customer
             WHERE email = ?
             LIMIT 1`,
            [email]
        );

        if (customerResults.length === 0) {
            throw Object.assign(new Error("Customer not found"), {
                statusCode: 404
            });
        }

        const customer = customerResults[0];

        if (String(customer.status).toLowerCase() !== "active") {
            throw Object.assign(
                new Error(
                    "Your customer account is inactive. Please contact the administrator."
                ),
                { statusCode: 403 }
            );
        }

        const [senderResults] = await conn.query(
            `SELECT account_id, account_number, balance, status
             FROM Account
             WHERE customer_id = ?
             ORDER BY account_id
             LIMIT 1
             FOR UPDATE`,
            [customer.customer_id]
        );

        if (senderResults.length === 0) {
            throw Object.assign(new Error("Sender account not found"), {
                statusCode: 404
            });
        }

        const sender = senderResults[0];

        if (sender.status !== "Active") {
            throw Object.assign(new Error("Sender account is not active"), {
                statusCode: 400
            });
        }

        if (Number(sender.balance) < transferAmount) {
            throw Object.assign(new Error("Insufficient balance"), {
                statusCode: 400
            });
        }

        let beneficiary = null;
        let receiverAccountNo = hasReceiverAccount
            ? String(req.body.receiver_account_no).trim().toUpperCase()
            : "";

        if (hasBeneficiary) {
            const [beneficiaryResults] = await conn.query(
                `SELECT
                    beneficiary_id,
                    beneficiary_name,
                    beneficiary_account_no,
                    account_id,
                    status
                 FROM Beneficiary
                 WHERE beneficiary_id = ?
                   AND account_id = ?
                   AND status = 'Active'
                 LIMIT 1
                 FOR UPDATE`,
                [Number(beneficiary_id), sender.account_id]
            );

            if (beneficiaryResults.length === 0) {
                throw Object.assign(
                    new Error("Beneficiary not found or inactive"),
                    { statusCode: 404 }
                );
            }

            beneficiary = beneficiaryResults[0];
            receiverAccountNo = String(
                beneficiary.beneficiary_account_no || ""
            ).trim().toUpperCase();
        }

        if (!receiverAccountNo) {
            throw Object.assign(new Error("Receiver account not found"), {
                statusCode: 404
            });
        }

        const [receiverResults] = await conn.query(
            `SELECT account_id, account_number, balance, status
             FROM Account
             WHERE account_number = ?
             LIMIT 1
             FOR UPDATE`,
            [receiverAccountNo]
        );

        if (receiverResults.length === 0) {
            throw Object.assign(new Error("Receiver account not found"), {
                statusCode: 404
            });
        }

        const receiver = receiverResults[0];

        if (Number(receiver.account_id) === Number(sender.account_id)) {
            throw Object.assign(new Error("Self transfer is not allowed"), {
                statusCode: 400
            });
        }

        if (receiver.status !== "Active") {
            throw Object.assign(new Error("Receiver account is not active"), {
                statusCode: 400
            });
        }

        const [senderUpdate] = await conn.query(
            `UPDATE Account
             SET balance = balance - ?
             WHERE account_id = ?
               AND status = 'Active'
               AND balance >= ?`,
            [transferAmount, sender.account_id, transferAmount]
        );

        if (senderUpdate.affectedRows === 0) {
            throw Object.assign(
                new Error("Sender balance could not be updated"),
                { statusCode: 400 }
            );
        }

        const [receiverUpdate] = await conn.query(
            `UPDATE Account
             SET balance = balance + ?
             WHERE account_id = ?
               AND status = 'Active'`,
            [transferAmount, receiver.account_id]
        );

        if (receiverUpdate.affectedRows === 0) {
            throw Object.assign(
                new Error("Receiver balance could not be updated"),
                { statusCode: 400 }
            );
        }

        const referenceNo = "TRF" + Date.now();

        await conn.query(
            `INSERT INTO Fund_Transfer
                (
                    sender_account_id,
                    receiver_account_id,
                    beneficiary_id,
                    amount,
                    status,
                    reference_no
                )
             VALUES (?, ?, ?, ?, 'Completed', ?)`,
            [
                sender.account_id,
                receiver.account_id,
                beneficiary ? beneficiary.beneficiary_id : null,
                transferAmount,
                referenceNo
            ]
        );

        const senderDescription = beneficiary
            ? "Transfer to " + beneficiary.beneficiary_name
            : "Transfer to " + receiver.account_number;

        await conn.query(
            `INSERT INTO \`Transaction\`
                (account_id, transaction_type, amount, description)
             VALUES (?, 'Transfer', ?, ?)`,
            [sender.account_id, transferAmount, senderDescription]
        );

        await conn.query(
            `INSERT INTO \`Transaction\`
                (account_id, transaction_type, amount, description)
             VALUES (?, 'Deposit', ?, ?)`,
            [
                receiver.account_id,
                transferAmount,
                "Transfer received from " + sender.account_number
            ]
        );

        await conn.commit();
        transactionStarted = false;

        return res.json({
            success: true,
            message: "Fund transfer completed successfully",
            reference_no: referenceNo
        });
    } catch (error) {
        let statusCode = error.statusCode || 500;
        let message = error.statusCode
            ? error.message
            : "Fund transfer failed. Please check the transaction status before retrying.";

        if (transactionStarted && connection) {
            try {
                await connection.promise().rollback();
                transactionStarted = false;
            } catch (rollbackError) {
                console.error(
                    "Fund transfer rollback failed:",
                    rollbackError.message
                );

                statusCode = 500;
                message =
                    "Fund transfer could not be completed safely. Please check the transaction status before retrying.";
            }
        }

        if (!res.headersSent) {
            return res.status(statusCode).json({
                success: false,
                message
            });
        }
    } finally {
        if (connection) {
            connection.release();
        }
    }
});


/* =========================================================
   ROLLBACK LOAN TRANSACTION
========================================================= */

async function rollbackLoan(
    connection,
    error,
    res,
    message,
    statusCode = 400
) {
    try {
        await connection.promise().rollback();
    } catch (rollbackError) {
        console.error(
            "Loan rollback failed:",
            rollbackError.message
        );

        message =
            "Loan processing could not be completed safely. Please check the loan status before retrying.";

        statusCode = 500;
    } finally {
        connection.release();
    }

    if (!res.headersSent) {
        return res.status(statusCode).json({
            success: false,
            message: message
        });
    }
}

/* =========================================================
   START SERVER
========================================================= */

app.listen(PORT, "127.0.0.1", () => {
    console.log(`Server running on http://127.0.0.1:${PORT}`);
});