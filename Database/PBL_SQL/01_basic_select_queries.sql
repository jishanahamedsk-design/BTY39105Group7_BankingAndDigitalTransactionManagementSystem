USE fintech_banking_db;

-- PBL 01: Basic SELECT Queries
-- These queries retrieve data only; they do not modify records.

-- 1. Display all customers.
SELECT * FROM customer;

-- 2. Display active customers.
SELECT customer_id, name, email, phone, status
FROM customer
WHERE status = 'Active';

-- 3. Display all bank accounts with their balances.
SELECT account_id, account_number, balance, status
FROM account;

-- 4. Display accounts with a balance greater than 10,000.
SELECT account_id, account_number, balance
FROM account
WHERE balance > 10000
ORDER BY balance DESC;

-- 5. Display all bank branches.
SELECT branch_id, branch_name, IFSC, city
FROM branch
ORDER BY city, branch_name;

-- 6. Display active beneficiaries.
SELECT beneficiary_id, account_id, beneficiary_name,
       beneficiary_account_no, bank_name, status
FROM beneficiary
WHERE status = 'Active'
  AND deleted_at IS NULL;

-- 7. Display the latest 20 transactions.
SELECT transaction_id, account_id, transaction_type,
       amount, transaction_date, description
FROM `transaction`
ORDER BY transaction_date DESC
LIMIT 20;

-- 8. Display completed fund transfers.
SELECT transfer_id, sender_account_id, receiver_account_id,
       amount, transfer_date, status, reference_no
FROM fund_transfer
WHERE status = 'Completed'
ORDER BY transfer_date DESC;

-- 9. Display approved or active loans.
SELECT loan_id, customer_id, loan_type, principal_amount,
       interest_rate, tenure_months, status
FROM loan
WHERE status IN ('Approved', 'Active')
ORDER BY principal_amount DESC;

-- 10. Display pending or overdue EMI payments.
SELECT emi_id, loan_id, due_date, amount,
       payment_date, status, late_fee
FROM emi_payment
WHERE status IN ('Pending', 'Overdue')
ORDER BY due_date;
