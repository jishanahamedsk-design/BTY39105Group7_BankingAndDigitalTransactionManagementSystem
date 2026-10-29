-- IBI Bank: database schema
-- Extracted from the verified project backup.
-- Review foreign-key creation order before importing into a fresh database.
CREATE DATABASE IF NOT EXISTS fintech_banking_db;
USE fintech_banking_db;

CREATE TABLE `account` (
  `account_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `branch_id` int DEFAULT NULL,
  `account_type_id` int DEFAULT NULL,
  `account_number` varchar(20) DEFAULT NULL,
  `balance` decimal(15,2) DEFAULT '0.00',
  `status` varchar(20) DEFAULT 'Active',
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `account_number` (`account_number`),
  KEY `customer_id` (`customer_id`),
  KEY `branch_id` (`branch_id`),
  KEY `account_type_id` (`account_type_id`),
  CONSTRAINT `account_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `account_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`),
  CONSTRAINT `account_ibfk_3` FOREIGN KEY (`account_type_id`) REFERENCES `account_type` (`account_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=264 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `account_balance_audit` (
  `audit_id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `account_number` varchar(20) DEFAULT NULL,
  `old_balance` decimal(15,2) DEFAULT NULL,
  `new_balance` decimal(15,2) DEFAULT NULL,
  `changed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`audit_id`),
  KEY `fk_balance_audit_account` (`account_id`),
  CONSTRAINT `fk_balance_audit_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `account_type` (
  `account_type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) DEFAULT NULL,
  `interest_rate` decimal(5,2) DEFAULT NULL,
  `minimum_balance` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`account_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `beneficiary` (
  `beneficiary_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int DEFAULT NULL,
  `account_type_id` int DEFAULT NULL,
  `beneficiary_name` varchar(100) DEFAULT NULL,
  `beneficiary_account_no` varchar(20) DEFAULT NULL,
  `bank_name` varchar(100) DEFAULT NULL,
  `IFSC` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'Active',
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`beneficiary_id`),
  KEY `account_id` (`account_id`),
  KEY `fk_beneficiary_account_type` (`account_type_id`),
  CONSTRAINT `beneficiary_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`),
  CONSTRAINT `fk_beneficiary_account_type` FOREIGN KEY (`account_type_id`) REFERENCES `account_type` (`account_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `branch` (
  `branch_id` int NOT NULL AUTO_INCREMENT,
  `branch_name` varchar(100) DEFAULT NULL,
  `IFSC` varchar(20) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=382 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text,
  `status` varchar(20) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `email_verification_codes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `purpose` enum('signup','login','password_reset') NOT NULL,
  `code_hash` varchar(255) NOT NULL,
  `expires_at` datetime NOT NULL,
  `attempts` int NOT NULL DEFAULT '0',
  `consumed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_verification_email_purpose` (`email`,`purpose`),
  KEY `idx_verification_expiry` (`expires_at`),
  KEY `fk_verification_user` (`user_id`),
  CONSTRAINT `fk_verification_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `emi_payment` (
  `emi_id` int NOT NULL AUTO_INCREMENT,
  `loan_id` int DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `amount` decimal(15,2) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `late_fee` decimal(15,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`emi_id`),
  KEY `loan_id` (`loan_id`),
  CONSTRAINT `emi_payment_ibfk_1` FOREIGN KEY (`loan_id`) REFERENCES `loan` (`loan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=259 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `fund_transfer` (
  `transfer_id` int NOT NULL AUTO_INCREMENT,
  `sender_account_id` int DEFAULT NULL,
  `receiver_account_id` int DEFAULT NULL,
  `beneficiary_id` int DEFAULT NULL,
  `amount` decimal(15,2) DEFAULT NULL,
  `transfer_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` varchar(20) DEFAULT NULL,
  `reference_no` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`transfer_id`),
  KEY `sender_account_id` (`sender_account_id`),
  KEY `beneficiary_id` (`beneficiary_id`),
  CONSTRAINT `fund_transfer_ibfk_1` FOREIGN KEY (`sender_account_id`) REFERENCES `account` (`account_id`),
  CONSTRAINT `fund_transfer_ibfk_2` FOREIGN KEY (`beneficiary_id`) REFERENCES `beneficiary` (`beneficiary_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `loan` (
  `loan_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int DEFAULT NULL,
  `loan_type` varchar(50) DEFAULT NULL,
  `principal_amount` decimal(15,2) DEFAULT NULL,
  `interest_rate` decimal(5,2) DEFAULT NULL,
  `tenure_months` int DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`loan_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `loan_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `loan_type` (
  `loan_type_id` int NOT NULL AUTO_INCREMENT,
  `loan_type` varchar(50) NOT NULL,
  `interest_rate` decimal(5,2) NOT NULL,
  PRIMARY KEY (`loan_type_id`),
  UNIQUE KEY `loan_type` (`loan_type`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `transaction` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int DEFAULT NULL,
  `transaction_type` varchar(50) DEFAULT NULL,
  `amount` decimal(15,2) DEFAULT NULL,
  `transaction_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `account_id` (`account_id`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=838 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin','main_admin') NOT NULL DEFAULT 'user',
  `email_verified_at` datetime DEFAULT NULL,
  `token_version` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;