USE fintech_banking_db;

-- PBL 02: Aggregate Functions and GROUP BY Queries
-- These queries retrieve summary information without modifying data.

-- 1. Count customers by status.
SELECT status, COUNT(*) AS total_customers
FROM customer
GROUP BY status;

-- 2. Count accounts by status.
SELECT status, COUNT(*) AS total_accounts
FROM account
GROUP BY status;

-- 3. Calculate total, average, minimum, and maximum account balances.
SELECT
    COUNT(*) AS total_accounts,
    SUM(balance) AS total_balance,
    AVG(balance) AS average_balance,
    MIN(balance) AS minimum_balance,
    MAX(balance) AS maximum_balance
FROM account;

-- 4. Calculate the number and total value of completed transfers.
SELECT
    COUNT(*) AS completed_transfers,
    SUM(amount) AS total_transfer_amount,
    AVG(amount) AS average_transfer_amount
FROM fund_transfer
WHERE status = 'Completed';

-- 5. Summarize loan count and principal amount by loan type.
SELECT
    loan_type,
    COUNT(*) AS total_loans,
    SUM(principal_amount) AS total_principal,
    AVG(interest_rate) AS average_interest_rate
FROM loan
GROUP BY loan_type
ORDER BY total_principal DESC;
