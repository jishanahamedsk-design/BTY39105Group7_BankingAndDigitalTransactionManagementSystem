-- IBI Bank: portable trigger definitions

DELIMITER $$

CREATE TRIGGER trg_account_balance_audit
AFTER UPDATE ON account
FOR EACH ROW
BEGIN
    IF NOT (OLD.balance <=> NEW.balance) THEN
        INSERT INTO account_balance_audit (
            account_id, account_number, old_balance, new_balance
        )
        VALUES (
            NEW.account_id, NEW.account_number, OLD.balance, NEW.balance
        );
    END IF;
END$$

CREATE TRIGGER trg_validate_transaction_amount
BEFORE INSERT ON `transaction`
FOR EACH ROW
BEGIN
    IF NEW.amount IS NULL OR NEW.amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Transaction amount must be greater than zero';
    END IF;
END$$

DELIMITER ;