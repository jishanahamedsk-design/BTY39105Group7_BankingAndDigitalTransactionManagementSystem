
const mysql = require("mysql2");

const dbHost = process.env.DB_HOST || "localhost";

const isHosted = !["localhost", "127.0.0.1", "::1"].includes(
    dbHost.toLowerCase()
);

const sslConfig = isHosted
    ? {
        minVersion: "TLSv1.2",
        rejectUnauthorized: true,
        ...(process.env.DB_SSL_CA
            ? { ca: process.env.DB_SSL_CA }
            : {})
    }
    : undefined;

if (isHosted && !process.env.DB_SSL_CA) {
    console.error(
        "DB_SSL_CA is missing. Aiven SSL certificate is required."
    );
}

const pool = mysql.createPool({
    host: dbHost,
    port: Number(process.env.DB_PORT || 3306),
    user: process.env.DB_USER || "root",
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME || "fintech_banking_db",

    ...(isHosted ? { ssl: sslConfig } : {}),

    waitForConnections: true,
    connectionLimit: 5,
    queueLimit: 0
});

const db = pool;

pool.getConnection((err, connection) => {
    if (err) {
        console.error(
            "MySQL database connection failed:",
            err.message
        );
        return;
    }

    console.log("MySQL connected successfully!");
    console.log(
        `Database: ${process.env.DB_NAME || "fintech_banking_db"}`
    );

    connection.release();
});

pool.on("error", (err) => {
    console.error("MySQL pool error:", err.message);
});

module.exports = db;
