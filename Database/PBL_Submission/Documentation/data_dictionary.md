# IBI Bank — Data Dictionary

Database: fintech_banking_db

This data dictionary describes the main tables used by the Banking and Digital Transaction Management System. Confirm exact SQL data types and declared constraints against the database schema export before final submission.

## 1. customer
Purpose: Stores customer profile and contact information.
- customer_id — Primary identifier for a customer.
- name — Customer name.
- email — Customer email address.
- phone — Customer phone number.
- address — Customer address.
- status — Customer account/status indicator.

## 2. users
Purpose: Stores login identities, authentication details, and role information.
- user_id — Primary identifier for a login user.
- name — Name associated with the login.
- email — Login email address.
- phone — Phone number.
- password — Stored password hash or legacy password value, depending on account migration state.
- role — User role used for access control.
- email_verified_at — Email verification timestamp.
- token_version — Version value used for session/token invalidation.
- is_active — Indicates whether the login is active.

Security note: Never include real password values, OTP values, JWT secrets, SMTP credentials, or environment files in the report or public repository.

## 3. account
Purpose: Stores customer bank accounts and their current balances.
- account_id — Primary identifier for a bank account.
- customer_id — Customer associated with the account.
- branch_id — Branch associated with the account.
- account_type_id — Account category.
- account_number — Account number.
- balance — Current account balance.
- status — Account status.

## 4. account_type
Purpose: Maintains account categories and their banking rules.
- account_type_id — Primary identifier for the account type.
- type_name — Account type name.
- interest_rate — Interest rate associated with the type.
- minimum_balance — Minimum balance requirement.

## 5. branch
Purpose: Stores bank branch information.
- branch_id — Primary identifier for the branch.
- branch_name — Branch name.
- IFSC — Branch IFSC code.
- city — Branch city.

## 6. transaction
Purpose: Records individual account transactions.
- transaction_id — Primary identifier for a transaction.
- account_id — Account associated with the transaction.
- transaction_type — Type of transaction, such as deposit, withdrawal, transfer, or EMI.
- amount — Transaction amount.
- transaction_date — Date and time of the transaction.
- description — Additional transaction details.

## 7. beneficiary
Purpose: Stores beneficiary details saved for transfers.
- beneficiary_id — Primary identifier for a beneficiary record.
- account_id — Account associated with the customer who saved the beneficiary.
- account_type_id — Associated account type, where used.
- beneficiary_name — Beneficiary name.
- beneficiary_account_no — Beneficiary account number.
- bank_name — Beneficiary bank name.
- IFSC — Beneficiary bank/branch code.
- status — Beneficiary status.
- deleted_at — Soft-deletion timestamp, when applicable.

## 8. fund_transfer
Purpose: Records money transfers between accounts.
- transfer_id — Primary identifier for a transfer.
- sender_account_id — Sending account identifier.
- receiver_account_id — Receiving account identifier.
- beneficiary_id — Saved beneficiary record associated with the transfer, when applicable.
- amount — Transfer amount.
- transfer_date — Transfer date and time.
- status — Transfer status.
- reference_no — Transfer reference number.

## 9. loan_type
Purpose: Stores loan categories and their standard interest rates.
- loan_type_id — Primary identifier for the loan type.
- loan_type — Loan category name.
- interest_rate — Standard interest rate.

## 10. loan
Purpose: Stores loan applications and loan account details.
- loan_id — Primary identifier for a loan.
- customer_id — Customer associated with the loan.
- loan_type — Loan category recorded for the loan.
- principal_amount — Original loan principal.
- interest_rate — Applied interest rate.
- tenure_months — Loan tenure in months.
- status — Loan status.

## 11. emi_payment
Purpose: Stores scheduled and recorded EMI payments.
- emi_id — Primary identifier for an EMI record.
- loan_id — Loan associated with the EMI.
- due_date — Scheduled payment date.
- amount — EMI amount.
- payment_date — Actual payment date, when paid.
- status — EMI payment status.
- late_fee — Late fee amount, where applicable.

## 12. account_balance_audit
Purpose: Maintains audit information about account balance updates.
- Inspect the actual table definition to document every audit column, its data type, and whether it records old/new balances, timestamps, or other metadata.

## 13. email_verification_codes
Purpose: Supports email verification and OTP-related authentication workflows.
- Inspect the actual table definition to document every column, including code hash, expiry, attempts, purpose, and consumption timestamp where present.

## Relationships to document from the actual schema
- customer to account: a customer can be associated with bank accounts.
- branch to account: a branch can be associated with accounts.
- account_type to account: an account type can classify accounts.
- account to transaction: an account can have many transactions.
- account to fund_transfer: an account may act as sender or receiver in transfers.
- customer to loan: a customer can have loan records.
- loan to emi_payment: a loan can have multiple EMI records.
- beneficiary: a customer/account can save beneficiary details.
- users and customer: authentication identity and customer profile are related by the application's account-registration/login design; verify the actual database relationship before claiming a declared foreign key.

Important: A column name suggesting a relationship does not by itself prove that a FOREIGN KEY constraint exists. Use the exported schema to confirm declared primary keys, foreign keys, unique constraints, and exact data types.
