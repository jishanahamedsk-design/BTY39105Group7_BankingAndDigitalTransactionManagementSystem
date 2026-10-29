CREATE DATABASE IF NOT EXISTS fintech_banking_db;
USE fintech_banking_db;

-- 1. AUTHENTICATION & USERS
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('user', 'admin') DEFAULT 'user'
);

INSERT INTO Users (name, email, phone, password, role) VALUES 
('System Admin', 'admin@bank.com', '0000000000', 'admin123', 'admin'),
('SK JISHAN AHAMED', 'jishan@example.com', '9876543210', '$2b$10$epA1Xb3ZJq5C8R3wVq2wIe3d1pP7mE2rM9yH8L2cO7hU3kF4tD9eO', 'user');

-- 2. CUSTOMERS & BRANCHES
CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT
);

INSERT INTO Customer (name, email, phone, address) VALUES 
('SK JISHAN AHAMED', 'jishan@example.com', '9876543210', 'Kolkata, West Bengal');

CREATE TABLE Branch (
    branch_id INT AUTO_INCREMENT PRIMARY KEY,
    branch_name VARCHAR(100),
    IFSC VARCHAR(20)
);
ALTER TABLE Branch
ADD COLUMN city VARCHAR(50);

INSERT INTO Branch (branch_name, IFSC,city) VALUES 
('Newtown Main Branch', 'BANK0001234','kolkata');

-- 3. ACCOUNTS
CREATE TABLE Account_Type (
    account_type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50),
    interest_rate DECIMAL(5,2),
    minimum_balance DECIMAL(15,2)
);

INSERT INTO Account_Type (type_name, interest_rate, minimum_balance) VALUES 
('Savings', 4.00, 1000.00),
('Current', 0.00, 5000.00);


INSERT INTO Account_Type
(type_name, interest_rate, minimum_balance)
VALUES
('Savings Account', 4.00, 1000.00),
('Current Account', 0.00, 5000.00),
('Salary Account', 3.50, 0.00),
('Fixed Deposit', 7.00, 5000.00),
('Recurring Deposit', 6.50, 500.00);


SELECT * FROM Account_Type;


CREATE TABLE Account (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    branch_id INT,
    account_type_id INT,
    account_number VARCHAR(20) UNIQUE,
    balance DECIMAL(15,2) DEFAULT 0.00,
    status VARCHAR(20) DEFAULT 'Active',
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id),
    FOREIGN KEY (account_type_id) REFERENCES Account_Type(account_type_id)
);

USE fintech_banking_db;

SELECT customer_id, name, email
FROM Customer
ORDER BY customer_id;

SELECT branch_id, branch_name, IFSC, city
FROM Branch
ORDER BY branch_id;

SELECT account_type_id, type_name, interest_rate, minimum_balance
FROM Account_Type
ORDER BY account_type_id;


USE fintech_banking_db;

SELECT COUNT(*) AS customers_for_accounts
FROM Customer
WHERE customer_id = 1
   OR customer_id BETWEEN 6 AND 101
   OR customer_id BETWEEN 104 AND 225;


SELECT account_type_id, type_name, interest_rate, minimum_balance
FROM Account_Type
WHERE account_type_id BETWEEN 11 AND 15
ORDER BY account_type_id;


SELECT account_type_id, type_name, interest_rate, minimum_balance
FROM Account_Type
WHERE account_type_id BETWEEN 11 AND 15
ORDER BY account_type_id;


USE fintech_banking_db;

INSERT INTO Account
(
    customer_id,
    branch_id,
    account_type_id,
    account_number,
    balance,
    status
)
SELECT
    c.customer_id,

    /* Use an existing branch ID */
    (
        SELECT MIN(b.branch_id)
        FROM Branch b
        WHERE b.branch_id = (
            SELECT MIN(b2.branch_id)
            FROM Branch b2
            WHERE b2.branch_id >=
                  (
                      SELECT MIN(branch_id)
                      FROM Branch
                  )
        )
    ) AS branch_id,

    /* Distribute the 5 account types */
    CASE MOD(c.customer_id, 5)
        WHEN 0 THEN 11
        WHEN 1 THEN 12
        WHEN 2 THEN 13
        WHEN 3 THEN 14
        ELSE 15
    END AS account_type_id,

    /* Unique account number */
    CONCAT('IBI', LPAD(c.customer_id, 10, '0')) AS account_number,

    /* Sample balances */
    CASE MOD(c.customer_id, 5)
        WHEN 0 THEN 50000.00
        WHEN 1 THEN 75000.00
        WHEN 2 THEN 25000.00
        WHEN 3 THEN 100000.00
        ELSE 15000.00
    END AS balance,

    'Active' AS status

FROM Customer c

WHERE
    c.customer_id = 1
    OR c.customer_id BETWEEN 6 AND 101
    OR c.customer_id BETWEEN 104 AND 225

    /* Don't create another account for an existing customer */
    AND NOT EXISTS
    (
        SELECT 1
        FROM Account a
        WHERE a.customer_id = c.customer_id
    )

    /* Don't create a duplicate account number */
    AND NOT EXISTS
    (
        SELECT 1
        FROM Account a2
        WHERE a2.account_number =
              CONCAT('IBI', LPAD(c.customer_id, 10, '0'))
    );


SELECT
    MIN(branch_id) AS branch_id,
    branch_name,
    IFSC,
    city
FROM Branch
GROUP BY branch_name, IFSC, city
ORDER BY MIN(branch_id);


USE fintech_banking_db;

SELECT COUNT(*) AS existing_accounts
FROM Account;


USE fintech_banking_db;

INSERT INTO Account
(
    customer_id,
    branch_id,
    account_type_id,
    account_number,
    balance,
    status
)
SELECT
    c.customer_id,

    /* Select one of your 130 valid unique branches */
    (
        SELECT branch_id
        FROM
        (
            SELECT
                MIN(branch_id) AS branch_id,
                ROW_NUMBER() OVER (ORDER BY MIN(branch_id)) AS rn
            FROM Branch
            GROUP BY branch_name, IFSC, city
        ) AS branches
        WHERE branches.rn =
              MOD(c.customer_id - 1, 130) + 1
    ) AS branch_id,

    /* Distribute the 5 account types */
    CASE MOD(c.customer_id, 5)
        WHEN 0 THEN 11
        WHEN 1 THEN 12
        WHEN 2 THEN 13
        WHEN 3 THEN 14
        ELSE 15
    END AS account_type_id,

    /* Unique IBI account number */
    CONCAT(
        'IBI',
        LPAD(c.customer_id, 10, '0')
    ) AS account_number,

    /* Sample opening balances */
    CASE MOD(c.customer_id, 5)
        WHEN 0 THEN 50000.00
        WHEN 1 THEN 75000.00
        WHEN 2 THEN 25000.00
        WHEN 3 THEN 100000.00
        ELSE 15000.00
    END AS balance,

    'Active' AS status

FROM Customer c

WHERE
    (
        c.customer_id = 1
        OR c.customer_id BETWEEN 6 AND 101
        OR c.customer_id BETWEEN 104 AND 225
    )

    /* Don't create another account for a customer
       who already has an account */
    AND NOT EXISTS
    (
        SELECT 1
        FROM Account a
        WHERE a.customer_id = c.customer_id
    )

    /* Protect account_number UNIQUE constraint */
    AND NOT EXISTS
    (
        SELECT 1
        FROM Account a2
        WHERE a2.account_number =
              CONCAT(
                  'IBI',
                  LPAD(c.customer_id, 10, '0')
              )
    );




SELECT COUNT(*) AS total_accounts
FROM Account;





SELECT
    a.account_id,
    a.customer_id,
    c.name AS customer_name,
    a.branch_id,
    b.branch_name,
    b.city,
    a.account_type_id,
    at.type_name,
    a.account_number,
    a.balance,
    a.status
FROM Account a
JOIN Customer c
    ON a.customer_id = c.customer_id
JOIN Branch b
    ON a.branch_id = b.branch_id
JOIN Account_Type at
    ON a.account_type_id = at.account_type_id
ORDER BY a.account_id
LIMIT 30;


USE fintech_banking_db;

SELECT
    account_id,
    customer_id,
    account_number,
    account_type_id,
    balance,
    status
FROM Account
WHERE customer_id = 1;


USE fintech_banking_db;

DELETE FROM Account
WHERE account_id = 6;


SELECT
    account_id,
    customer_id,
    account_number,
    account_type_id,
    balance,
    status
FROM Account
WHERE customer_id = 1;


USE fintech_banking_db;

SELECT
    account_id,
    customer_id,
    account_number,
    branch_id,
    account_type_id
FROM Account
ORDER BY account_id;


SELECT COUNT(*) AS total_accounts
FROM Account;


USE fintech_banking_db;

WITH numbered_accounts AS
(
    SELECT
        account_id,
        ROW_NUMBER() OVER (ORDER BY account_id) AS rn
    FROM Account
    WHERE account_id <> 1
),
numbered_branches AS
(
    SELECT
        MIN(branch_id) AS branch_id,
        ROW_NUMBER() OVER (ORDER BY MIN(branch_id)) AS rn
    FROM Branch
    GROUP BY branch_name, IFSC, city
)
UPDATE Account a
JOIN numbered_accounts na
    ON a.account_id = na.account_id
JOIN numbered_branches nb
    ON nb.rn = MOD(na.rn - 1, 130) + 1
SET a.branch_id = nb.branch_id
WHERE a.account_id <> 1;


SELECT
    a.account_id,
    a.customer_id,
    c.name AS customer_name,
    a.branch_id,
    b.branch_name,
    b.city,
    a.account_type_id,
    at.type_name,
    a.account_number,
    a.balance,
    a.status
FROM Account a
JOIN Customer c
    ON a.customer_id = c.customer_id
JOIN Branch b
    ON a.branch_id = b.branch_id
JOIN Account_Type at
    ON a.account_type_id = at.account_type_id
ORDER BY a.account_id
LIMIT 30;


USE fintech_banking_db;

DESCRIBE Transaction;



INSERT INTO Account (customer_id, branch_id, account_type_id, account_number, balance, status) VALUES 
(1, 1, 1, '100020003000', 25000.50, 'Active');

-- 4. TRANSACTIONS & TRANSFERS
CREATE TABLE `Transaction` (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    transaction_type VARCHAR(50),
    amount DECIMAL(15,2),
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    description VARCHAR(255),
    FOREIGN KEY (account_id) REFERENCES Account(account_id)
);


USE fintech_banking_db;

-- =========================================================
-- GENERATE TRANSACTIONS FOR EXISTING GENERATED ACCOUNTS
-- Account ID 1 is preserved because it contains your
-- existing live/test transaction data.
-- =========================================================

-- 1. DEPOSIT TRANSACTIONS
INSERT INTO `Transaction`
(
    account_id,
    transaction_type,
    amount,
    transaction_date,
    description
)
SELECT
    a.account_id,
    'Deposit',
    CASE MOD(a.account_id, 5)
        WHEN 0 THEN 10000.00
        WHEN 1 THEN 15000.00
        WHEN 2 THEN 20000.00
        WHEN 3 THEN 25000.00
        ELSE 30000.00
    END,
    DATE_SUB(NOW(), INTERVAL 30 DAY),
    'Initial account deposit'
FROM Account a
WHERE a.account_id <> 1;


-- 2. WITHDRAWAL TRANSACTIONS
INSERT INTO `Transaction`
(
    account_id,
    transaction_type,
    amount,
    transaction_date,
    description
)
SELECT
    a.account_id,
    'Withdrawal',
    CASE MOD(a.account_id, 5)
        WHEN 0 THEN 2000.00
        WHEN 1 THEN 3000.00
        WHEN 2 THEN 4000.00
        WHEN 3 THEN 5000.00
        ELSE 6000.00
    END,
    DATE_SUB(NOW(), INTERVAL 15 DAY),
    'ATM cash withdrawal'
FROM Account a
WHERE a.account_id <> 1;


-- 3. TRANSFER TRANSACTIONS
INSERT INTO `Transaction`
(
    account_id,
    transaction_type,
    amount,
    transaction_date,
    description
)
SELECT
    a.account_id,
    'Transfer',
    CASE MOD(a.account_id, 5)
        WHEN 0 THEN 500.00
        WHEN 1 THEN 1000.00
        WHEN 2 THEN 1500.00
        WHEN 3 THEN 2000.00
        ELSE 2500.00
    END,
    DATE_SUB(NOW(), INTERVAL 5 DAY),
    'Online fund transfer'
FROM Account a
WHERE a.account_id <> 1;


-- =========================================================
-- CHECK TOTAL TRANSACTIONS
-- =========================================================

SELECT COUNT(*) AS total_transactions
FROM `Transaction`;


-- =========================================================
-- SHOW RECENT TRANSACTIONS
-- =========================================================

SELECT
    transaction_id,
    account_id,
    transaction_type,
    amount,
    transaction_date,
    description
FROM `Transaction`
ORDER BY transaction_id DESC
LIMIT 20;

SELECT COUNT(*) AS total_transactions
FROM `Transaction`;


USE fintech_banking_db;

SELECT
    transaction_type,
    COUNT(*) AS total
FROM `Transaction`
GROUP BY transaction_type;


USE fintech_banking_db;

SELECT
    transaction_id,
    account_id,
    transaction_type,
    amount,
    transaction_date,
    description
FROM `Transaction`
ORDER BY transaction_id DESC
LIMIT 50;



INSERT INTO `Transaction` (account_id, transaction_type, amount, description) VALUES 
(1, 'Deposit', 25000.50, 'Initial Account Funding');

CREATE TABLE Beneficiary (
    beneficiary_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    beneficiary_name VARCHAR(100),
    beneficiary_account_no VARCHAR(20),
    bank_name VARCHAR(100),
    IFSC VARCHAR(20),
    status VARCHAR(20) DEFAULT 'Active',
    FOREIGN KEY (account_id) REFERENCES Account(account_id)
);

CREATE TABLE Fund_Transfer (
    transfer_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_account_id INT,
    beneficiary_id INT,
    amount DECIMAL(15,2),
    transfer_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20),
    reference_no VARCHAR(50),
    FOREIGN KEY (sender_account_id) REFERENCES Account(account_id),
    FOREIGN KEY (beneficiary_id) REFERENCES Beneficiary(beneficiary_id)
);

-- 5. LOANS & EMI
CREATE TABLE Loan (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    loan_type VARCHAR(50),
    principal_amount DECIMAL(15,2),
    interest_rate DECIMAL(5,2),
    tenure_months INT,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE EMI_Payment (
    emi_id INT AUTO_INCREMENT PRIMARY KEY,
    loan_id INT,
    due_date DATE,
    amount DECIMAL(15,2),
    payment_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (loan_id) REFERENCES Loan(loan_id)
);

INSERT INTO Users (name, email, phone, password, role) 
VALUES ('System Admin', 'admin@bank.com', '0000000000', 'admin123', 'admin');

UPDATE Users 
SET password = 'admin123', role = 'admin' 
WHERE email = 'admin@bank.com';

UPDATE Users SET role = 'admin' WHERE email = 'the_email_you_just_created@example.com';

USE fintech_banking_db;

DELETE FROM Users WHERE email = 'admin@bank.com';

INSERT INTO Users (name, email, phone, password, role) 
VALUES ('System Admin', 'admin@bank.com', '0000000000', 'admin123', 'admin');

USE fintech_banking_db;

-- Delete any existing test user with that email to prevent duplicates
DELETE FROM Users WHERE email = 'jishan.user@bank.com';

-- Insert a fresh user with a bcrypt hashed password for 'password123'
INSERT INTO Users (name, email, phone, password, role) 
VALUES ('SK JISHAN AHAMED', 'jishan.user@bank.com', '9876543310', '$2b$10$epA1Xb3ZJq5C8R3wVq2wIe3d1pP7mE2rM9yH8L2cO7hU3kF4tD9eO', 'user');

USE fintech_banking_db;
DELETE FROM Users WHERE email = 'jishan@example.com';




USE fintech_banking_db;

-- ============================================================
-- IBI BANK — INTERNATIONAL BANK OF INDIA
-- 120 BRANCHES ACROSS INDIA
-- ============================================================

INSERT IGNORE INTO Branch (branch_name, ifsc, city) VALUES

-- WEST BENGAL
('Salt Lake Sector V Branch', 'IBIB0001001', 'Kolkata'),
('Park Street Branch', 'IBIB0001002', 'Kolkata'),
('New Town Action Area 1 Branch', 'IBIB0001003', 'Kolkata'),
('Howrah Station Branch', 'IBIB0001004', 'Howrah'),
('Ballygunge Branch', 'IBIB0001005', 'Kolkata'),
('Barasat Station Road Branch', 'IBIB0001006', 'Barasat'),
('Durgapur City Centre Branch', 'IBIB0001008', 'Durgapur'),
('Asansol Main Branch', 'IBIB0001009', 'Asansol'),
('Siliguri Hill Cart Road Branch', 'IBIB0001010', 'Siliguri'),
('Kharagpur Main Branch', 'IBIB0001011', 'Kharagpur'),

-- JHARKHAND
('Tatanagar Main Branch', 'IBIB0001007', 'Jamshedpur'),
('Ranchi Main Branch', 'IBIB0001012', 'Ranchi'),
('Dhanbad Bank More Branch', 'IBIB0001013', 'Dhanbad'),
('Bokaro Steel City Branch', 'IBIB0001014', 'Bokaro'),
('Deoghar Tower Chowk Branch', 'IBIB0001015', 'Deoghar'),

-- BIHAR
('Patna Fraser Road Branch', 'IBIB0001016', 'Patna'),
('Gaya Station Road Branch', 'IBIB0001017', 'Gaya'),
('Muzaffarpur Main Branch', 'IBIB0001018', 'Muzaffarpur'),
('Bhagalpur Main Branch', 'IBIB0001019', 'Bhagalpur'),
('Darbhanga Tower Chowk Branch', 'IBIB0001020', 'Darbhanga'),

-- ODISHA
('Bhubaneswar Saheed Nagar Branch', 'IBIB0001021', 'Bhubaneswar'),
('Cuttack Badambadi Branch', 'IBIB0001022', 'Cuttack'),
('Rourkela Main Branch', 'IBIB0001023', 'Rourkela'),
('Berhampur Main Branch', 'IBIB0001024', 'Berhampur'),
('Puri Grand Road Branch', 'IBIB0001025', 'Puri'),

-- ASSAM
('Guwahati GS Road Branch', 'IBIB0001026', 'Guwahati'),
('Dibrugarh Main Branch', 'IBIB0001027', 'Dibrugarh'),
('Silchar Central Road Branch', 'IBIB0001028', 'Silchar'),
('Jorhat Main Branch', 'IBIB0001029', 'Jorhat'),

-- DELHI
('Connaught Place Branch', 'IBIB0001030', 'New Delhi'),
('Karol Bagh Branch', 'IBIB0001031', 'New Delhi'),
('Dwarka Sector 10 Branch', 'IBIB0001032', 'New Delhi'),
('Rohini Sector 7 Branch', 'IBIB0001033', 'New Delhi'),
('Saket Branch', 'IBIB0001034', 'New Delhi'),

-- UTTAR PRADESH
('Lucknow Hazratganj Branch', 'IBIB0001035', 'Lucknow'),
('Noida Sector 18 Branch', 'IBIB0001036', 'Noida'),
('Kanpur Mall Road Branch', 'IBIB0001037', 'Kanpur'),
('Agra MG Road Branch', 'IBIB0001038', 'Agra'),
('Varanasi Cantt Branch', 'IBIB0001039', 'Varanasi'),
('Prayagraj Civil Lines Branch', 'IBIB0001040', 'Prayagraj'),
('Ghaziabad Raj Nagar Branch', 'IBIB0001041', 'Ghaziabad'),
('Meerut Garh Road Branch', 'IBIB0001042', 'Meerut'),
('Gorakhpur Golghar Branch', 'IBIB0001043', 'Gorakhpur'),
('Bareilly Civil Lines Branch', 'IBIB0001044', 'Bareilly'),

-- UTTARAKHAND
('Dehradun Rajpur Road Branch', 'IBIB0001045', 'Dehradun'),
('Haridwar Ranipur More Branch', 'IBIB0001046', 'Haridwar'),
('Haldwani Main Branch', 'IBIB0001047', 'Haldwani'),

-- HARYANA
('Gurugram MG Road Branch', 'IBIB0001048', 'Gurugram'),
('Faridabad Sector 15 Branch', 'IBIB0001049', 'Faridabad'),
('Panipat Main Branch', 'IBIB0001050', 'Panipat'),
('Karnal Mall Road Branch', 'IBIB0001051', 'Karnal'),
('Hisar Main Branch', 'IBIB0001052', 'Hisar'),

-- PUNJAB
('Chandigarh Sector 17 Branch', 'IBIB0001053', 'Chandigarh'),
('Ludhiana Feroze Gandhi Market Branch', 'IBIB0001054', 'Ludhiana'),
('Amritsar Mall Road Branch', 'IBIB0001055', 'Amritsar'),
('Jalandhar Model Town Branch', 'IBIB0001056', 'Jalandhar'),
('Patiala Leela Bhawan Branch', 'IBIB0001057', 'Patiala'),

-- RAJASTHAN
('Jaipur MI Road Branch', 'IBIB0001058', 'Jaipur'),
('Jodhpur Sardarpura Branch', 'IBIB0001059', 'Jodhpur'),
('Udaipur Chetak Circle Branch', 'IBIB0001060', 'Udaipur'),
('Kota Talwandi Branch', 'IBIB0001061', 'Kota'),
('Ajmer Civil Lines Branch', 'IBIB0001062', 'Ajmer'),

-- GUJARAT
('Ahmedabad CG Road Branch', 'IBIB0001063', 'Ahmedabad'),
('Surat Ring Road Branch', 'IBIB0001064', 'Surat'),
('Vadodara Alkapuri Branch', 'IBIB0001065', 'Vadodara'),
('Rajkot Kalawad Road Branch', 'IBIB0001066', 'Rajkot'),
('Gandhinagar Sector 11 Branch', 'IBIB0001067', 'Gandhinagar'),

-- MAHARASHTRA
('Mumbai Nariman Point Branch', 'IBIB0001068', 'Mumbai'),
('Mumbai Andheri West Branch', 'IBIB0001069', 'Mumbai'),
('Pune FC Road Branch', 'IBIB0001070', 'Pune'),
('Nagpur Sitabuldi Branch', 'IBIB0001071', 'Nagpur'),
('Nashik College Road Branch', 'IBIB0001072', 'Nashik'),
('Thane Ghodbunder Road Branch', 'IBIB0001073', 'Thane'),
('Aurangabad CIDCO Branch', 'IBIB0001074', 'Aurangabad'),
('Kolhapur Rajarampuri Branch', 'IBIB0001075', 'Kolhapur'),

-- GOA
('Panaji MG Road Branch', 'IBIB0001076', 'Panaji'),
('Margao Main Branch', 'IBIB0001077', 'Margao'),

-- MADHYA PRADESH
('Bhopal MP Nagar Branch', 'IBIB0001078', 'Bhopal'),
('Indore Vijay Nagar Branch', 'IBIB0001079', 'Indore'),
('Gwalior City Centre Branch', 'IBIB0001080', 'Gwalior'),
('Jabalpur Wright Town Branch', 'IBIB0001081', 'Jabalpur'),
('Ujjain Freeganj Branch', 'IBIB0001082', 'Ujjain'),

-- CHHATTISGARH
('Raipur GE Road Branch', 'IBIB0001083', 'Raipur'),
('Bhilai Civic Centre Branch', 'IBIB0001084', 'Bhilai'),
('Bilaspur Main Branch', 'IBIB0001085', 'Bilaspur'),

-- TELANGANA
('Hyderabad Banjara Hills Branch', 'IBIB0001086', 'Hyderabad'),
('Hyderabad Hitech City Branch', 'IBIB0001087', 'Hyderabad'),
('Warangal Hanamkonda Branch', 'IBIB0001088', 'Warangal'),
('Nizamabad Main Branch', 'IBIB0001089', 'Nizamabad'),

-- ANDHRA PRADESH
('Vijayawada MG Road Branch', 'IBIB0001090', 'Vijayawada'),
('Visakhapatnam Dwaraka Nagar Branch', 'IBIB0001091', 'Visakhapatnam'),
('Guntur Main Branch', 'IBIB0001092', 'Guntur'),
('Tirupati Temple Road Branch', 'IBIB0001093', 'Tirupati'),
('Nellore Main Branch', 'IBIB0001094', 'Nellore'),

-- KARNATAKA
('Bengaluru MG Road Branch', 'IBIB0001095', 'Bengaluru'),
('Bengaluru Whitefield Branch', 'IBIB0001096', 'Bengaluru'),
('Mysuru Sayyaji Rao Road Branch', 'IBIB0001097', 'Mysuru'),
('Mangaluru Hampankatta Branch', 'IBIB0001098', 'Mangaluru'),
('Hubballi Main Branch', 'IBIB0001099', 'Hubballi'),
('Belagavi Main Branch', 'IBIB0001100', 'Belagavi'),

-- TAMIL NADU
('Chennai Anna Salai Branch', 'IBIB0001101', 'Chennai'),
('Chennai T Nagar Branch', 'IBIB0001102', 'Chennai'),
('Coimbatore RS Puram Branch', 'IBIB0001103', 'Coimbatore'),
('Madurai KK Nagar Branch', 'IBIB0001104', 'Madurai'),
('Salem Main Branch', 'IBIB0001105', 'Salem'),
('Tiruchirappalli Cantonment Branch', 'IBIB0001106', 'Tiruchirappalli'),
('Tiruppur Main Branch', 'IBIB0001107', 'Tiruppur'),

-- KERALA
('Thiruvananthapuram MG Road Branch', 'IBIB0001108', 'Thiruvananthapuram'),
('Kochi MG Road Branch', 'IBIB0001109', 'Kochi'),
('Kozhikode Main Branch', 'IBIB0001110', 'Kozhikode'),
('Thrissur Swaraj Round Branch', 'IBIB0001111', 'Thrissur'),
('Kollam Main Branch', 'IBIB0001112', 'Kollam'),

-- PUDUCHERRY
('Puducherry Mission Street Branch', 'IBIB0001113', 'Puducherry'),

-- JAMMU AND KASHMIR
('Srinagar Lal Chowk Branch', 'IBIB0001114', 'Srinagar'),
('Jammu Gandhi Nagar Branch', 'IBIB0001115', 'Jammu'),

-- HIMACHAL PRADESH
('Shimla Mall Road Branch', 'IBIB0001116', 'Shimla'),
('Dharamshala Main Branch', 'IBIB0001117', 'Dharamshala'),

-- GOA / ADDITIONAL WEST
('Vasco Da Gama Branch', 'IBIB0001118', 'Vasco da Gama'),

-- NORTHEAST INDIA
('Imphal Main Branch', 'IBIB0001119', 'Imphal'),
('Shillong Police Bazar Branch', 'IBIB0001120', 'Shillong'),
('Agartala Main Branch', 'IBIB0001121', 'Agartala'),
('Aizawl Main Branch', 'IBIB0001122', 'Aizawl'),
('Kohima Main Branch', 'IBIB0001123', 'Kohima'),
('Itanagar Main Branch', 'IBIB0001124', 'Itanagar'),
('Gangtok MG Marg Branch', 'IBIB0001125', 'Gangtok');

-- ============================================================
-- CHECK TOTAL BRANCHES
-- ============================================================

SELECT COUNT(*) AS total_branches
FROM Branch;

-- ============================================================
-- VIEW ALL BRANCHES
-- ============================================================

SELECT
    branch_id,
    branch_name,
    ifsc,
    city
FROM Branch
ORDER BY branch_id;



USE fintech_banking_db;

SELECT *
FROM Branch
WHERE branch_name = 'Newtown Main Branch';

USE fintech_banking_db;

-- 1. Keep the first Newtown Main Branch
UPDATE Branch
SET
    city = 'Kolkata',
    IFSC = 'IBIB0001003'
WHERE branch_id = (
    SELECT MIN(branch_id)
    FROM (
        SELECT branch_id
        FROM Branch
        WHERE branch_name = 'Newtown Main Branch'
    ) AS temp
);



-- 3. Check the result
SELECT *
FROM Branch
WHERE branch_name = 'Newtown Main Branch';

USE fintech_banking_db;

SELECT branch_id, branch_name, IFSC, city
FROM Branch
WHERE branch_name = 'Newtown Main Branch';

DELETE FROM Branch
WHERE branch_id IN (2, 3, 4); 

UPDATE Branch
SET
    branch_name = 'Newtown Main Branch',
    IFSC = 'IBIB0001003',
    city = 'Kolkata'
WHERE branch_id = 1;

SELECT *
FROM Branch
WHERE branch_name = 'Newtown Main Branch';








USE fintech_banking_db;

INSERT INTO Customer (name, email, phone, address) VALUES
('Aarav Sharma 001', 'aarav.sharma001@gmail.com', '9000000001', 'Salt Lake, Kolkata, West Bengal - 700091'),
('Aditi Kumar 002', 'aditi.kumar002@gmail.com', '9000000002', 'New Town, Kolkata, West Bengal - 700156'),
('Arjun Singh 003', 'arjun.singh003@gmail.com', '9000000003', 'Park Street, Kolkata, West Bengal - 700016'),
('Ananya Das 004', 'ananya.das004@gmail.com', '9000000004', 'Ballygunge, Kolkata, West Bengal - 700019'),
('Rahul Patel 005', 'rahul.patel005@gmail.com', '9000000005', 'Howrah, West Bengal - 711101'),
('Priya Gupta 006', 'priya.gupta006@gmail.com', '9000000006', 'Barasat, West Bengal - 700124'),
('Rohan Roy 007', 'rohan.roy007@gmail.com', '9000000007', 'Durgapur, West Bengal - 713216'),
('Sneha Banerjee 008', 'sneha.banerjee008@gmail.com', '9000000008', 'Asansol, West Bengal - 713301'),
('Amit Mukherjee 009', 'amit.mukherjee009@gmail.com', '9000000009', 'Siliguri, West Bengal - 734001'),
('Neha Chatterjee 010', 'neha.chatterjee010@gmail.com', '9000000010', 'Kharagpur, West Bengal - 721301'),

('Vikram Sharma 011', 'vikram.sharma011@gmail.com', '9000000011', 'Patna, Bihar - 800001'),
('Pooja Kumar 012', 'pooja.kumar012@gmail.com', '9000000012', 'Gaya, Bihar - 823001'),
('Karan Singh 013', 'karan.singh013@gmail.com', '9000000013', 'Muzaffarpur, Bihar - 842001'),
('Riya Das 014', 'riya.das014@gmail.com', '9000000014', 'Bhagalpur, Bihar - 812001'),
('Sanjay Patel 015', 'sanjay.patel015@gmail.com', '9000000015', 'Ranchi, Jharkhand - 834001'),
('Kavya Gupta 016', 'kavya.gupta016@gmail.com', '9000000016', 'Jamshedpur, Jharkhand - 831001'),
('Nikhil Roy 017', 'nikhil.roy017@gmail.com', '9000000017', 'Dhanbad, Jharkhand - 826001'),
('Meera Banerjee 018', 'meera.banerjee018@gmail.com', '9000000018', 'Bokaro, Jharkhand - 827004'),
('Aditya Mukherjee 019', 'aditya.mukherjee019@gmail.com', '9000000019', 'Bhubaneswar, Odisha - 751001'),
('Ishita Chatterjee 020', 'ishita.chatterjee020@gmail.com', '9000000020', 'Cuttack, Odisha - 753001'),

('Varun Sharma 021', 'varun.sharma021@gmail.com', '9000000021', 'Rourkela, Odisha - 769001'),
('Simran Kumar 022', 'simran.kumar022@gmail.com', '9000000022', 'Puri, Odisha - 752001'),
('Aarav Singh 023', 'aarav.singh023@gmail.com', '9000000023', 'Guwahati, Assam - 781001'),
('Aditi Das 024', 'aditi.das024@gmail.com', '9000000024', 'Dibrugarh, Assam - 786001'),
('Arjun Patel 025', 'arjun.patel025@gmail.com', '9000000025', 'Silchar, Assam - 788001'),
('Ananya Gupta 026', 'ananya.gupta026@gmail.com', '9000000026', 'Delhi - 110001'),
('Rahul Roy 027', 'rahul.roy027@gmail.com', '9000000027', 'Karol Bagh, New Delhi - 110005'),
('Priya Banerjee 028', 'priya.banerjee028@gmail.com', '9000000028', 'Dwarka, New Delhi - 110075'),
('Rohan Mukherjee 029', 'rohan.mukherjee029@gmail.com', '9000000029', 'Rohini, New Delhi - 110085'),
('Sneha Chatterjee 030', 'sneha.chatterjee030@gmail.com', '9000000030', 'Saket, New Delhi - 110017'),

('Amit Sharma 031', 'amit.sharma031@gmail.com', '9000000031', 'Lucknow, Uttar Pradesh - 226001'),
('Neha Kumar 032', 'neha.kumar032@gmail.com', '9000000032', 'Noida, Uttar Pradesh - 201301'),
('Vikram Singh 033', 'vikram.singh033@gmail.com', '9000000033', 'Kanpur, Uttar Pradesh - 208001'),
('Pooja Das 034', 'pooja.das034@gmail.com', '9000000034', 'Agra, Uttar Pradesh - 282001'),
('Karan Patel 035', 'karan.patel035@gmail.com', '9000000035', 'Varanasi, Uttar Pradesh - 221001'),
('Riya Gupta 036', 'riya.gupta036@gmail.com', '9000000036', 'Prayagraj, Uttar Pradesh - 211001'),
('Sanjay Roy 037', 'sanjay.roy037@gmail.com', '9000000037', 'Ghaziabad, Uttar Pradesh - 201001'),
('Kavya Banerjee 038', 'kavya.banerjee038@gmail.com', '9000000038', 'Meerut, Uttar Pradesh - 250001'),
('Nikhil Mukherjee 039', 'nikhil.mukherjee039@gmail.com', '9000000039', 'Gorakhpur, Uttar Pradesh - 273001'),
('Meera Chatterjee 040', 'meera.chatterjee040@gmail.com', '9000000040', 'Bareilly, Uttar Pradesh - 243001'),

('Aditya Sharma 041', 'aditya.sharma041@gmail.com', '9000000041', 'Dehradun, Uttarakhand - 248001'),
('Ishita Kumar 042', 'ishita.kumar042@gmail.com', '9000000042', 'Haridwar, Uttarakhand - 249401'),
('Varun Singh 043', 'varun.singh043@gmail.com', '9000000043', 'Haldwani, Uttarakhand - 263139'),
('Simran Das 044', 'simran.das044@gmail.com', '9000000044', 'Jaipur, Rajasthan - 302001'),
('Aarav Patel 045', 'aarav.patel045@gmail.com', '9000000045', 'Jodhpur, Rajasthan - 342001'),
('Aditi Gupta 046', 'aditi.gupta046@gmail.com', '9000000046', 'Udaipur, Rajasthan - 313001'),
('Arjun Roy 047', 'arjun.roy047@gmail.com', '9000000047', 'Kota, Rajasthan - 324001'),
('Ananya Banerjee 048', 'ananya.banerjee048@gmail.com', '9000000048', 'Ajmer, Rajasthan - 305001'),
('Rahul Mukherjee 049', 'rahul.mukherjee049@gmail.com', '9000000049', 'Ahmedabad, Gujarat - 380001'),
('Priya Chatterjee 050', 'priya.chatterjee050@gmail.com', '9000000050', 'Surat, Gujarat - 395003'),

('Rohan Sharma 051', 'rohan.sharma051@gmail.com', '9000000051', 'Vadodara, Gujarat - 390001'),
('Sneha Kumar 052', 'sneha.kumar052@gmail.com', '9000000052', 'Rajkot, Gujarat - 360001'),
('Amit Singh 053', 'amit.singh053@gmail.com', '9000000053', 'Gandhinagar, Gujarat - 382010'),
('Neha Patel 054', 'neha.patel054@gmail.com', '9000000054', 'Mumbai, Maharashtra - 400001'),
('Vikram Gupta 055', 'vikram.gupta055@gmail.com', '9000000055', 'Andheri, Mumbai - 400058'),
('Pooja Roy 056', 'pooja.roy056@gmail.com', '9000000056', 'Pune, Maharashtra - 411001'),
('Karan Banerjee 057', 'karan.banerjee057@gmail.com', '9000000057', 'Nagpur, Maharashtra - 440001'),
('Riya Mukherjee 058', 'riya.mukherjee058@gmail.com', '9000000058', 'Nashik, Maharashtra - 422001'),
('Sanjay Chatterjee 059', 'sanjay.chatterjee059@gmail.com', '9000000059', 'Thane, Maharashtra - 400601'),
('Kavya Sharma 060', 'kavya.sharma060@gmail.com', '9000000060', 'Kolhapur, Maharashtra - 416001'),

('Nikhil Kumar 061', 'nikhil.kumar061@gmail.com', '9000000061', 'Bhopal, Madhya Pradesh - 462001'),
('Meera Singh 062', 'meera.singh062@gmail.com', '9000000062', 'Indore, Madhya Pradesh - 452001'),
('Aditya Das 063', 'aditya.das063@gmail.com', '9000000063', 'Gwalior, Madhya Pradesh - 474001'),
('Ishita Patel 064', 'ishita.patel064@gmail.com', '9000000064', 'Jabalpur, Madhya Pradesh - 482001'),
('Varun Gupta 065', 'varun.gupta065@gmail.com', '9000000065', 'Ujjain, Madhya Pradesh - 456001'),
('Simran Roy 066', 'simran.roy066@gmail.com', '9000000066', 'Raipur, Chhattisgarh - 492001'),
('Aarav Banerjee 067', 'aarav.banerjee067@gmail.com', '9000000067', 'Bhilai, Chhattisgarh - 490001'),
('Aditi Mukherjee 068', 'aditi.mukherjee068@gmail.com', '9000000068', 'Bilaspur, Chhattisgarh - 495001'),
('Arjun Chatterjee 069', 'arjun.chatterjee069@gmail.com', '9000000069', 'Panaji, Goa - 403001'),
('Ananya Sharma 070', 'ananya.sharma070@gmail.com', '9000000070', 'Margao, Goa - 403601'),

('Rahul Kumar 071', 'rahul.kumar071@gmail.com', '9000000071', 'Hyderabad, Telangana - 500001'),
('Priya Singh 072', 'priya.singh072@gmail.com', '9000000072', 'Banjara Hills, Hyderabad - 500034'),
('Rohan Das 073', 'rohan.das073@gmail.com', '9000000073', 'Warangal, Telangana - 506001'),
('Sneha Patel 074', 'sneha.patel074@gmail.com', '9000000074', 'Vijayawada, Andhra Pradesh - 520001'),
('Amit Gupta 075', 'amit.gupta075@gmail.com', '9000000075', 'Visakhapatnam, Andhra Pradesh - 530001'),
('Neha Roy 076', 'neha.roy076@gmail.com', '9000000076', 'Guntur, Andhra Pradesh - 522001'),
('Vikram Banerjee 077', 'vikram.banerjee077@gmail.com', '9000000077', 'Tirupati, Andhra Pradesh - 517501'),
('Pooja Mukherjee 078', 'pooja.mukherjee078@gmail.com', '9000000078', 'Bengaluru, Karnataka - 560001'),
('Karan Chatterjee 079', 'karan.chatterjee079@gmail.com', '9000000079', 'Whitefield, Bengaluru - 560066'),
('Riya Sharma 080', 'riya.sharma080@gmail.com', '9000000080', 'Mysuru, Karnataka - 570001'),

('Sanjay Kumar 081', 'sanjay.kumar081@gmail.com', '9000000081', 'Mangaluru, Karnataka - 575001'),
('Kavya Singh 082', 'kavya.singh082@gmail.com', '9000000082', 'Hubballi, Karnataka - 580020'),
('Nikhil Das 083', 'nikhil.das083@gmail.com', '9000000083', 'Chennai, Tamil Nadu - 600001'),
('Meera Patel 084', 'meera.patel084@gmail.com', '9000000084', 'T Nagar, Chennai - 600017'),
('Aditya Gupta 085', 'aditya.gupta085@gmail.com', '9000000085', 'Coimbatore, Tamil Nadu - 641001'),
('Ishita Roy 086', 'ishita.roy086@gmail.com', '9000000086', 'Madurai, Tamil Nadu - 625001'),
('Varun Banerjee 087', 'varun.banerjee087@gmail.com', '9000000087', 'Salem, Tamil Nadu - 636001'),
('Simran Mukherjee 088', 'simran.mukherjee088@gmail.com', '9000000088', 'Kochi, Kerala - 682001'),
('Aarav Chatterjee 089', 'aarav.chatterjee089@gmail.com', '9000000089', 'Thiruvananthapuram, Kerala - 695001'),
('Aditi Sharma 090', 'aditi.sharma090@gmail.com', '9000000090', 'Kozhikode, Kerala - 673001'),

('Arjun Kumar 091', 'arjun.kumar091@gmail.com', '9000000091', 'Thrissur, Kerala - 680001'),
('Ananya Singh 092', 'ananya.singh092@gmail.com', '9000000092', 'Chandigarh - 160001'),
('Rahul Das 093', 'rahul.das093@gmail.com', '9000000093', 'Ludhiana, Punjab - 141001'),
('Priya Patel 094', 'priya.patel094@gmail.com', '9000000094', 'Amritsar, Punjab - 143001'),
('Rohan Gupta 095', 'rohan.gupta095@gmail.com', '9000000095', 'Jalandhar, Punjab - 144001'),
('Sneha Roy 096', 'sneha.roy096@gmail.com', '9000000096', 'Patiala, Punjab - 147001'),
('Amit Banerjee 097', 'amit.banerjee097@gmail.com', '9000000097', 'Gurugram, Haryana - 122001'),
('Neha Mukherjee 098', 'neha.mukherjee098@gmail.com', '9000000098', 'Faridabad, Haryana - 121001'),
('Vikram Chatterjee 099', 'vikram.chatterjee099@gmail.com', '9000000099', 'Panipat, Haryana - 132103'),
('Pooja Sharma 100', 'pooja.sharma100@gmail.com', '9000000100', 'Karnal, Haryana - 132001'),

('Karan Kumar 101', 'karan.kumar101@gmail.com', '9000000101', 'Shimla, Himachal Pradesh - 171001'),
('Riya Singh 102', 'riya.singh102@gmail.com', '9000000102', 'Dharamshala, Himachal Pradesh - 176215'),
('Sanjay Das 103', 'sanjay.das103@gmail.com', '9000000103', 'Jammu, Jammu and Kashmir - 180001'),
('Kavya Patel 104', 'kavya.patel104@gmail.com', '9000000104', 'Srinagar, Jammu and Kashmir - 190001'),
('Nikhil Gupta 105', 'nikhil.gupta105@gmail.com', '9000000105', 'Imphal, Manipur - 795001'),
('Meera Roy 106', 'meera.roy106@gmail.com', '9000000106', 'Shillong, Meghalaya - 793001'),
('Aditya Banerjee 107', 'aditya.banerjee107@gmail.com', '9000000107', 'Agartala, Tripura - 799001'),
('Ishita Mukherjee 108', 'ishita.mukherjee108@gmail.com', '9000000108', 'Aizawl, Mizoram - 796001'),
('Varun Chatterjee 109', 'varun.chatterjee109@gmail.com', '9000000109', 'Kohima, Nagaland - 797001'),
('Simran Sharma 110', 'simran.sharma110@gmail.com', '9000000110', 'Itanagar, Arunachal Pradesh - 791111'),

('Aarav Kumar 111', 'aarav.kumar111@gmail.com', '9000000111', 'Gangtok, Sikkim - 737101'),
('Aditi Singh 112', 'aditi.singh112@gmail.com', '9000000112', 'Ranchi, Jharkhand - 834001'),
('Arjun Das 113', 'arjun.das113@gmail.com', '9000000113', 'Dhanbad, Jharkhand - 826001'),
('Ananya Patel 114', 'ananya.patel114@gmail.com', '9000000114', 'Bokaro, Jharkhand - 827004'),
('Rahul Gupta 115', 'rahul.gupta115@gmail.com', '9000000115', 'Deoghar, Jharkhand - 814112'),
('Priya Roy 116', 'priya.roy116@gmail.com', '9000000116', 'Cuttack, Odisha - 753001'),
('Rohan Banerjee 117', 'rohan.banerjee117@gmail.com', '9000000117', 'Berhampur, Odisha - 760001'),
('Sneha Mukherjee 118', 'sneha.mukherjee118@gmail.com', '9000000118', 'Puri, Odisha - 752001'),
('Amit Chatterjee 119', 'amit.chatterjee119@gmail.com', '9000000119', 'Siliguri, West Bengal - 734001'),
('Neha Sharma 120', 'neha.sharma120@gmail.com', '9000000120', 'Durgapur, West Bengal - 713216'),

('Vikram Kumar 121', 'vikram.kumar121@gmail.com', '9000000121', 'Asansol, West Bengal - 713301'),
('Pooja Singh 122', 'pooja.singh122@gmail.com', '9000000122', 'Howrah, West Bengal - 711101'),
('Karan Das 123', 'karan.das123@gmail.com', '9000000123', 'Barasat, West Bengal - 700124'),
('Riya Patel 124', 'riya.patel124@gmail.com', '9000000124', 'Kolkata, West Bengal - 700001'),
('Sanjay Gupta 125', 'sanjay.gupta125@gmail.com', '9000000125', 'Kolkata, West Bengal - 700091'),
('Kavya Roy 126', 'kavya.roy126@gmail.com', '9000000126', 'Kolkata, West Bengal - 700156'),
('Nikhil Banerjee 127', 'nikhil.banerjee127@gmail.com', '9000000127', 'Kolkata, West Bengal - 700016'),
('Meera Mukherjee 128', 'meera.mukherjee128@gmail.com', '9000000128', 'Kolkata, West Bengal - 700019'),
('Aditya Chatterjee 129', 'aditya.chatterjee129@gmail.com', '9000000129', 'Kolkata, West Bengal - 700020'),
('Ishita Sharma 130', 'ishita.sharma130@gmail.com', '9000000130', 'Kolkata, West Bengal - 700029'),

('Varun Kumar 131', 'varun.kumar131@gmail.com', '9000000131', 'Mumbai, Maharashtra - 400001'),
('Simran Singh 132', 'simran.singh132@gmail.com', '9000000132', 'Pune, Maharashtra - 411001'),
('Aarav Das 133', 'aarav.das133@gmail.com', '9000000133', 'Nagpur, Maharashtra - 440001'),
('Aditi Patel 134', 'aditi.patel134@gmail.com', '9000000134', 'Nashik, Maharashtra - 422001'),
('Arjun Gupta 135', 'arjun.gupta135@gmail.com', '9000000135', 'Thane, Maharashtra - 400601'),
('Ananya Roy 136', 'ananya.roy136@gmail.com', '9000000136', 'Kolhapur, Maharashtra - 416001'),
('Rahul Banerjee 137', 'rahul.banerjee137@gmail.com', '9000000137', 'Ahmedabad, Gujarat - 380001'),
('Priya Mukherjee 138', 'priya.mukherjee138@gmail.com', '9000000138', 'Surat, Gujarat - 395003'),
('Rohan Chatterjee 139', 'rohan.chatterjee139@gmail.com', '9000000139', 'Vadodara, Gujarat - 390001'),
('Sneha Sharma 140', 'sneha.sharma140@gmail.com', '9000000140', 'Rajkot, Gujarat - 360001'),

('Amit Kumar 141', 'amit.kumar141@gmail.com', '9000000141', 'Ahmedabad, Gujarat - 380015'),
('Neha Singh 142', 'neha.singh142@gmail.com', '9000000142', 'Gandhinagar, Gujarat - 382010'),
('Vikram Das 143', 'vikram.das143@gmail.com', '9000000143', 'Jaipur, Rajasthan - 302001'),
('Pooja Patel 144', 'pooja.patel144@gmail.com', '9000000144', 'Jodhpur, Rajasthan - 342001'),
('Karan Gupta 145', 'karan.gupta145@gmail.com', '9000000145', 'Udaipur, Rajasthan - 313001'),
('Riya Roy 146', 'riya.roy146@gmail.com', '9000000146', 'Kota, Rajasthan - 324001'),
('Sanjay Banerjee 147', 'sanjay.banerjee147@gmail.com', '9000000147', 'Ajmer, Rajasthan - 305001'),
('Kavya Mukherjee 148', 'kavya.mukherjee148@gmail.com', '9000000148', 'Bhopal, Madhya Pradesh - 462001'),
('Nikhil Chatterjee 149', 'nikhil.chatterjee149@gmail.com', '9000000149', 'Indore, Madhya Pradesh - 452001'),
('Meera Sharma 150', 'meera.sharma150@gmail.com', '9000000150', 'Gwalior, Madhya Pradesh - 474001'),

('Aditya Kumar 151', 'aditya.kumar151@gmail.com', '9000000151', 'Jabalpur, Madhya Pradesh - 482001'),
('Ishita Singh 152', 'ishita.singh152@gmail.com', '9000000152', 'Ujjain, Madhya Pradesh - 456001'),
('Varun Das 153', 'varun.das153@gmail.com', '9000000153', 'Raipur, Chhattisgarh - 492001'),
('Simran Patel 154', 'simran.patel154@gmail.com', '9000000154', 'Bhilai, Chhattisgarh - 490001'),
('Aarav Gupta 155', 'aarav.gupta155@gmail.com', '9000000155', 'Bilaspur, Chhattisgarh - 495001'),
('Aditi Roy 156', 'aditi.roy156@gmail.com', '9000000156', 'Hyderabad, Telangana - 500001'),
('Arjun Banerjee 157', 'arjun.banerjee157@gmail.com', '9000000157', 'Hyderabad, Telangana - 500034'),
('Ananya Mukherjee 158', 'ananya.mukherjee158@gmail.com', '9000000158', 'Warangal, Telangana - 506001'),
('Rahul Chatterjee 159', 'rahul.chatterjee159@gmail.com', '9000000159', 'Vijayawada, Andhra Pradesh - 520001'),
('Priya Sharma 160', 'priya.sharma160@gmail.com', '9000000160', 'Visakhapatnam, Andhra Pradesh - 530001'),

('Rohan Kumar 161', 'rohan.kumar161@gmail.com', '9000000161', 'Guntur, Andhra Pradesh - 522001'),
('Sneha Singh 162', 'sneha.singh162@gmail.com', '9000000162', 'Tirupati, Andhra Pradesh - 517501'),
('Amit Das 163', 'amit.das163@gmail.com', '9000000163', 'Bengaluru, Karnataka - 560001'),
('Neha Patel 164', 'neha.patel164@gmail.com', '9000000164', 'Mysuru, Karnataka - 570001'),
('Vikram Gupta 165', 'vikram.gupta165@gmail.com', '9000000165', 'Mangaluru, Karnataka - 575001'),
('Pooja Roy 166', 'pooja.roy166@gmail.com', '9000000166', 'Hubballi, Karnataka - 580020'),
('Karan Banerjee 167', 'karan.banerjee167@gmail.com', '9000000167', 'Chennai, Tamil Nadu - 600001'),
('Riya Mukherjee 168', 'riya.mukherjee168@gmail.com', '9000000168', 'Coimbatore, Tamil Nadu - 641001'),
('Sanjay Chatterjee 169', 'sanjay.chatterjee169@gmail.com', '9000000169', 'Madurai, Tamil Nadu - 625001'),
('Kavya Sharma 170', 'kavya.sharma170@gmail.com', '9000000170', 'Salem, Tamil Nadu - 636001'),

('Nikhil Kumar 171', 'nikhil.kumar171@gmail.com', '9000000171', 'Kochi, Kerala - 682001'),
('Meera Singh 172', 'meera.singh172@gmail.com', '9000000172', 'Thiruvananthapuram, Kerala - 695001'),
('Aditya Das 173', 'aditya.das173@gmail.com', '9000000173', 'Kozhikode, Kerala - 673001'),
('Ishita Patel 174', 'ishita.patel174@gmail.com', '9000000174', 'Thrissur, Kerala - 680001'),
('Varun Gupta 175', 'varun.gupta175@gmail.com', '9000000175', 'Chandigarh - 160001'),
('Simran Roy 176', 'simran.roy176@gmail.com', '9000000176', 'Ludhiana, Punjab - 141001'),
('Aarav Banerjee 177', 'aarav.banerjee177@gmail.com', '9000000177', 'Amritsar, Punjab - 143001'),
('Aditi Mukherjee 178', 'aditi.mukherjee178@gmail.com', '9000000178', 'Jalandhar, Punjab - 144001'),
('Arjun Chatterjee 179', 'arjun.chatterjee179@gmail.com', '9000000179', 'Patiala, Punjab - 147001'),
('Ananya Sharma 180', 'ananya.sharma180@gmail.com', '9000000180', 'Gurugram, Haryana - 122001'),

('Rahul Kumar 181', 'rahul.kumar181@gmail.com', '9000000181', 'Faridabad, Haryana - 121001'),
('Priya Singh 182', 'priya.singh182@gmail.com', '9000000182', 'Panipat, Haryana - 132103'),
('Rohan Das 183', 'rohan.das183@gmail.com', '9000000183', 'Karnal, Haryana - 132001'),
('Sneha Patel 184', 'sneha.patel184@gmail.com', '9000000184', 'Shimla, Himachal Pradesh - 171001'),
('Amit Gupta 185', 'amit.gupta185@gmail.com', '9000000185', 'Dharamshala, Himachal Pradesh - 176215'),
('Neha Roy 186', 'neha.roy186@gmail.com', '9000000186', 'Jammu, Jammu and Kashmir - 180001'),
('Vikram Banerjee 187', 'vikram.banerjee187@gmail.com', '9000000187', 'Srinagar, Jammu and Kashmir - 190001'),
('Pooja Mukherjee 188', 'pooja.mukherjee188@gmail.com', '9000000188', 'Imphal, Manipur - 795001'),
('Karan Chatterjee 189', 'karan.chatterjee189@gmail.com', '9000000189', 'Shillong, Meghalaya - 793001'),
('Riya Sharma 190', 'riya.sharma190@gmail.com', '9000000190', 'Agartala, Tripura - 799001'),

('Sanjay Kumar 191', 'sanjay.kumar191@gmail.com', '9000000191', 'Aizawl, Mizoram - 796001'),
('Kavya Singh 192', 'kavya.singh192@gmail.com', '9000000192', 'Kohima, Nagaland - 797001'),
('Nikhil Das 193', 'nikhil.das193@gmail.com', '9000000193', 'Itanagar, Arunachal Pradesh - 791111'),
('Meera Patel 194', 'meera.patel194@gmail.com', '9000000194', 'Gangtok, Sikkim - 737101'),
('Aditya Gupta 195', 'aditya.gupta195@gmail.com', '9000000195', 'Patna, Bihar - 800001'),
('Ishita Roy 196', 'ishita.roy196@gmail.com', '9000000196', 'Gaya, Bihar - 823001'),
('Varun Banerjee 197', 'varun.banerjee197@gmail.com', '9000000197', 'Muzaffarpur, Bihar - 842001'),
('Simran Mukherjee 198', 'simran.mukherjee198@gmail.com', '9000000198', 'Bhagalpur, Bihar - 812001'),
('Aarav Chatterjee 199', 'aarav.chatterjee199@gmail.com', '9000000199', 'Ranchi, Jharkhand - 834001'),
('Aditi Sharma 200', 'aditi.sharma200@gmail.com', '9000000200', 'Jamshedpur, Jharkhand - 831001'),

('Arjun Kumar 201', 'arjun.kumar201@gmail.com', '9000000201', 'Dhanbad, Jharkhand - 826001'),
('Ananya Singh 202', 'ananya.singh202@gmail.com', '9000000202', 'Bokaro, Jharkhand - 827004'),
('Rahul Das 203', 'rahul.das203@gmail.com', '9000000203', 'Bhubaneswar, Odisha - 751001'),
('Priya Patel 204', 'priya.patel204@gmail.com', '9000000204', 'Cuttack, Odisha - 753001'),
('Rohan Gupta 205', 'rohan.gupta205@gmail.com', '9000000205', 'Rourkela, Odisha - 769001'),
('Sneha Roy 206', 'sneha.roy206@gmail.com', '9000000206', 'Puri, Odisha - 752001'),
('Amit Banerjee 207', 'amit.banerjee207@gmail.com', '9000000207', 'Guwahati, Assam - 781001'),
('Neha Mukherjee 208', 'neha.mukherjee208@gmail.com', '9000000208', 'Dibrugarh, Assam - 786001'),
('Vikram Chatterjee 209', 'vikram.chatterjee209@gmail.com', '9000000209', 'Silchar, Assam - 788001'),
('Pooja Sharma 210', 'pooja.sharma210@gmail.com', '9000000210', 'Jorhat, Assam - 785001'),

('Karan Kumar 211', 'karan.kumar211@gmail.com', '9000000211', 'Kolkata, West Bengal - 700001'),
('Riya Singh 212', 'riya.singh212@gmail.com', '9000000212', 'New Town, Kolkata - 700156'),
('Sanjay Das 213', 'sanjay.das213@gmail.com', '9000000213', 'Mumbai, Maharashtra - 400001'),
('Kavya Patel 214', 'kavya.patel214@gmail.com', '9000000214', 'Pune, Maharashtra - 411001'),
('Nikhil Gupta 215', 'nikhil.gupta215@gmail.com', '9000000215', 'Bengaluru, Karnataka - 560001'),
('Meera Roy 216', 'meera.roy216@gmail.com', '9000000216', 'Chennai, Tamil Nadu - 600001'),
('Aditya Banerjee 217', 'aditya.banerjee217@gmail.com', '9000000217', 'Hyderabad, Telangana - 500001'),
('Ishita Mukherjee 218', 'ishita.mukherjee218@gmail.com', '9000000218', 'Ahmedabad, Gujarat - 380001'),
('Varun Chatterjee 219', 'varun.chatterjee219@gmail.com', '9000000219', 'Jaipur, Rajasthan - 302001'),
('Simran Sharma 220', 'simran.sharma220@gmail.com', '9000000220', 'Lucknow, Uttar Pradesh - 226001');




-- Verify there are no duplicate emails--
SELECT email, COUNT(*) AS total
FROM Customer
GROUP BY email
HAVING COUNT(*) > 1;

-- Verify there are no duplicate phone numbers
SELECT phone, COUNT(*) AS total
FROM Customer
GROUP BY phone
HAVING COUNT(*) > 1;

-- Verify total customers
SELECT COUNT(*) AS total_customers
FROM Customer;

-- 1. First find duplicates
USE fintech_banking_db;

SELECT email, COUNT(*) AS total
FROM Customer
GROUP BY email
HAVING COUNT(*) > 1;

-- For duplicate phone numbers:

SELECT phone, COUNT(*) AS total
FROM Customer
GROUP BY phone
HAVING COUNT(*) > 1;
-- 2. See the actual duplicate records

SELECT *
FROM Customer
WHERE email = 'example@gmail.com';
-- 3. Delete a specific duplicate

-- First check the IDs:

SELECT customer_id, name, email, phone
FROM Customer
WHERE email = 'example@gmail.com';

-- Suppose you get:


DELETE FROM Customer
WHERE customer_id IN (102, 103);



USE fintech_banking_db;

SELECT customer_id, name, email, phone, address
FROM Customer
WHERE email = 'jishan@example.com';

SELECT * FROM Account
WHERE customer_id IN (2, 3, 4, 5);

SELECT * FROM Transaction
WHERE customer_id IN (2, 3, 4, 5);

SELECT *
FROM Account
WHERE customer_id IN (2, 3, 4, 5);

SELECT email, COUNT(*) AS total
FROM Users
GROUP BY email
HAVING COUNT(*) > 1;

SELECT phone, COUNT(*) AS total
FROM Users
GROUP BY phone
HAVING COUNT(*) > 1;

ALTER TABLE Users
ADD CONSTRAINT unique_users_email UNIQUE (email);

ALTER TABLE Users
ADD CONSTRAINT unique_users_phone UNIQUE (phone);

USE fintech_banking_db;

SHOW INDEX FROM Users;


SELECT
    INDEX_NAME,
    COLUMN_NAME,
    NON_UNIQUE
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = 'fintech_banking_db'
  AND TABLE_NAME = 'Users'
  AND COLUMN_NAME IN ('email', 'phone');
  
  USE fintech_banking_db;

ALTER TABLE Users
DROP INDEX unique_users_email,
DROP INDEX unique_users_phone;

SHOW INDEX FROM Users;


SHOW TABLES;
SELECT * FROM users;

INSERT INTO users
(customer_id, name, email, password, role)
VALUES
(6, 'Aarav Sharma 001', 'aarav@gmail.com', 'Aarav@123', 'user');





SELECT 
    a.account_id,
    a.customer_id,
    a.account_number,
    c.name,
    c.email,
    a.balance,
    a.status
FROM Account a
JOIN Customer c ON a.customer_id = c.customer_id
ORDER BY a.account_id;

INSERT INTO Beneficiary
(account_id, beneficiary_name, beneficiary_account_no, bank_name, IFSC, status)
VALUES
(1, 'Aarav Sharma 001', 'IBI0000000006', 'IBI Bank', 'IBIB0001003', 'Active');


SELECT * FROM Beneficiary;

USE fintech_banking_db;

SELECT 
    a.account_id,
    a.account_number,
    a.customer_id,
    c.name AS customer_name,
    c.email,
    a.balance,
    a.status
FROM Account a
JOIN Customer c ON a.customer_id = c.customer_id
ORDER BY a.account_id;

USE fintech_banking_db;

ALTER TABLE Beneficiary
ADD COLUMN account_type_id INT NULL AFTER account_id;

ALTER TABLE Beneficiary
ADD CONSTRAINT fk_beneficiary_account_type
FOREIGN KEY (account_type_id)
REFERENCES Account_Type(account_type_id);

DESCRIBE Beneficiary;

UPDATE Beneficiary b
JOIN Account a
    ON b.beneficiary_account_no = a.account_number
SET b.account_type_id = a.account_type_id
WHERE b.beneficiary_id > 0;

SELECT
    beneficiary_id,
    beneficiary_name,
    beneficiary_account_no,
    account_type_id
FROM Beneficiary;

DESCRIBE Beneficiary;
DESCRIBE Account;

SELECT
    b.beneficiary_id,
    b.status AS beneficiary_status
FROM Beneficiary AS b
INNER JOIN Account AS a
    ON b.account_id = a.account_id
WHERE a.customer_id = 6
  AND b.beneficiary_account_no = 'IBI0000000011'
LIMIT 1;

SELECT
    c.customer_id,
    c.name,
    c.email,
    a.account_id,
    a.account_number,
    a.status
FROM Customer c
INNER JOIN Account a
    ON c.customer_id = a.customer_id
WHERE c.email = 'aarav.sharma001@gmail.com';

SELECT
    b.beneficiary_id,
    b.status
FROM Beneficiary b
INNER JOIN Account a
    ON b.account_id = a.account_id
    


ALTER TABLE Fund_Transfer
MODIFY beneficiary_id INT NULL;

ALTER TABLE Fund_Transfer
ADD COLUMN receiver_account_id INT NULL AFTER sender_account_id;

ALTER TABLE Fund_Transfer
MODIFY beneficiary_id INT NULL;

DESCRIBE Loan;

SELECT * FROM Loan;

DESCRIBE EMI_Payment;

CREATE TABLE IF NOT EXISTS Loan_Type (
    loan_type_id INT AUTO_INCREMENT PRIMARY KEY,
    loan_type VARCHAR(50) NOT NULL UNIQUE,
    interest_rate DECIMAL(5,2) NOT NULL
);

INSERT INTO Loan_Type
    (loan_type, interest_rate)
VALUES
    ('Personal Loan', 10.50),
    ('Home Loan', 8.00),
    ('Education Loan', 7.50),
    ('Vehicle Loan', 9.00),
    ('Business Loan', 11.00),
    ('Gold Loan', 9.50),
    ('Agricultural Loan', 7.00),
    ('Medical Loan', 8.50),
    ('Wedding Loan', 10.00),
    ('Travel Loan', 10.50)
ON DUPLICATE KEY UPDATE
    interest_rate = VALUES(interest_rate);
    
    SELECT * FROM Loan_Type;

ALTER TABLE EMI_Payment
ADD COLUMN late_fee DECIMAL(15,2) NOT NULL DEFAULT 0.00;

SELECT
    emi_id,
    loan_id,
    due_date,
    amount,
    late_fee,
    payment_date,
    status
FROM EMI_Payment
ORDER BY emi_id DESC;

USE fintech_banking_db;

SELECT
    l.loan_id,
    l.customer_id,
    c.name,
    a.account_id,
    a.account_number,
    a.balance,
    a.status
FROM Loan l
JOIN Customer c ON c.customer_id = l.customer_id
JOIN Account a ON a.customer_id = c.customer_id
WHERE l.loan_id = 3;

USE fintech_banking_db;

UPDATE EMI_Payment
SET due_date = CURDATE()
WHERE emi_id = 156;

SELECT
    emi_id,
    due_date,
    amount,
    late_fee,
    payment_date,
    status
FROM EMI_Payment
WHERE emi_id = 156;

USE fintech_banking_db;

SHOW COLUMNS FROM `Transaction`;

USE fintech_banking_db;

SELECT
    emi_id,
    due_date,
    CURDATE() AS today,
    status,
    amount
FROM EMI_Payment
WHERE emi_id = 156
  AND due_date <= CURDATE()
  AND status <> 'Paid';
  
  SELECT CURDATE() AS mysql_today;
  
  SELECT
    emi_id,
    due_date,
    status,
    amount
FROM EMI_Payment
WHERE emi_id = 156;

SELECT
    account_id,
    account_number,
    balance
FROM Account
WHERE account_id = 7;

SELECT
    transaction_id,
    account_id,
    transaction_type,
    amount,
    transaction_date,
    description
FROM `Transaction`
WHERE account_id = 7
  AND transaction_type = 'EMI'
ORDER BY transaction_id DESC;

SELECT
    emi_id,
    loan_id,
    due_date,
    amount,
    late_fee,
    status
FROM EMI_Payment
WHERE status <> 'Paid'
ORDER BY emi_id;

SELECT
    e.emi_id,
    e.loan_id,
    l.customer_id,
    c.name,
    a.account_id,
    a.account_number,
    a.balance,
    a.status
FROM EMI_Payment e
JOIN Loan l ON l.loan_id = e.loan_id
JOIN Customer c ON c.customer_id = l.customer_id
JOIN Account a ON a.customer_id = l.customer_id
WHERE e.emi_id = 1;

USE fintech_banking_db;

UPDATE Account
SET balance = 100.00
WHERE account_id = 7;

UPDATE EMI_Payment
SET due_date = CURDATE(),
    late_fee = 0.00,
    status = 'Pending',
    payment_date = NULL
WHERE emi_id = 1;

SELECT
    emi_id,
    due_date,
    amount,
    late_fee,
    payment_date,
    status
FROM EMI_Payment
WHERE emi_id = 1;

SELECT
    account_id,
    account_number,
    balance
FROM Account
WHERE account_id = 7;

USE fintech_banking_db;

UPDATE Account
SET balance = 15000.00
WHERE account_id = 7;

SELECT
    emi_id,
    amount,
    late_fee,
    payment_date,
    status
FROM EMI_Payment
WHERE emi_id = 1;

SELECT
    account_id,
    account_number,
    balance
FROM Account
WHERE account_id = 7;

SELECT
    transaction_id,
    account_id,
    transaction_type,
    amount,
    transaction_date,
    description
FROM `Transaction`
WHERE account_id = 7
ORDER BY transaction_id DESC
LIMIT 3;

SELECT
    emi_id,
    loan_id,
    due_date,
    amount,
    late_fee,
    payment_date,
    status
FROM EMI_Payment
ORDER BY emi_id DESC;

UPDATE EMI_Payment
SET due_date = CURDATE(),
    status = 'Pending',
    late_fee = 0,
    payment_date = NULL
WHERE emi_id = 37;

SELECT
    emi_id,
    due_date,
    amount,
    late_fee,
    payment_date,
    status
FROM EMI_Payment
WHERE emi_id = 37;

SELECT
    a.account_id,
    a.account_number,
    a.balance,
    a.status
FROM Account a
WHERE a.customer_id = (
    SELECT l.customer_id
    FROM Loan l
    JOIN EMI_Payment e ON e.loan_id = l.loan_id
    WHERE e.emi_id = 37
)
AND a.status = 'Active';

UPDATE Account
SET balance = 20000.00
WHERE account_id = 7;

SELECT
    emi_id,
    amount,
    late_fee,
    payment_date,
    status
FROM EMI_Payment
WHERE emi_id = 37;

SELECT
    account_id,
    balance,
    status
FROM Account
WHERE account_id = 7;

SELECT
    transaction_id,
    account_id,
    transaction_type,
    amount,
    transaction_date,
    description
FROM `Transaction`
WHERE account_id = 7
ORDER BY transaction_id DESC
LIMIT 5;

SELECT
    emi_id,
    loan_id,
    due_date,
    amount,
    late_fee,
    payment_date,
    status
FROM EMI_Payment
WHERE emi_id = 37;

SELECT
    COUNT(*) AS emi_transactions,
    COALESCE(SUM(amount), 0) AS total_amount
FROM `Transaction`
WHERE account_id = 7
  AND transaction_type = 'EMI'
  AND description = 'Automatic EMI Payment + Late Fee';
  
  SELECT
    emi_id,
    loan_id,
    due_date,
    amount,
    late_fee,
    payment_date,
    status
FROM EMI_Payment
ORDER BY emi_id DESC
LIMIT 10;

DESCRIBE Customer;

ALTER TABLE Customer
ADD COLUMN status VARCHAR(20) NOT NULL DEFAULT 'Active';

DESCRIBE Customer;

SELECT customer_id, name, status
FROM Customer
LIMIT 5;

ALTER TABLE Customer
ADD COLUMN status VARCHAR(20) NOT NULL DEFAULT 'Active';

DESCRIBE Customer;

SELECT customer_id, name, status
FROM Customer;

UPDATE Customer
SET status = 'Active'
WHERE customer_id = 6;

SELECT customer_id, name, status
FROM Customer
WHERE customer_id = 6;

SELECT COUNT(*) AS total_customers FROM Customer;
SELECT COUNT(*) AS total_accounts FROM Account;
SELECT COUNT(*) AS total_transactions FROM `Transaction`;

UPDATE Customer
SET status = 'Inactive'
WHERE customer_id = 6;

SELECT customer_id, name, status
FROM Customer;

DELETE FROM Beneficiary
WHERE beneficiary_id = 8


USE fintech_banking_db;

DESCRIBE Beneficiary;

DESCRIBE fund_transfer;


USE fintech_banking_db;

SHOW TABLES;


USE fintech_banking_db;

DESCRIBE account;

DESCRIBE customer;


USE fintech_banking_db;

ALTER TABLE beneficiary
ADD COLUMN deleted_at DATETIME NULL DEFAULT NULL;


UPDATE beneficiary
SET deleted_at = CURRENT_TIMESTAMP
WHERE beneficiary_id = 8
  AND LOWER(TRIM(status)) = 'inactive'
  AND deleted_at IS NULL;


SELECT
    beneficiary_id,
    account_id,
    account_type_id,
    beneficiary_name,
    beneficiary_account_no,
    bank_name,
    IFSC,
    status
FROM beneficiary
WHERE deleted_at IS NULL;

SELECT
    transfer_id,
    beneficiary_id,
    amount,
    transfer_date,
    status,
    reference_no
FROM fund_transfer
WHERE beneficiary_id = 8;


USE fintech_banking_db;

SHOW COLUMNS FROM beneficiary LIKE 'deleted_at';


USE fintech_banking_db;

SELECT
    b.beneficiary_id,
    b.account_id,
    b.beneficiary_name,
    b.status,
    b.deleted_at,
    a.customer_id,
    c.email
FROM beneficiary b
LEFT JOIN account a
    ON a.account_id = b.account_id
LEFT JOIN customer c
    ON c.customer_id = a.customer_id
WHERE b.beneficiary_id = 8;

SELECT
    b.beneficiary_id,
    b.beneficiary_name,
    b.status,
    b.deleted_at,
    c.email
FROM beneficiary b
INNER JOIN account a ON a.account_id = b.account_id
INNER JOIN customer c ON c.customer_id = a.customer_id
WHERE b.beneficiary_id = 9;

ALTER TABLE beneficiary
ADD COLUMN deleted_at DATETIME NULL DEFAULT NULL;

USE fintech_banking_db;

-- 1. Check the beneficiary table structure
DESCRIBE Beneficiary;

-- 2. Find the beneficiary ID you are trying to delete
SELECT
    b.beneficiary_id,
    b.account_id,
    b.beneficiary_name,
    b.beneficiary_account_no,
    CONCAT('[', b.status, ']') AS stored_status,
    c.customer_id,
    CONCAT('[', c.email, ']') AS stored_email
FROM Beneficiary b
LEFT JOIN Account a
    ON a.account_id = b.account_id
LEFT JOIN Customer c
    ON c.customer_id = a.customer_id
ORDER BY b.beneficiary_id DESC;

SHOW COLUMNS FROM Beneficiary LIKE 'deleted_at';

USE fintech_banking_db;

DESCRIBE Customer;
DESCRIBE Users;
DESCRIBE Account;
DESCRIBE Account_Type;
DESCRIBE Branch;

DESCRIBE Customer;
DESCRIBE Users;
DESCRIBE Account;
DESCRIBE Account_Type;

USE fintech_banking_db;

SHOW CREATE TABLE Users;
SHOW CREATE TABLE Account;
SHOW CREATE TABLE Account_Type;
USE fintech_banking_db;

DESCRIBE Account;


SELECT
    customer_id,
    name,
    email,
    phone,
    address,
    status
FROM Customer
ORDER BY customer_id DESC;

SELECT
    user_id,
    name,
    email,
    phone,
    role
FROM Users
ORDER BY user_id DESC;
SELECT
    user_id,
    name,
    email,
    phone,
    role
FROM Users
WHERE LOWER(TRIM(email)) = LOWER(TRIM('narendrada29@gmail.com'))
   OR TRIM(phone) = TRIM('86559628936');
   
   SELECT
    c.customer_id,
    c.name,
    c.email,
    c.phone,
    a.account_id,
    a.account_number,
    a.balance,
    a.status
FROM Customer c
LEFT JOIN Account a
    ON a.customer_id = c.customer_id
WHERE LOWER(TRIM(c.email)) = LOWER(TRIM('narendrada29@gmail.com'))
   OR TRIM(c.phone) = TRIM('86559628936');
   
   USE fintech_banking_db;

SELECT
    c.customer_id,
    c.name AS customer_name,
    c.email AS customer_email,
    c.phone AS customer_phone,
    u.user_id,
    u.name AS login_name,
    u.email AS login_email,
    u.phone AS login_phone,
    a.account_id,
    a.account_number
FROM Customer c
LEFT JOIN Users u
    ON LOWER(TRIM(c.email)) = LOWER(TRIM(u.email))
LEFT JOIN Account a
    ON a.customer_id = c.customer_id
WHERE c.customer_id IN (1, 2, 3, 4, 5, 6, 7)
ORDER BY c.customer_id;

USE fintech_banking_db;

SELECT *
FROM Account
WHERE customer_id IN (2, 3, 4, 5);

USE fintech_banking_db;

START TRANSACTION;

DELETE FROM Customer
WHERE customer_id IN (2, 3, 4, 5)
  AND email = 'jishan@example.com'
  AND phone = '9876543210';

SELECT ROW_COUNT() AS deleted_records;

COMMIT;

SHOW CREATE TABLE Users;
SHOW CREATE TABLE Customer;
SHOW CREATE TABLE Account;

USE fintech_banking_db;

SHOW CREATE TABLE users;

USE fintech_banking_db;

SHOW CREATE TABLE users\G

USE fintech_banking_db;

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    COLUMN_TYPE,
    IS_NULLABLE,
    COLUMN_KEY,
    COLUMN_DEFAULT,
    EXTRA
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND LOWER(TABLE_NAME) IN ('users', 'customer', 'account')
ORDER BY TABLE_NAME, ORDINAL_POSITION;

SELECT
    TABLE_NAME,
    INDEX_NAME,
    NON_UNIQUE,
    COLUMN_NAME,
    SEQ_IN_INDEX
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = DATABASE()
  AND LOWER(TABLE_NAME) IN ('users', 'customer', 'account')
ORDER BY TABLE_NAME, INDEX_NAME, SEQ_IN_INDEX;




USE fintech_banking_db;

ALTER TABLE users
ADD COLUMN email_verified_at DATETIME NULL,
ADD COLUMN token_version INT NOT NULL DEFAULT 0;

CREATE TABLE  email_verification_codes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NULL,
    email VARCHAR(100) NOT NULL,
    purpose ENUM('signup', 'login', 'password_reset') NOT NULL,
    code_hash VARCHAR(255) NOT NULL,
    expires_at DATETIME NOT NULL,
    attempts INT NOT NULL DEFAULT 0,
    consumed_at DATETIME NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_verification_email_purpose (email, purpose),
    INDEX idx_verification_expiry (expires_at),
    CONSTRAINT fk_verification_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE
);

USE fintech_banking_db;

SELECT user_id, name, email, role
FROM Users
WHERE role = 'admin';

UPDATE Users
SET email = 'skjishan0018@gmail.com'
WHERE user_id = 1
  AND role = 'admin';
  
  USE fintech_banking_db;

SELECT user_id, name, email, role
FROM Users
WHERE role = 'admin';

SELECT user_id, name, email, role
FROM Users
WHERE email = 'admin@bank.com';

UPDATE Users
SET email = 'skjishan0018@gmail.com'
WHERE user_id = 22
  AND role = 'admin';
  
  DESCRIBE Users;
  
  
ALTER TABLE Users
MODIFY COLUMN role
ENUM('user', 'admin', 'main_admin')
NOT NULL DEFAULT 'user';

ALTER TABLE Users
ADD COLUMN is_active TINYINT(1) NOT NULL DEFAULT 1;


ALTER TABLE Users
MODIFY COLUMN role
ENUM('user', 'admin', 'main_admin')
NOT NULL DEFAULT 'user';

UPDATE Users
SET role = 'main_admin',
    is_active = 1,
    token_version = token_version + 1
WHERE LOWER(TRIM(email)) = 'skjishan0018@gmail.com';

SELECT user_id, name, email, role, is_active
FROM Users
WHERE email = 'skjishan0018@gmail.com';


SELECT
    user_id,
    name,
    email,
    role,
    is_active,
    email_verified_at,
    CASE
        WHEN password LIKE '$2%' THEN 'bcrypt hash'
        ELSE 'other format'
    END AS password_format,
    LENGTH(password) AS password_length
FROM Users
WHERE LOWER(TRIM(email)) = 'skjishan0018@gmail.com';
UPDATE Users
SET role = 'main_admin',
    is_active = 1,
    token_version = token_version + 1
WHERE user_id = 22;

SELECT user_id, name, email, role, is_active, token_version
FROM Users
WHERE email = 'skjishan0018@gmail.com';


SELECT
    user_id,
    role,
    is_active,
    CASE
        WHEN password REGEXP '^\\$2[aby]\\$'
            THEN 'bcrypt'
        ELSE 'not bcrypt'
    END AS password_format,
    LENGTH(password) AS password_length
FROM Users
WHERE user_id = 22;

INSERT INTO Users
    (name, email, phone, password, role,
     email_verified_at, token_version, is_active)
VALUES (?, ?, ?, ?, 'admin', NOW(), 0, 1)


INSERT INTO Users
    (name, email, phone, password, role,
     email_verified_at, token_version, is_active)
VALUES
    ('Test Employee',
     'employee.test@ibibank.com',
     '9876543210',
     '$2b$12$REPLACE_WITH_A_REAL_BCRYPT_HASH',
     'admin',
     NOW(),
     0,
     1);
     
     
     
     
     
     
     
     
     
 
USE fintech_banking_db;

-- 1. List all existing tables
SHOW FULL TABLES
WHERE Table_type = 'BASE TABLE';

-- 2. Inspect columns and data types
SELECT
    TABLE_NAME,
    ORDINAL_POSITION,
    COLUMN_NAME,
    COLUMN_TYPE,
    IS_NULLABLE,
    COLUMN_KEY,
    COLUMN_DEFAULT,
    EXTRA
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'fintech_banking_db'
ORDER BY TABLE_NAME, ORDINAL_POSITION;

-- 3. Inspect primary-key and foreign-key relationships
SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'fintech_banking_db'
ORDER BY TABLE_NAME, CONSTRAINT_NAME, ORDINAL_POSITION;

-- 4. Find existing views
SELECT TABLE_NAME AS view_name
FROM information_schema.VIEWS
WHERE TABLE_SCHEMA = 'fintech_banking_db';

-- 5. Find existing stored procedures and functions
SELECT ROUTINE_NAME, ROUTINE_TYPE
FROM information_schema.ROUTINES
WHERE ROUTINE_SCHEMA = 'fintech_banking_db';

-- 6. Find existing triggers
SELECT
    TRIGGER_NAME,
    EVENT_MANIPULATION,
    EVENT_OBJECT_TABLE,
    ACTION_TIMING
FROM information_schema.TRIGGERS
WHERE TRIGGER_SCHEMA = 'fintech_banking_db'
ORDER BY EVENT_OBJECT_TABLE, TRIGGER_NAME;

-- 7. Inspect indexes
SELECT
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME,
    NON_UNIQUE
FROM information_schema.STATISTICS
WHERE TABLE_SCHEMA = 'fintech_banking_db'
ORDER BY TABLE_NAME, INDEX_NAME, SEQ_IN_INDEX;
    
    
    
    
    
USE fintech_banking_db;

SELECT 'VIEWS' AS object_type, COUNT(*) AS total
FROM information_schema.VIEWS
WHERE TABLE_SCHEMA = 'fintech_banking_db'

UNION ALL

SELECT 'PROCEDURES', COUNT(*)
FROM information_schema.ROUTINES
WHERE ROUTINE_SCHEMA = 'fintech_banking_db'
  AND ROUTINE_TYPE = 'PROCEDURE'

UNION ALL

SELECT 'FUNCTIONS', COUNT(*)
FROM information_schema.ROUTINES
WHERE ROUTINE_SCHEMA = 'fintech_banking_db'
  AND ROUTINE_TYPE = 'FUNCTION'

UNION ALL

SELECT 'TRIGGERS', COUNT(*)
FROM information_schema.TRIGGERS
WHERE TRIGGER_SCHEMA = 'fintech_banking_db';




USE fintech_banking_db;

SELECT 'customer' AS table_name, COUNT(*) AS total_records FROM customer
UNION ALL
SELECT 'users', COUNT(*) FROM users
UNION ALL
SELECT 'account', COUNT(*) FROM account
UNION ALL
SELECT 'account_type', COUNT(*) FROM account_type
UNION ALL
SELECT 'branch', COUNT(*) FROM branch
UNION ALL
SELECT 'beneficiary', COUNT(*) FROM beneficiary
UNION ALL
SELECT 'fund_transfer', COUNT(*) FROM fund_transfer
UNION ALL
SELECT 'transaction', COUNT(*) FROM `transaction`
UNION ALL
SELECT 'loan', COUNT(*) FROM loan
UNION ALL
SELECT 'loan_type', COUNT(*) FROM loan_type
UNION ALL
SELECT 'emi_payment', COUNT(*) FROM emi_payment
UNION ALL
SELECT 'email_verification_codes', COUNT(*) FROM email_verification_codes;



USE fintech_banking_db;

-- A. Check transfers with missing or invalid receiver accounts
SELECT
    COUNT(*) AS total_transfers,
    SUM(receiver_account_id IS NULL) AS missing_receiver_ids,
    SUM(
        receiver_account_id IS NOT NULL
        AND NOT EXISTS (
            SELECT 1
            FROM account a
            WHERE a.account_id = fund_transfer.receiver_account_id
        )
    ) AS receiver_accounts_not_found
FROM fund_transfer;

-- B. Compare loan categories with the loan_type table
SELECT DISTINCT l.loan_type
FROM loan l
LEFT JOIN loan_type lt
    ON LOWER(TRIM(l.loan_type)) = LOWER(TRIM(lt.loan_type))
WHERE lt.loan_type_id IS NULL;

-- C. Check the branch records for duplicate IFSC codes
SELECT IFSC, COUNT(*) AS occurrences
FROM branch
WHERE IFSC IS NOT NULL AND TRIM(IFSC) <> ''
GROUP BY IFSC
HAVING COUNT(*) > 1;


USE fintech_banking_db;

SELECT
    branch_id,
    branch_name,
    IFSC,
    city
FROM branch
WHERE IFSC IN (
    SELECT IFSC
    FROM branch
    WHERE IFSC IS NOT NULL
      AND TRIM(IFSC) <> ''
    GROUP BY IFSC
    HAVING COUNT(*) > 1
)
ORDER BY IFSC, branch_id;


SELECT
    COUNT(*) AS total_branch_records,
    COUNT(DISTINCT IFSC) AS distinct_ifsc_codes,
    COUNT(*) - COUNT(DISTINCT IFSC) AS repeated_code_excess_rows
FROM branch
WHERE IFSC IS NOT NULL
  AND TRIM(IFSC) <> '';
  
  
  USE fintech_banking_db;

SELECT
    b.branch_id,
    b.branch_name,
    b.IFSC,
    b.city,
    COUNT(a.account_id) AS linked_accounts
FROM branch b
LEFT JOIN account a
    ON a.branch_id = b.branch_id
GROUP BY
    b.branch_id,
    b.branch_name,
    b.IFSC,
    b.city
ORDER BY
    b.IFSC,
    b.branch_id;
    
    
    SELECT
    COUNT(DISTINCT branch_id) AS branch_ids_used_by_accounts,
    COUNT(*) AS total_accounts,
    SUM(branch_id IS NULL) AS accounts_without_branch
FROM account;


USE fintech_banking_db;

SELECT
    IFSC,
    COUNT(*) AS branch_records,
    SUM(account_count) AS linked_accounts,
    SUM(account_count = 0) AS unused_branch_records
FROM (
    SELECT
        b.branch_id,
        b.IFSC,
        COUNT(a.account_id) AS account_count
    FROM branch b
    LEFT JOIN account a
        ON a.branch_id = b.branch_id
    WHERE b.IFSC IS NOT NULL
      AND TRIM(b.IFSC) <> ''
    GROUP BY b.branch_id, b.IFSC
) AS branch_usage
GROUP BY IFSC
HAVING COUNT(*) > 1
ORDER BY linked_accounts DESC, IFSC;

USE fintech_banking_db;

SELECT
    b.branch_id,
    b.branch_name,
    b.IFSC,
    b.city,
    COUNT(a.account_id) AS linked_accounts
FROM branch b
LEFT JOIN account a
    ON a.branch_id = b.branch_id
WHERE b.IFSC IN (
    SELECT IFSC
    FROM branch
    WHERE IFSC IS NOT NULL
      AND TRIM(IFSC) <> ''
    GROUP BY IFSC
    HAVING COUNT(*) > 1
)
GROUP BY
    b.branch_id,
    b.branch_name,
    b.IFSC,
    b.city
ORDER BY
    b.IFSC,
    b.branch_id;
    
    
    USE fintech_banking_db;

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE REFERENCED_TABLE_SCHEMA = 'fintech_banking_db'
  AND REFERENCED_TABLE_NAME = 'branch'
ORDER BY TABLE_NAME, COLUMN_NAME;


SELECT
    TRIGGER_NAME,
    EVENT_OBJECT_TABLE,
    ACTION_TIMING,
    EVENT_MANIPULATION
FROM information_schema.TRIGGERS
WHERE TRIGGER_SCHEMA = 'fintech_banking_db';


USE fintech_banking_db;

SELECT
    b.branch_id,
    b.branch_name,
    b.IFSC,
    COUNT(a.account_id) AS linked_accounts
FROM branch b
LEFT JOIN account a
    ON a.branch_id = b.branch_id
GROUP BY
    b.branch_id,
    b.branch_name,
    b.IFSC
HAVING COUNT(a.account_id) > 0
ORDER BY b.branch_id;


USE fintech_banking_db;

SELECT
    b.branch_name,
    b.IFSC,
    b.city,
    COUNT(*) AS matching_branch_rows,
    GROUP_CONCAT(
        CONCAT(
            b.branch_id,
            ' (accounts=',
            COALESCE(ac.account_count, 0),
            ')'
        )
        ORDER BY b.branch_id
        SEPARATOR ', '
    ) AS branch_ids_and_account_counts
FROM branch b
LEFT JOIN (
    SELECT
        branch_id,
        COUNT(*) AS account_count
    FROM account
    GROUP BY branch_id
) ac
    ON ac.branch_id = b.branch_id
GROUP BY
    b.branch_name,
    b.IFSC,
    b.city
HAVING COUNT(*) > 1
ORDER BY
    matching_branch_rows DESC,
    b.IFSC;
    
    USE fintech_banking_db;

SELECT
    COUNT(*) AS total_branch_rows,
    COUNT(DISTINCT IFSC) AS distinct_ifsc_codes,
    COUNT(DISTINCT branch_name, IFSC, city) AS distinct_branch_details
FROM branch;