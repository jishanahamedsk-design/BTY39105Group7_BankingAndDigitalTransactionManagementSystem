USE fintech_banking_db;

-- 1. Customers who have at least one account
SELECT customer_id, name, email
FROM customer
WHERE customer_id IN (SELECT customer_id FROM account);

-- 2. Accounts with a balance above the overall average
SELECT account_id, account_number, balance
FROM account
WHERE balance > (SELECT AVG(balance) FROM account)
ORDER BY balance DESC;

-- 3. Loans with principal above the average loan principal
SELECT loan_id, customer_id, loan_type, principal_amount, status
FROM loan
WHERE principal_amount > (SELECT AVG(principal_amount) FROM loan)
ORDER BY principal_amount DESC;
