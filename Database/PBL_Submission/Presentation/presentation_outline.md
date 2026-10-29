# IBI Bank — PBL Presentation Outline

Suggested presentation: 10–12 slides

## Slide 1 — Title
- Banking and Digital Transaction Management System
- IBI Bank — International Bank of India
- Course / subject code: BTY39105
- Team name and member names
- Faculty guide and institution

## Slide 2 — Problem Statement
- Banking operations involve related customer, account, transaction, beneficiary, and loan information.
- Reliable storage and retrieval are essential for consistency and reporting.
- The project demonstrates a database-backed banking management application.

## Slide 3 — Objectives
- Maintain related banking records in MySQL.
- Support authenticated customer and administrator workflows.
- Record transfers and transactions.
- Manage loans and EMI payment information.
- Demonstrate SQL queries and advanced database objects.

## Slide 4 — Technology Stack
- Front end: HTML, CSS, JavaScript
- Backend: Node.js and Express
- Database: MySQL
- Authentication and verification: describe the mechanisms actually implemented
- Development tools: list the tools actually used by the team

## Slide 5 — System Architecture
Show the flow:
Customer/Admin → Web Interface → Express API → MySQL Database → Results returned to the interface.

Mention that backend authorization and validation should protect sensitive operations.

## Slide 6 — ER Diagram
Insert the final ER diagram from Documentation/er_diagram.mmd after rendering it.
Explain major entities and relationships: Customer, Account, Branch, Account Type, Transaction, Fund Transfer, Beneficiary, Loan, and EMI Payment.

## Slide 7 — Database Design and Normalization
- Explain primary keys and declared foreign keys.
- Summarize 1NF, 2NF, and 3NF.
- Explain why customer, account, transaction, loan, and EMI data are stored separately.
- Use the final schema to support claims about constraints and relationships.

## Slide 8 — SQL Implementation
Demonstrate examples from:
- Basic SELECT queries
- Aggregate functions and GROUP BY
- JOIN queries
- Subqueries and correlated subqueries
- Views, indexes, stored procedures, function, and triggers
- Transaction control using COMMIT and ROLLBACK

## Slide 9 — Application Features
Use screenshots of implemented pages:
- Login and email verification
- Customer/account management
- Beneficiary and transfer management
- Loan and EMI management
- Transaction history and reports

Only include features that are present and working in the submitted version.

## Slide 10 — Testing and Results
- Show the testing report and actual outcomes.
- Include screenshots or output evidence.
- Explain any issues found and how they were resolved.
- Do not report unperformed tests as successful.

## Slide 11 — Limitations and Future Enhancements
Choose realistic enhancements, such as:
- Improved audit and monitoring reports
- More automated integration tests
- Additional reporting filters
- Deployment and backup improvements
Include only limitations that apply to the current implementation.

## Slide 12 — Conclusion and Contributions
- Summarize the database and application objectives achieved.
- State each team member's actual contribution.
- Include repository and live-demo URLs only if they exist and are accessible.
- Finish with questions.

## Presentation preparation checklist
- Replace every placeholder with accurate project information.
- Add screenshots from the real application.
- Insert the final ER diagram.
- Include representative SQL examples and outputs.
- Verify that the presentation and report agree with the final database schema.
