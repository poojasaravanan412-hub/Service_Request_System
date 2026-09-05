-- CREATE DATABASE service_request_db;
-- use service_request_db;
-- SHOW DATABASES;

-- CREATE TABLE departments (
--     department_id INT PRIMARY KEY,
--     department_name VARCHAR(100) NOT NULL
-- );

-- CREATE TABLE users (
--     user_id INT PRIMARY KEY,
--     user_name VARCHAR(100) NOT NULL,
--     email VARCHAR(100),
--     phone VARCHAR(15),
--     department_id INT,
--     FOREIGN KEY (department_id)
--         REFERENCES departments(department_id)
-- );

-- CREATE TABLE categories (
--     category_id INT PRIMARY KEY,
--     category_name VARCHAR(100) NOT NULL
-- );


-- CREATE TABLE priorities (
--     priority_id INT PRIMARY KEY,
--     priority_name VARCHAR(30) NOT NULL
-- );

-- CREATE TABLE statuses (
--     status_id INT PRIMARY KEY,
--     status_name VARCHAR(50) NOT NULL
-- );

-- CREATE TABLE employees (
--     employee_id INT PRIMARY KEY,
--     employee_name VARCHAR(100) NOT NULL,
--     department_id INT,
--     email VARCHAR(100),
--     FOREIGN KEY (department_id)
--         REFERENCES departments(department_id)
-- );

-- CREATE TABLE service_requests (
--     request_id INT PRIMARY KEY,
--     user_id INT NOT NULL,
--     category_id INT NOT NULL,
--     priority_id INT NOT NULL,
--     status_id INT NOT NULL,
--     employee_id INT,
--     request_date DATE NOT NULL,
--     subject VARCHAR(200) NOT NULL,
--     description VARCHAR(500),
--     resolution VARCHAR(500),
--     resolved_date DATE,

--     FOREIGN KEY (user_id)
--         REFERENCES users(user_id),

--     FOREIGN KEY (category_id)
--         REFERENCES categories(category_id),

--     FOREIGN KEY (priority_id)
--         REFERENCES priorities(priority_id),

--     FOREIGN KEY (status_id)
--         REFERENCES statuses(status_id),

--     FOREIGN KEY (employee_id)
--         REFERENCES employees(employee_id)
-- );

-- USE service_request_db;

-- INSERT INTO departments (department_id, department_name)
-- VALUES
-- (1, 'IT'),
-- (2, 'HR'),
-- (3, 'Finance'),
-- (4, 'Sales'),
-- (5, 'Operations'),
-- (6, 'Marketing'),
-- (7, 'Administration');

-- INSERT INTO categories (category_id, category_name)
-- VALUES
-- (1, 'Hardware'),
-- (2, 'Software'),
-- (3, 'Network'),
-- (4, 'Email'),
-- (5, 'Access'),
-- (6, 'Account'),
-- (7, 'Printer'),
-- (8, 'Other');

-- USE service_request_db;

-- INSERT INTO priorities (priority_id, priority_name)
-- VALUES
-- (1, 'Low'),
-- (2, 'Medium'),
-- (3, 'High'),
-- (4, 'Critical');

-- USE service_request_db;

-- INSERT INTO statuses (status_id, status_name)
-- VALUES
-- (1, 'Open'),
-- (2, 'In Progress'),
-- (3, 'Pending'),
-- (4, 'Resolved'),
-- (5, 'Closed');

-- SELECT * FROM statuses;

-- USE service_request_db;

-- INSERT INTO employees (employee_id, employee_name, department_id, email)
-- VALUES
-- (1, 'Arun Kumar', 1, 'arun@company.com'),
-- (2, 'Priya Sharma', 1, 'priya@company.com'),
-- (3, 'Rahul Raj', 1, 'rahul@company.com'),
-- (4, 'Divya S', 2, 'divya@company.com'),
-- (5, 'Karthik M', 2, 'karthik@company.com'),
-- (6, 'Vijay Kumar', 3, 'vijay@company.com'),
-- (7, 'Anitha R', 3, 'anitha@company.com'),
-- (8, 'Suresh B', 4, 'suresh@company.com'),
-- (9, 'Meena P', 4, 'meena@company.com'),
-- (10, 'Ravi Kumar', 5, 'ravi@company.com'),
-- (11, 'Deepa S', 5, 'deepa@company.com'),
-- (12, 'Naveen R', 6, 'naveen@company.com'),
-- (13, 'Kavya M', 6, 'kavya@company.com'),
-- (14, 'Manoj K', 7, 'manoj@company.com'),
-- (15, 'Lakshmi P', 7, 'lakshmi@company.com');

-- SELECT * FROM employees;

-- USE service_request_db;

-- SELECT COUNT(*) AS departments FROM departments;
-- SELECT COUNT(*) AS categories FROM categories;
-- SELECT COUNT(*) AS priorities FROM priorities;
-- SELECT COUNT(*) AS statuses FROM statuses;
-- SELECT COUNT(*) AS employees FROM employees;

-- USE service_request_db;

-- SELECT COUNT(*) AS total_users
-- FROM users;

-- USE service_request_db;

-- SELECT * FROM users;

-- SELECT 
--     u.user_id,
--     u.user_name,
--     u.email,
--     u.phone,
--     d.department_name
-- FROM users u
-- JOIN departments d
--     ON u.department_id = d.department_id;
-- USE service_request_db;

-- SELECT COUNT(*) AS total_requests
-- FROM service_requests;

-- SELECT * FROM service_requests;

-- SHOW DATABASES;
-- USE service_request_db;


-- 					-- DATA TESTING----
-- -- DT 1 — Table Existence Check

-- SHOW TABLES;

-- --DT 2  Table Structure Check

-- DESCRIBE service_requests;

-- DT 3. Data Completeness / Missing Foreign Key Check

-- SELECT
--     COUNT(*) AS total_requests,
--     COUNT(user_id) AS requests_with_user,
--     COUNT(category_id) AS requests_with_category,
--     COUNT(priority_id) AS requests_with_priority,
--     COUNT(status_id) AS requests_with_status
-- FROM service_requests;

-- DT 4 — Duplicate Request ID Check

-- SELECT request_id, COUNT(*) AS duplicate_count
-- FROM service_requests
-- GROUP BY request_id
-- HAVING COUNT(*) > 1;

-- DT 5 — Invalid Foreign Key Check
            -- 1 User ID

-- SELECT sr.user_id
-- FROM service_requests sr
-- LEFT JOIN users u
--     ON sr.user_id = u.user_id
-- WHERE u.user_id IS NULL;

		-- 2 Category ID
        
-- SELECT sr.category_id
-- FROM service_requests sr
-- LEFT JOIN categories c
--     ON sr.category_id = c.category_id
-- WHERE c.category_id IS NULL;

	  -- 3  Priority ID
      
-- SELECT sr.priority_id
-- FROM service_requests sr
-- LEFT JOIN priorities p
--     ON sr.priority_id = p.priority_id
-- WHERE p.priority_id IS NULL;

	-- 4 Status ID
    
-- SELECT sr.status_id
-- FROM service_requests sr
-- LEFT JOIN statuses s
--     ON sr.status_id = s.status_id
-- WHERE s.status_id IS NULL;

           -- DT 6 — Date Consistency Check
           
-- SELECT *
-- FROM service_requests
-- WHERE resolved_date IS NOT NULL
--   AND resolved_date < request_date;

-- DT 7 — Empty Important Fields Check

-- SELECT request_id, subject
-- FROM service_requests
-- WHERE subject IS NULL
--    OR TRIM(subject) = '';
   
   
-- DT 8 Final Database Testing Confirmation

-- SELECT COUNT(*) AS total_requests
-- FROM service_requests;




-- R1 — Requests by Category

-- SELECT
--     c.category_name,
--     COUNT(*) AS total_requests
-- FROM service_requests sr
-- JOIN categories c
--     ON sr.category_id = c.category_id
-- GROUP BY c.category_name
-- ORDER BY total_requests DESC;


-- R2 — Requests by Status

-- SELECT
--     s.status_name,
--     COUNT(*) AS total_requests
-- FROM service_requests sr
-- JOIN statuses s
--     ON sr.status_id = s.status_id
-- GROUP BY s.status_name
-- ORDER BY total_requests DESC;

-- R3 — Requests by Priority

-- SELECT
--     p.priority_name,
--     COUNT(*) AS total_requests
-- FROM service_requests sr
-- JOIN priorities p
--     ON sr.priority_id = p.priority_id
-- GROUP BY p.priority_name
-- ORDER BY total_requests DESC;

-- R4 — Requests by Department

-- SELECT
--     d.department_name,
--     COUNT(*) AS total_requests
-- FROM service_requests sr
-- JOIN users u
--     ON sr.user_id = u.user_id
-- JOIN departments d
--     ON u.department_id = d.department_id
-- GROUP BY d.department_name
-- ORDER BY total_requests DESC;

-- R5 — Employee-wise Assigned Requests

-- SELECT
--     e.employee_id,
--     e.employee_name,
--     COUNT(sr.request_id) AS total_requests
-- FROM employees e
-- LEFT JOIN service_requests sr
--     ON e.employee_id = sr.employee_id
-- GROUP BY e.employee_id, e.employee_name
-- ORDER BY total_requests DESC;

-- R6 — Pending Requests

-- SELECT
--     sr.request_id,
--     u.user_name,
--     c.category_name,
--     p.priority_name,
--     sr.subject,
--     sr.request_date
-- FROM service_requests sr
-- JOIN users u
--     ON sr.user_id = u.user_id
-- JOIN categories c
--     ON sr.category_id = c.category_id
-- JOIN priorities p
--     ON sr.priority_id = p.priority_id
-- JOIN statuses s
--     ON sr.status_id = s.status_id
-- WHERE s.status_name = 'Pending'
-- ORDER BY sr.request_date DESC;

-- R7 — Resolved Requests

-- SELECT
--     sr.request_id,
--     u.user_name,
--     c.category_name,
--     sr.subject,
--     sr.request_date,
--     sr.resolved_date,
--     sr.resolution
-- FROM service_requests sr
-- JOIN users u
--     ON sr.user_id = u.user_id
-- JOIN categories c
--     ON sr.category_id = c.category_id
-- JOIN statuses s
--     ON sr.status_id = s.status_id
-- WHERE s.status_name = 'Resolved'
-- ORDER BY sr.resolved_date DESC;

-- R8 — Monthly Service Request Trend

-- SELECT
--     YEAR(request_date) AS request_year,
--     MONTH(request_date) AS request_month,
--     COUNT(*) AS total_requests
-- FROM service_requests
-- GROUP BY
--     YEAR(request_date),
--     MONTH(request_date)
-- ORDER BY
--     request_year,
--     request_month;





