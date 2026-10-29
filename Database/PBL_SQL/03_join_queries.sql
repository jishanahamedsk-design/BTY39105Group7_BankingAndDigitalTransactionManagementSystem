USE fintech_banking_db;

-- 1. Customers and their accounts
SELECT c.customer_id, c.name, c.email, a.account_number, a.balance, a.status AS account_status
FROM customer c
INNER JOIN account a ON a.customer_id = c.customer_id
ORDER BY c.name;

-- 2. Accounts with branch and account type
SELECT a.account_id, a.account_number, c.name AS customer_name,
       b.branch_name, b.city, at.type_name AS account_type, a.balance
FROM account a
LEFT JOIN customer c ON c.customer_id = a.customer_id
LEFT JOIN branch b ON b.branch_id = a.branch_id
LEFT JOIN account_type at ON at.account_type_id = a.account_type_id
ORDER BY a.account_id;

-- 3. Transactions with account and customer details
SELECT t.transaction_id, t.transaction_type, t.amount, t.transaction_date,
       a.account_number, c.name AS customer_name
FROM `transaction` t
LEFT JOIN account a ON a.account_id = t.account_id
LEFT JOIN customer c ON c.customer_id = a.customer_id
ORDER BY t.transaction_date DESC;

-- 4. Transfers with sender and receiver account numbers
SELECT ft.transfer_id, ft.reference_no,
       s.account_number AS sender_account,
       r.account_number AS receiver_account,
       ft.amount, ft.transfer_date, ft.status
FROM fund_transfer ft
LEFT JOIN account s ON s.account_id = ft.sender_account_id
LEFT JOIN account r ON r.account_id = ft.receiver_account_id
ORDER BY ft.transfer_date DESC;

-- 5. Loans with customer and EMI summary
SELECT l.loan_id, c.name AS customer_name, l.loan_type,
       l.principal_amount, l.status AS loan_status,
       COUNT(e.emi_id) AS emi_records,
       COALESCE(SUM(e.amount), 0) AS total_emi_amount,
       COALESCE(SUM(e.late_fee), 0) AS total_late_fees
FROM loan l
LEFT JOIN customer c ON c.customer_id = l.customer_id
LEFT JOIN emi_payment e ON e.loan_id = l.loan_id
GROUP BY l.loan_id, c.name, l.loan_type, l.principal_amount, l.status
ORDER BY l.loan_id;
