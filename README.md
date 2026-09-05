# Service Request Management System

## Project Overview

A Service Request Management System developed using Python and MySQL to manage, track, and analyze service requests.

The system allows users to add, view, search, update, and track service requests through a Python application connected to a relational MySQL database.

## Technologies Used

- Python
- MySQL
- MySQL Workbench
- SQL

## Key Features

- Add new service requests
- View all service requests
- Search service requests
- Update request details
- Update request status
- View pending requests
- View resolved requests
- SQL-based reporting
- Database testing and validation

## Database Structure

The MySQL database contains the following tables:

- departments
- users
- categories
- priorities
- statuses
- employees
- service_requests

The database uses primary keys and foreign keys to maintain relationships between tables.

## Database Testing

The database was validated using SQL testing queries:

- DT1 — Table Existence Check
- DT2 — Table Structure Check
- DT3 — Data Completeness Check
- DT4 — Duplicate Request ID Check
- DT5 — Invalid Foreign Key Check
- DT6 — Date Consistency Check
- DT7 — Empty Important Fields Check
- DT8 — Final Record Count Verification

## SQL Reports

The project includes the following SQL reports:

- R1 — Requests by Category
- R2 — Requests by Status
- R3 — Requests by Priority
- R4 — Requests by Department
- R5 — Employee-wise Assigned Requests
- R6 — Pending Requests
- R7 — Resolved Requests
- R8 — Monthly Service Request Trend

## Project Files

- `database_connection.py` — MySQL database connection
- `generate_users.py` — Generates user data
- `generate_requests.py` — Generates service request data
- `service_request_system.py` — Main Python application
- `service_request_database.sql` — Database, testing, and reporting SQL queries

## How to Run

1. Create the MySQL database using `service_request_database.sql`.
2. Update the MySQL connection details in `database_connection.py`.
3. Make sure MySQL Server is running.
4. Run `service_request_system.py`.
5. Use the menu to manage service requests.

## Project Outcome

This project demonstrates practical knowledge of Python, MySQL, SQL queries, relational database management, database testing, data validation, and SQL reporting.