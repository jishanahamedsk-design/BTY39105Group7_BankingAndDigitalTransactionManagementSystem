-- IBI Bank: portable stored function and procedures

DELIMITER $$

CREATE FUNCTION fn_calculate_monthly_interest(
    p_balance DECIMAL(15,2),
    p_annual_interest_rate DECIMAL(5,2)
)
RETURNS DECIMAL(15,2)
NO SQL
DETERMINISTIC
BEGIN
    IF p_balance IS NULL
       OR p_annual_interest_rate IS NULL
       OR p_balance < 0
       OR p_annual_interest_rate < 0 THEN
        RETURN NULL;
    END IF;

    RETURN ROUND(p_balance * p_annual_interest_rate / 100 / 12, 2);
END$$

CREATE PROCEDURE sp_account_transaction_history(
    IN p_account_number VARCHAR(20),
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    IF p_start_date IS NULL
       OR p_end_date IS NULL
       OR p_start_date > p_end_date THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Please provide a valid date range';
    ELSE
        SELECT
            a.account_number,
            c.name AS customer_name,
            t.transaction_id,
            t.transaction_type,
            t.amount,
            t.transaction_date,
            t.description
        FROM `transaction` AS t
        INNER JOIN account AS a ON t.account_id = a.account_id
        LEFT JOIN customer AS c ON a.customer_id = c.customer_id
        WHERE a.account_number = p_account_number
          AND t.transaction_date >= p_start_date
          AND t.transaction_date < DATE_ADD(p_end_date, INTERVAL 1 DAY)
        ORDER BY t.transaction_date DESC;
    END IF;
END$$

CREATE PROCEDURE sp_customer_account_summary(
    IN p_customer_id INT
)
BEGIN
    IF p_customer_id IS NULL OR p_customer_id <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Please provide a valid customer ID';
    ELSE
        SELECT
            customer_id,
            customer_name,
            customer_email,
            account_id,
            account_number,
            branch_name,
            IFSC,
            branch_city,
            account_type,
            balance,
            account_status
        FROM vw_account_details
        WHERE customer_id = p_customer_id
        ORDER BY account_id;
    END IF;
END$$

DELIMITER ;