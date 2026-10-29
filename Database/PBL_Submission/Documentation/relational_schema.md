# IBI Bank — Relational Schema

Database name: fintech_banking_db

This document summarizes the logical relational structure. Confirm exact column types, primary keys, foreign keys, and constraints using the final MySQL schema export.

## Core relations

1. CUSTOMER(customer_id, name, email, phone, address, status)
2. USERS(user_id, name, email, phone, password, role, email_verified_at, token_version, is_active)
3. BRANCH(branch_id, branch_name, IFSC, city)
4. ACCOUNT_TYPE(account_type_id, type_name, interest_rate, minimum_balance)
5. ACCOUNT(account_id, customer_id, branch_id, account_type_id, account_number, balance, status)
6. TRANSACTION(transaction_id, account_id, transaction_type, amount, transaction_date, description)
7. BENEFICIARY(beneficiary_id, account_id, account_type_id, beneficiary_name, beneficiary_account_no, bank_name, IFSC, status, deleted_at)
8. FUND_TRANSFER(transfer_id, sender_account_id, receiver_account_id, beneficiary_id, amount, transfer_date, status, reference_no)
9. LOAN_TYPE(loan_type_id, loan_type, interest_rate)
10. LOAN(loan_id, customer_id, loan_type, principal_amount, interest_rate, tenure_months, status)
11. EMI_PAYMENT(emi_id, loan_id, due_date, amount, payment_date, status, late_fee)
12. ACCOUNT_BALANCE_AUDIT — inspect actual schema for complete attributes.
13. EMAIL_VERIFICATION_CODES — inspect actual schema for complete attributes.

## Key relationships

- ACCOUNT.customer_id relates to CUSTOMER.customer_id.
- ACCOUNT.branch_id relates to BRANCH.branch_id.
- ACCOUNT.account_type_id relates to ACCOUNT_TYPE.account_type_id.
- TRANSACTION.account_id relates to ACCOUNT.account_id.
- FUND_TRANSFER.sender_account_id and receiver_account_id refer to account records.
- FUND_TRANSFER.beneficiary_id may reference BENEFICIARY.beneficiary_id.
- LOAN.customer_id relates to CUSTOMER.customer_id.
- EMI_PAYMENT.loan_id relates to LOAN.loan_id.
- BENEFICIARY.account_id associates a saved beneficiary with an account.

The relationships above describe the intended logical model. Only label a relationship as a declared foreign key if the exported MySQL schema confirms that constraint.
