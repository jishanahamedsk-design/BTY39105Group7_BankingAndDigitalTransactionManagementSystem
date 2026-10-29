-- IBI Bank: Representative read-only SQL queries
-- Database: fintech_banking_db
-- The full PBL query collection remains in Database/PBL_SQL/.
-- These statements retrieve data; they do not insert, update, or delete records.

USE fintech_banking_db;

-- 1. Customers and their accounts
SELECT c.customer_id, c.name, c.email,
       a.account_number, a.balance, a.status AS account_status
FROM customer AS c
INNER JOIN account AS a ON a.customer_id = c.customer_id
ORDER BY c.name;

-- 2. Account balances by status
SELECT status, COUNT(*) AS account_count,
       COALESCE(SUM(balance), 0) AS total_balance,
       AVG(balance) AS average_balance
FROM account
GROUP BY status
ORDER BY status;

-- 3. Recent transactions
SELECT transaction_id, account_id, transaction_type,
       amount, transaction_date, description
FROM `transaction`
ORDER BY transaction_date DESC
LIMIT 20;

-- 4. Completed transfer summary
SELECT COUNT(*) AS completed_transfers,
       COALESCE(SUM(amount), 0) AS total_transfer_amount
FROM fund_transfer
WHERE status = 'Completed';

-- 5. Loan and EMI summary
SELECT l.loan_id, l.customer_id, l.loan_type,
       l.principal_amount, l.status AS loan_status,
       COUNT(e.emi_id) AS emi_record_count,
       COALESCE(SUM(e.amount), 0) AS total_emi_amount,
       COALESCE(SUM(e.late_fee), 0) AS total_late_fees
FROM loan AS l
LEFT JOIN emi_payment AS e ON e.loan_id = l.loan_id
GROUP BY l.loan_id, l.customer_id, l.loan_type,
         l.principal_amount, l.status
ORDER BY l.loan_id;

-- 6. Account details view
SELECT * FROM vw_account_details
LIMIT 20;

-- 7. Fund transfer details view
SELECT * FROM vw_fund_transfer_details
LIMIT 20;

-- 8. Loan EMI summary view
SELECT * FROM vw_loan_emi_summary
LIMIT 20;

-- 9. Transaction history view
SELECT * FROM vw_transaction_history
LIMIT 20;