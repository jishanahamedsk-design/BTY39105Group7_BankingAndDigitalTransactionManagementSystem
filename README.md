# IBI Bank — Banking and Digital Transaction Management System

**Course:** BTY39105 — Database Management System Lab  
**Institution:** Brainware University  
**Group:** 7  
**Project Type:** Project-Based Learning (PBL)

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Problem Statement](#2-problem-statement)
3. [Project Objectives](#3-project-objectives)
4. [Technology Stack](#4-technology-stack)
5. [Project Features](#5-project-features)
6. [Project Structure](#6-project-structure)
7. [Database Design](#7-database-design)
8. [Database Objects and SQL Exercises](#8-database-objects-and-sql-exercises)
9. [Installation and Setup](#9-installation-and-setup)
10. [Running the Application](#10-running-the-application)
11. [Testing and Demonstration](#11-testing-and-demonstration)
12. [ER Diagram and Documentation](#12-er-diagram-and-documentation)
13. [Screenshots](#13-screenshots)
14. [Team Members and Contributions](#14-team-members-and-contributions)
15. [Demo Credentials](#15-demo-credentials)
16. [GitHub Repository](#16-github-repository)
17. [Live Deployment](#17-live-deployment)
18. [Deployment Evidence](#18-deployment-evidence)
19. [Security and Data Protection](#19-security-and-data-protection)
20. [Academic Information](#20-academic-information)

---

## 1. Project Overview

IBI Bank — International Bank of India — is a database-driven banking web application developed for the BTY39105 Database Management System Lab Project-Based Learning (PBL) at Brainware University.

The project demonstrates the integration of a web-based frontend, a Node.js and Express.js backend, and a MySQL relational database to support banking operations and digital transaction management.

The application provides modules for customer authentication, account information, beneficiary management, fund transfers, transaction history, loans, EMI operations, and administrative activities.

The project emphasizes relational database design, data integrity, SQL query development, database programming, transaction management, and the integration of a database with a web application.

## 2. Problem Statement

Banking applications need to maintain accurate and consistent information about customers, accounts, branches, beneficiaries, transactions, loans, and repayments. Managing these related records requires an organized relational database, appropriate validation, and reliable transaction processing.

This project demonstrates how a database-backed web application can organize banking-related information and operations through a structured MySQL database and a web interface connected to a Node.js and Express.js backend.

The system serves as an academic demonstration of database design, SQL operations, and web-based digital transaction management. It is not represented as a production banking service.

## 3. Project Objectives

The main objectives are:

- Maintain customer, user, account, branch, and account-type information.
- Implement authentication and email-based OTP verification.
- Manage beneficiary records.
- Support fund transfers and transaction-history tracking.
- Maintain account balances and related audit records.
- Support loan and EMI-related operations.
- Apply relational constraints and database validation.
- Demonstrate SQL queries, joins, aggregate functions, subqueries, and correlated subqueries.
- Implement and demonstrate views, stored procedures, stored functions, and triggers.
- Demonstrate transaction control and database consistency.
- Integrate frontend pages with backend APIs and a MySQL database.
- Maintain documentation, testing evidence, source code, and deployment records for the PBL submission.

## 4. Technology Stack

| Component | Technology |
|---|---|
| Frontend | HTML5, CSS3, JavaScript |
| Backend runtime | Node.js |
| Backend framework | Express.js |
| Database | MySQL |
| Database connectivity | mysql2 |
| Password hashing | bcrypt |
| Token-based authentication | JSON Web Token (JWT) |
| Email functionality | Nodemailer |
| Scheduled tasks | node-cron |
| Development environment | Visual Studio Code |
| Database tools | MySQL tools and/or MySQL Workbench |
| Source control | Git |
| Repository hosting | GitHub |
| Deployment | To be recorded after the live deployment is verified |

## 5. Project Features

### 5.1 Authentication and User Management

- Customer authentication.
- Email-based OTP workflows.
- Password reset functionality.
- Role-based administrative functionality, where implemented.

### 5.2 Account Management

- Customer and account information.
- Account-type and branch information.
- Account balance display.
- Transaction-related account information.

### 5.3 Beneficiary Management

- Beneficiary record management.
- Beneficiary selection for eligible fund transfers.
- Database-backed beneficiary information.

### 5.4 Fund Transfers

- Fund-transfer operations.
- Sender and receiver account validation.
- Transfer record maintenance.
- Related transaction-history entries.
- Database transaction handling.

### 5.5 Transaction History

- Transaction records.
- Transaction references and amounts.
- Account-related transaction information.
- Database-backed transaction history.

### 5.6 Loans and EMI

- Loan-related information.
- Loan administrative operations.
- EMI records and payment processing.
- Loan and EMI summary information.

### 5.7 Administrative Modules

- Administrative dashboard and related pages.
- User and banking-operation management features available in the current implementation.
- Administrative loan operations, where implemented.

### 5.8 Database Programming

- SQL queries and aggregate reports.
- Joins and subqueries.
- Views.
- Stored procedures.
- Stored functions.
- Triggers.
- Transaction management and audit-related operations.

Feature availability should be confirmed against the current implementation before the final demonstration.

## 6. Project Structure

The following illustrates the main project directories. Some supporting files are omitted for readability.

```text
BTY39105Group 7_Banking and Digital Transaction Management System/
│
├── Backend/
│   ├── server.js
│   ├── db.js
│   ├── Routes/
│   ├── middleware/
│   ├── package.json
│   └── .env                 # Local only; never commit
│
├── Fronted/
│   ├── ADMIN/
│   ├── images/
│   ├── index.html
│   ├── dashboard.html
│   ├── accounts.html
│   ├── beneficiaries.html
│   ├── transactions.html
│   ├── transfer.html
│   ├── loans.html
│   └── emi.html
│
├── Database/
│   ├── PBL_SQL/
│   └── PBL_Submission/
│       ├── Documentation/
│       ├── Exports/
│       ├── PDF_Documentation/
│       ├── Presentation/
│       └── Screenshots/
│
├── utils/
├── .gitignore
├── convert_docs_to_pdf.py
└── README.md
```

**Important:** `Fronted/` is the actual frontend directory name in this project. Use that exact spelling unless the source directory is deliberately renamed and all references are updated.

The local environment file and installed dependencies are not intended to be published to GitHub.

The final GitHub repository should also include the database and documentation directories required by the PBL guidelines. Their published paths should be verified after repository preparation.

## 7. Database Design

**Database name:** `fintech_banking_db`

The database is designed to manage the main entities and operations associated with the application.

### 7.1 Main Tables

The database includes tables for:

- `users`
- `customer`
- `account`
- `account_type`
- `branch`
- `beneficiary`
- `fund_transfer`
- `transaction`
- `loan`
- `loan_type`
- `emi_payment`
- `account_balance_audit`
- `email_verification_codes`

These tables maintain user, customer, account, transaction, beneficiary, loan, repayment, audit, and verification information.

### 7.2 Relationships and Integrity

The database uses relational keys and constraints to connect related records. Relevant database operations include validation of transaction amounts, tracking of account-balance changes, and the maintenance of related fund-transfer and transaction records.

The ER diagram and relational schema documentation should be consulted for the exact attributes, primary keys, foreign keys, and relationships.

### 7.3 Database Export

The project's complete database export is maintained in the local submission materials.

Expected source location:

`Database/PBL_Submission/Exports/ibi_bank_complete_backup.sql`

Verify that this file exists in the final repository before linking to it.

Before publishing a database export, inspect it for personal information, real customer records, password hashes, and other data that should not be made public. Use sanitized demonstration data for the public repository.

## 8. Database Objects and SQL Exercises

The database project includes SQL exercises and database programming objects.

### 8.1 SQL Exercise Files

The `Database/PBL_SQL/` directory contains these eight exercise files:

1. `01_basic_select_queries.sql`
2. `02_aggregate_group_by_queries.sql`
3. `03_join_queries.sql`
4. `04_subqueries.sql`
5. `05_correlated_subqueries.sql`
6. `06_dashboard_report_queries.sql`
7. `07_transaction_demo.sql`
8. `08_advanced_sql_inventory.sql`

These scripts cover basic SQL retrieval, aggregate functions, grouping, joins, subqueries, dashboard-style reports, transaction demonstrations, and database-object inspection.

### 8.2 Views

The database includes views for account details, fund-transfer details, loan/EMI summaries, and transaction history.

### 8.3 Stored Function

The project includes the stored function:

- `fn_calculate_monthly_interest`

### 8.4 Stored Procedures

The project includes the stored procedures:

- `sp_account_transaction_history`
- `sp_customer_account_summary`

### 8.5 Triggers

The project includes triggers for account-balance auditing and transaction-amount validation.

The exact definitions should be taken from the verified database schema and SQL export.

### 8.6 Required GitHub SQL Files

The PBL repository policy requests separate files for the main database components. The final repository should contain verified scripts corresponding to:

```text
database/
├── schema.sql
├── insert_data.sql
├── queries.sql
├── views.sql
├── triggers.sql
└── procedures.sql
```

These are the required publication paths, not a claim that all six files already exist. Create them from the actual schema and existing SQL materials, and validate the scripts before publishing. Do not invent schema definitions or include unreviewed production data.

## 9. Installation and Setup

### 9.1 Prerequisites

Install the following software:

- Node.js and npm.
- MySQL Server.
- Visual Studio Code or another suitable code editor.
- A local web server for serving the frontend.
- Git, if working with the repository from the command line.

### 9.2 Obtain the Project

Clone the GitHub repository after its URL has been created:

```powershell
git clone <GITHUB_REPOSITORY_URL>
```

Replace the placeholder with the actual repository URL.

Alternatively, open the downloaded project folder in Visual Studio Code.

### 9.3 Configure the Database

1. Start MySQL Server.
2. Create or restore the `fintech_banking_db` database using the verified database scripts.
3. Apply the required schema, data, views, triggers, stored procedures, and stored function.
4. Verify that the tables and relationships are created successfully.
5. Use only authorized sample data for demonstrations.

If restoring a complete SQL backup, confirm that it is appropriate for the target database and that it contains no information that should not be published or shared.

### 9.4 Configure Environment Variables

The backend reads its environment configuration from `Backend/.env`.

Create this local file using the variable names expected by the existing backend source code. Configure the required database connection values, authentication secrets, and email settings as applicable.

Do not copy real credentials into this README or commit the environment file to GitHub.

### 9.5 Install Backend Dependencies

Open a terminal in the project root and run:

```powershell
cd Backend
npm install
```

This installs the dependencies defined by `Backend/package.json`.

## 10. Running the Application

### 10.1 Start the Backend

From the `Backend/` directory, run:

```powershell
node server.js
```

The local API base URL used by the project is:

`http://127.0.0.1:5000`

The root API endpoint is expected to return:

`Banking and Digital Transaction Management System API is running!`

The backend requires a working MySQL connection and correctly configured environment variables.

### 10.2 Start the Frontend

Serve the `Fronted/` directory through a local web server.

Open the relevant customer or administrative HTML page using the address provided by that web server.

Ensure that the frontend API configuration points to the correct backend address for the current environment.

For local testing, the API address may use `http://127.0.0.1:5000`. A deployed application must use its deployed backend URL and appropriate production configuration.

### 10.3 Verify Connectivity

Before demonstrating the application, confirm that:

- The backend starts without configuration errors.
- The database connection succeeds.
- The frontend loads correctly.
- API requests reach the backend.
- The relevant application operations work against the intended database.

Local testing does not establish that the deployed application is working.

## 11. Testing and Demonstration

The following test categories are suitable for the final demonstration.

| Test category | What to verify |
|---|---|
| Authentication | Valid and invalid login behavior |
| OTP | Verification and invalid/expired-code behavior, as applicable |
| Accounts | Database-backed account information |
| Beneficiaries | Creation, retrieval, or other supported beneficiary operations |
| Fund transfers | Transfer validation, balance changes, and related records |
| Transaction history | Correct display of stored transaction records |
| Loans | Supported loan operations and administrative actions |
| EMI | EMI records and supported payment processing |
| SQL queries | Query results, joins, aggregates, and subqueries |
| Database objects | Views, functions, procedures, and triggers |
| Transaction handling | Appropriate commit, rollback, and integrity behavior |
| Deployment | A real operation against the deployed application's database |

Record the actual result of each test. Mark a test as passed only when it has been executed and verified.

Capture screenshots of meaningful test results for the final PBL submission.

## 12. ER Diagram and Documentation

The PBL submission includes supporting database and project documentation under `Database/PBL_Submission/`.

The final GitHub repository should organize and publish the relevant documentation in a clear structure, for example:

```text
docs/
├── ER_Diagram/
├── Relational_Schema/
├── Normalization/
└── Data_Dictionary/
```

Place the actual, verified documents in these directories. Use descriptive filenames and update the links in this README to match the published files.

The documentation should explain the database entities, attributes, relationships, keys, constraints, and relevant normalization decisions.

## 13. Screenshots

The repository should contain screenshots of the actual application and its database operations.

Recommended screenshot categories include:

- Customer login and dashboard.
- Account information.
- Beneficiary management.
- Fund-transfer workflow and result.
- Transaction history.
- Loan and EMI pages.
- Administrative dashboard.
- SQL query output or database-object demonstration.
- Live deployed application.
- A successful database-backed operation performed through the deployed application.

Store screenshots in:

`screenshots/`

Use descriptive filenames, such as `customer-dashboard.png` or `deployed-transfer-test.png`, only when those screenshots actually exist and show the corresponding results.

Screenshots should not expose passwords, OTPs, tokens, database credentials, or unnecessary personal information.

## 14. Team Members and Contributions

Replace the placeholders below with the verified names, roll numbers, and actual contributions of every group member.

| Team member | Roll number | Individual contribution |
|---|---|---|
| `[Member 1 name]` | `[Roll number]` | `[Actual contribution]` |
| `[Member 2 name]` | `[Roll number]` | `[Actual contribution]` |
| `[Member 3 name]` | `[Roll number]` | `[Actual contribution]` |
| `[Add remaining members]` | `[Roll number]` | `[Actual contribution]` |

Each member should be able to explain their contribution and understand the main database design, SQL exercises, application workflow, and testing process.

Do not assign work to a member unless that contribution is accurate.

## 15. Demo Credentials

Demonstration credentials must be prepared specifically for the project evaluator and must be authorized for use.

| Role | Account | Credential handling |
|---|---|---|
| Customer | `[Demo customer account]` | Share the password privately with the evaluator |
| Admin | `[Authorized demo admin account]` | Share securely with the evaluator, if required |

Do not publish real customer passwords, administrator passwords, OTPs, JWTs, or other authentication secrets in a public repository.

If credentials are required by the PBL evaluator, provide them through an approved private channel and document the demonstration procedure here without exposing the secrets.

## 16. GitHub Repository

**Repository name:** `Group07_Banking_and_Digital_Transaction_Management_System`

This is the proposed name and should be updated if the actual GitHub repository uses a different name.

- **GitHub repository URL:** `[Add actual repository URL]`
- **Default branch:** `[Record actual branch]`
- **Latest deployment commit:** `[Record verified commit hash]`

The repository should contain the source code, reviewed database scripts, project documentation, screenshots, README, and deployment notes required by the PBL policy.

Git history should reflect genuine development and team participation. Team members should use meaningful commits for their actual contributions. Do not fabricate earlier commits or falsely attribute work.

### Required Repository Contents

The final repository should include the following paths, adapted to the actual verified files:

```text
README.md
database/
├── schema.sql
├── insert_data.sql
├── queries.sql
├── views.sql
├── triggers.sql
└── procedures.sql
src/
├── frontend/
└── backend/
docs/
├── ER_Diagram/
├── Relational_Schema/
├── Normalization/
└── Data_Dictionary/
screenshots/
deployment/
└── deployment_details.md
```

The published frontend and backend directories may be reorganized from the original local layout as part of repository preparation. Preserve the working code and update relative paths or configuration only when necessary and tested.

## 17. Live Deployment

**Live website URL:** `[Add actual verified HTTPS URL]`

**Frontend hosting platform:** `[Add actual platform]`

**Backend hosting platform:** `[Add actual platform]`

**Database hosting platform:** `[Add actual platform]`

**Deployment status:** Pending verification until the application is tested at the live URL.

A successful local run is not a live deployment. GitHub Pages can host static frontend files but cannot, by itself, execute the Node.js backend or host a MySQL database.

The deployed application needs an appropriate frontend host, backend host, and accessible database configuration. The production backend must use the deployed database and must not depend on the developer's local `127.0.0.1` address.

After deployment, verify that:

1. The live website loads.
2. The frontend can reach the deployed backend.
3. The backend connects to the deployed database.
4. Authentication and the required application modules work.
5. A supported database-backed operation completes successfully.
6. The operation is visible in the relevant deployed database records.
7. The live URL and test evidence are recorded in the project documentation.

Do not enter a URL in this section until it has been deployed and verified.

## 18. Deployment Evidence

The file `deployment/deployment_details.md` should record the deployment evidence required by the PBL policy.

It should contain:

- Live deployed application URL.
- GitHub repository URL.
- Hosting platforms and relevant deployment configuration.
- Date of deployment verification.
- Latest commit hash deployed.
- Commit date.
- Screenshot of the deployed application.
- Description of a database operation performed through the deployed version.
- Actual result of the database operation.
- Relevant sanitized evidence, such as a database record or query result.
- Demonstration instructions and approved demo credential-sharing procedure.
- Any known limitations or configuration notes.

Use actual deployment records and test results. Do not record a database operation as successful based only on a local test.

## 19. Security and Data Protection

The project should be published and demonstrated responsibly.

- Never commit `Backend/.env`.
- Exclude `node_modules/` and unnecessary local dependency directories.
- Never publish database passwords, JWT secrets, SMTP credentials, or other environment secrets.
- Inspect SQL exports before publication.
- Use sanitized sample data in public demonstrations.
- Do not publish real user passwords, OTPs, session tokens, or unnecessary personal information.
- Keep demonstration accounts separate from real accounts.
- Configure production credentials through the deployment platform's secure environment settings.
- Restrict database access to the necessary application services.
- Do not expose a production database to unrestricted public access.
- Verify that published screenshots and documentation do not disclose sensitive information.

A public GitHub repository is not a secure place to store application secrets or real customer information.

## 20. Academic Information

- **Project title:** IBI Bank — Banking and Digital Transaction Management System
- **Course code:** BTY39105
- **Course:** Database Management System Lab
- **Institution:** Brainware University
- **Group number:** 7
- **Project category:** Project-Based Learning (PBL)

The final submission should include the completed report, presentation, database scripts, ER diagram, relational schema, normalization and data-dictionary documentation, testing evidence, individual contribution details, GitHub repository URL, and verified live deployment evidence, in accordance with the university's PBL requirements.

---

**Final note:** This README describes the project's intended architecture and submission requirements. Repository contents, individual contributions, test outcomes, demo accounts, and deployment details must be updated to reflect the actual verified project state.
