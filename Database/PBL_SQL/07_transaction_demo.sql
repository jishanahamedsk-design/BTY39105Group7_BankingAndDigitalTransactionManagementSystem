USE fintech_banking_db;

-- PBL Transaction Control Demonstration
-- Demonstrates COMMIT and ROLLBACK using a temporary test table.
-- Does not modify actual customer accounts or transactions.

-- DEMONSTRATION A: COMMIT
CREATE TEMPORARY TABLE IF NOT EXISTS pbl_transaction_demo (
    demo_id INT PRIMARY KEY,
    description VARCHAR(100),
    amount DECIMAL(12,2)
);

DELETE FROM pbl_transaction_demo;

START TRANSACTION;

INSERT INTO pbl_transaction_demo
    (demo_id, description, amount)
VALUES
    (1, 'PBL COMMIT demonstration', 1000.00);

COMMIT;

SELECT 'After COMMIT' AS demonstration,
       demo_id, description, amount
FROM pbl_transaction_demo;

-- DEMONSTRATION B: ROLLBACK
START TRANSACTION;

INSERT INTO pbl_transaction_demo
    (demo_id, description, amount)
VALUES
    (2, 'PBL ROLLBACK demonstration', 500.00);

ROLLBACK;

SELECT 'After ROLLBACK' AS demonstration,
       demo_id, description, amount
FROM pbl_transaction_demo;

DROP TEMPORARY TABLE IF EXISTS pbl_transaction_demo;

-- Expected concept:
-- COMMIT preserves the first inserted row during the transaction.
-- ROLLBACK cancels the second inserted row.
