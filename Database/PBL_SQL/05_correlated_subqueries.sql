USE fintech_banking_db;

-- 1. Accounts with a balance above the average account balance
-- for the same customer
SELECT a.account_id, a.customer_id, a.account_number, a.balance
FROM account a
WHERE a.balance > (
    SELECT AVG(a2.balance)
    FROM account a2
    WHERE a2.customer_id = a.customer_id
);

-- 2. Customers whose account balance exceeds the overall
-- average balance of accounts belonging to that customer
SELECT c.customer_id, c.name, c.email
FROM customer c
WHERE EXISTS (
    SELECT 1
    FROM account a
    WHERE a.customer_id = c.customer_id
      AND a.balance > (
          SELECT AVG(a2.balance)
          FROM account a2
          WHERE a2.customer_id = c.customer_id
      )
);
