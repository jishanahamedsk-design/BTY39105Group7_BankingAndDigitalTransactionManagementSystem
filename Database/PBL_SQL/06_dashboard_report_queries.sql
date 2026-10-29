USE fintech_banking_db;

-- Dashboard/report 1: Customer totals by status
SELECT status, COUNT(*) AS customer_count
FROM customer
GROUP BY status;

-- Dashboard/report 2: Account totals and balances by status
SELECT status, COUNT(*) AS account_count,
       COALESCE(SUM(balance), 0) AS total_balance
FROM account
GROUP BY status;

-- Dashboard/report 3: Transaction totals by type
SELECT transaction_type, COUNT(*) AS transaction_count,
       SUM(amount) AS total_amount
FROM `transaction`
GROUP BY transaction_type
ORDER BY total_amount DESC;

-- Dashboard/report 4: Transfer totals by status
SELECT status, COUNT(*) AS transfer_count,
       COALESCE(SUM(amount), 0) AS total_amount
FROM fund_transfer
GROUP BY status;

-- Dashboard/report 5: Loan portfolio by loan type
SELECT loan_type, COUNT(*) AS loan_count,
       SUM(principal_amount) AS total_principal,
       AVG(interest_rate) AS average_interest_rate
FROM loan
GROUP BY loan_type
ORDER BY total_principal DESC;

-- Additional report: Recent transactions
SELECT transaction_id, account_id, transaction_type,
       amount, transaction_date, description
FROM `transaction`
ORDER BY transaction_date DESC
LIMIT 20;
