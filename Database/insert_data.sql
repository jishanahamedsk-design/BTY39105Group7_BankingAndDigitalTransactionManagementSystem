-- IBI Bank: synthetic demonstration seed data
-- For a separate test database only. Do not run against production.
-- These records are fictional; no passwords, OTPs, or live customer data.
-- Review the target database before executing this script.

USE fintech_banking_db;

START TRANSACTION;

INSERT INTO branch (branch_name, IFSC, city)
SELECT 'PBL Demo Branch', 'IBIDEMO9001', 'Kolkata'
WHERE NOT EXISTS (
    SELECT 1 FROM branch WHERE IFSC = 'IBIDEMO9001'
);

INSERT INTO account_type (type_name, interest_rate, minimum_balance)
SELECT 'PBL Demo Savings', 3.00, 1000.00
WHERE NOT EXISTS (
    SELECT 1 FROM account_type WHERE type_name = 'PBL Demo Savings'
);

INSERT INTO loan_type (loan_type, interest_rate)
SELECT 'PBL Demo Loan', 8.50
WHERE NOT EXISTS (
    SELECT 1 FROM loan_type WHERE loan_type = 'PBL Demo Loan'
);

INSERT INTO customer (name, email, phone, address, status)
SELECT 'Demo Customer One',
       'pbl.demo.one@example.com',
       '9000009001',
       'Fictional demonstration address, Kolkata',
       'Active'
WHERE NOT EXISTS (
    SELECT 1 FROM customer
    WHERE email = 'pbl.demo.one@example.com'
);

INSERT INTO customer (name, email, phone, address, status)
SELECT 'Demo Customer Two',
       'pbl.demo.two@example.com',
       '9000009002',
       'Fictional demonstration address, Kolkata',
       'Active'
WHERE NOT EXISTS (
    SELECT 1 FROM customer
    WHERE email = 'pbl.demo.two@example.com'
);

COMMIT;

-- Verification queries
SELECT branch_name, IFSC, city
FROM branch WHERE IFSC = 'IBIDEMO9001';

SELECT customer_id, name, email
FROM customer
WHERE email IN (
    'pbl.demo.one@example.com',
    'pbl.demo.two@example.com'
);