-- IBI Bank: portable view definitions
-- Run only after importing the database schema.
-- No fixed DEFINER is specified, so the importing MySQL user can create the views.

CREATE OR REPLACE VIEW vw_account_details AS
SELECT
    a.account_id,
    a.account_number,
    c.customer_id,
    c.name AS customer_name,
    c.email AS customer_email,
    b.branch_name,
    b.IFSC,
    b.city AS branch_city,
    at.type_name AS account_type,
    a.balance,
    a.status AS account_status
FROM account AS a
LEFT JOIN customer AS c
    ON a.customer_id = c.customer_id
LEFT JOIN branch AS b
    ON a.branch_id = b.branch_id
LEFT JOIN account_type AS at
    ON a.account_type_id = at.account_type_id;

CREATE OR REPLACE VIEW vw_fund_transfer_details AS
SELECT
    f.transfer_id,
    f.reference_no,
    f.transfer_date,
    f.status AS transfer_status,
    f.amount,
    f.sender_account_id,
    sender.account_number AS sender_account_number,
    sender_customer.name AS sender_customer_name,
    f.receiver_account_id,
    receiver.account_number AS receiver_account_number,
    receiver_customer.name AS receiver_customer_name,
    f.beneficiary_id,
    b.beneficiary_name,
    b.beneficiary_account_no,
    b.bank_name AS beneficiary_bank_name,
    b.IFSC AS beneficiary_IFSC,
    b.status AS beneficiary_status
FROM fund_transfer AS f
LEFT JOIN account AS sender
    ON f.sender_account_id = sender.account_id
LEFT JOIN customer AS sender_customer
    ON sender.customer_id = sender_customer.customer_id
LEFT JOIN account AS receiver
    ON f.receiver_account_id = receiver.account_id
LEFT JOIN customer AS receiver_customer
    ON receiver.customer_id = receiver_customer.customer_id
LEFT JOIN beneficiary AS b
    ON f.beneficiary_id = b.beneficiary_id;

CREATE OR REPLACE VIEW vw_loan_emi_summary AS
SELECT
    l.loan_id,
    l.customer_id,
    c.name AS customer_name,
    l.loan_type,
    l.principal_amount,
    l.interest_rate,
    l.tenure_months,
    l.status AS loan_status,
    COUNT(e.emi_id) AS total_emi_records,
    SUM(
        CASE WHEN e.status = 'Paid' THEN 1 ELSE 0 END
    ) AS paid_emi_count,
    SUM(
        CASE
            WHEN e.emi_id IS NOT NULL
             AND (e.status <> 'Paid' OR e.status IS NULL)
            THEN 1
            ELSE 0
        END
    ) AS unpaid_emi_count,
    COALESCE(SUM(e.amount), 0) AS total_emi_amount,
    COALESCE(SUM(e.late_fee), 0) AS total_late_fees
FROM loan AS l
LEFT JOIN customer AS c
    ON l.customer_id = c.customer_id
LEFT JOIN emi_payment AS e
    ON l.loan_id = e.loan_id
GROUP BY
    l.loan_id,
    l.customer_id,
    c.name,
    l.loan_type,
    l.principal_amount,
    l.interest_rate,
    l.tenure_months,
    l.status;

CREATE OR REPLACE VIEW vw_transaction_history AS
SELECT
    t.transaction_id,
    t.account_id,
    a.account_number,
    c.name AS customer_name,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    t.description
FROM `transaction` AS t
LEFT JOIN account AS a
    ON t.account_id = a.account_id
LEFT JOIN customer AS c
    ON a.customer_id = c.customer_id;