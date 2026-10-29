
/* =========================================================
   IBI BANK — DATABASE CONNECTION
   File: Backend/db.js
   MySQL2 Connection Pool
========================================================= */

const mysql = require("mysql2");

const pool = mysql.createPool({
    host: process.env.DB_HOST || "localhost",
    user: process.env.DB_USER || "root",
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME || "fintech_banking_db",

    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

const db = pool;

// =========================================================
// VERIFY DATABASE CONNECTION
// =========================================================

pool.getConnection((err, connection) => {
    if (err) {
        console.error("MySQL database connection failed:", err.message);
        return;
    }

    console.log("MySQL connected successfully!");
    console.log("Database: fintech_banking_db");

    connection.release();
});

// =========================================================
// HANDLE POOL ERRORS
// =========================================================

pool.on("error", (err) => {
    console.error("MySQL pool error:", err.message);
});

module.exports = db;
