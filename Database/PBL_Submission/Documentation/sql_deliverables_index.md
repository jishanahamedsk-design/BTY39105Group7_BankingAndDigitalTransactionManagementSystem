# IBI Bank — SQL Deliverables Index

Database: fintech_banking_db

## Query files

| File | Purpose |
|---|---|
| 01_basic_select_queries.sql | Basic SELECT statements |
| 02_aggregate_group_by_queries.sql | Aggregate functions and GROUP BY |
| 03_join_queries.sql | JOIN examples |
| 04_subqueries.sql | Subquery examples |
| 05_correlated_subqueries.sql | Correlated subquery examples |
| 06_dashboard_report_queries.sql | Banking dashboard and summary reports |
| 07_transaction_demo.sql | Transaction control demonstration |
| 08_advanced_sql_inventory.sql | Inventory of database objects and indexes |

## Existing database objects to include in the final evidence

### Views
- vw_account_details
- vw_fund_transfer_details
- vw_loan_emi_summary
- vw_transaction_history

### Stored procedures
- sp_account_transaction_history
- sp_customer_account_summary

### Function
- fn_calculate_monthly_interest

### Triggers
- trg_account_balance_audit
- trg_validate_transaction_amount

## Finalization notes
- Keep the SQL source files together in Database/PBL_SQL.
- Include the actual CREATE VIEW, CREATE PROCEDURE, CREATE FUNCTION, CREATE TRIGGER, and index definitions in the final database export or a separate schema-objects script.
- Ensure the submitted definitions match the database being demonstrated.
- Do not assume the inventory script recreates these objects; it is intended to inspect them.
- Do not include credentials, tokens, real OTPs, or production customer information in public submission files.
- Record actual query outputs and test results in the report.
