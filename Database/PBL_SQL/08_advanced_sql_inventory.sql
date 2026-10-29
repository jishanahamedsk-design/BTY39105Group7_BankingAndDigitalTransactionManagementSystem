USE fintech_banking_db;

-- IBI Bank PBL: Advanced SQL Object Inventory
-- Existing objects reported for this project.
-- Use SHOW CREATE statements to obtain the exact definitions.

-- 1. Views
SHOW CREATE VIEW vw_account_details;
SHOW CREATE VIEW vw_fund_transfer_details;
SHOW CREATE VIEW vw_loan_emi_summary;
SHOW CREATE VIEW vw_transaction_history;

-- 2. Stored procedures
SHOW CREATE PROCEDURE sp_account_transaction_history;
SHOW CREATE PROCEDURE sp_customer_account_summary;

-- 3. Function
SHOW CREATE FUNCTION fn_calculate_monthly_interest;

-- 4. Triggers
SHOW CREATE TRIGGER trg_account_balance_audit;
SHOW CREATE TRIGGER trg_validate_transaction_amount;

-- 5. Index inventory
SHOW INDEX FROM account;
SHOW INDEX FROM users;
SHOW INDEX FROM customer;

-- 6. Confirm the complete database object inventory
SHOW FULL TABLES;
SHOW PROCEDURE STATUS WHERE Db = 'fintech_banking_db';
SHOW FUNCTION STATUS WHERE Db = 'fintech_banking_db';
SHOW TRIGGERS FROM fintech_banking_db;
