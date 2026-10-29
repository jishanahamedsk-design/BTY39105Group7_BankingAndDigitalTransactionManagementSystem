# IBI Bank — Software Testing Report

## 1. Project Information

- Project title: Banking and Digital Transaction Management System
- System name: IBI Bank — International Bank of India
- Course / subject code: BTY39105
- Database: fintech_banking_db
- Backend: Node.js and Express
- Database: MySQL
- Testing basis: Application checks reported by the project team
- Test date: 29 October 2026
- Tested by: Project team — add actual member names before submission

## 2. Testing Objectives

1. Check customer and administrator authentication workflows.
2. Review account, beneficiary, transfer, loan, and EMI functionality.
3. Check transaction validation and database integrity.
4. Review reporting and database objects.
5. Document test outcomes without claiming unperformed tests passed.

## 3. Test Cases and Recorded Status

The statuses below reflect the team's reported application checks. They are not a claim that every individual edge case or database object was independently retested for this report.

| ID | Test case | Recorded result |
|---|---|---|
| TC-01 | Start backend and connect to MySQL | Passed — startup and database connection were reported successful |
| TC-02 | Customer login, OTP verification, and dashboard | Passed — reported working by the project team |
| TC-03 | Invalid customer credentials | Not separately evidenced in this report |
| TC-04 | Customer signup and verification | Not separately evidenced in this report |
| TC-05 | Customer attempting an administrator-only operation | Not separately evidenced in this report |
| TC-06 | View customer accounts | Application functionality reported working; retain screenshot evidence |
| TC-07 | Submit a valid transfer | Passed — transfer functionality reported working |
| TC-08 | Transfer with invalid amount | Not separately evidenced in this report |
| TC-09 | View transaction history | Application functionality reported working; retain screenshot evidence |
| TC-10 | Manage beneficiaries | Passed — beneficiary functionality reported working |
| TC-11 | Apply for a loan | Passed — loan functionality reported working |
| TC-12 | View EMI information | Passed — EMI functionality reported working |
| TC-13 | Execute aggregate and GROUP BY queries | Requires recorded SQL output |
| TC-14 | Execute stored procedures and function | Requires recorded SQL output |
| TC-15 | Verify trigger behavior | Trigger definitions exist in the database export; behavioral test evidence must be recorded |
| TC-16 | Verify transaction rollback | Requires recorded execution evidence |

## 4. Database Testing

The SQL exercise collection is located in `Database/PBL_SQL` and includes:

- Basic SELECT statements
- Aggregate functions and GROUP BY
- JOIN queries
- Subqueries and correlated subqueries
- Dashboard and reporting queries
- Transaction-control demonstration
- Database-object inventory

Record actual query output and screenshots for the final submission. The inventory script inspects database objects; it does not recreate them.

## 5. Security and Validation Review

The following areas should be checked and evidenced where required by the course:

- Password handling and email OTP verification
- Customer and administrator role restrictions
- Validation of transfer amounts and account details
- Protection of credentials in environment variables
- Safe error messages and protected backend routes
- Exclusion of passwords, OTPs, tokens, and private customer information from submission materials

Do not mark a security check as passed solely because the related feature exists.

## 6. Defect Log

No consolidated, evidence-backed defect count has been established in this report. Add each defect actually observed, its severity, resolution, and current status. Do not claim zero defects unless the team has verified that conclusion.

## 7. Test Summary

- Application workflows reported working: backend startup/database connection, customer login and OTP/dashboard, transfers, beneficiaries, loans, and EMI.
- Remaining evidence: individual edge-case results, SQL output, stored routine/function results, trigger behavior, and rollback demonstration.
- Failed tests: record any actual failures.
- Blocked/not executed: record tests that were not performed.
- Outstanding defects: record actual unresolved defects.

## 8. Conclusion

The project team reports that the principal banking workflows are functioning. The final assessment should be supported by the submitted application screenshots, actual SQL execution output, and recorded test outcomes. Tests without evidence remain unverified and should not be represented as passed.
