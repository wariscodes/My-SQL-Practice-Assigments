drop DATABASE IF EXISTS company_training;
CREATE DATABASE company_training;
USE company_training;
CREATE TABLE departments (
	department_id INT NOT NULL,
	dept_name VARCHAR(80) NOT NULL,
	city VARCHAR(60)
);
CREATE TABLE employees (
	employee_id INT NOT NULL,
	employee_name VARCHAR(100) NOT NULL,
	email VARCHAR(120),
	department_id INT NOT NULL,
	salary DECIMAL(10,2),
	status VARCHAR(20)
);

INSERT INTO departments(department_id , dept_name , city)
VALUES(1 , 'IT' , 'Delhi'),
(2 , 'HR' , 'Noida'),
(3 , 'Finance' , 'Gaziabad');

INSERT INTO employees
(employee_id, employee_name, email, department_id, salary, status)
VALUES
(101, 'Rahul', 'rahul@gmail.com', 1, 45000, 'Active'),
(102, 'Priya', 'priya@gmail.com', 2, 50000, 'Active'),
(103, 'Amit', 'amit@gmail.com', 1, 40000, 'InActive'),
(104, 'Neha', 'neha@gmail.com', 3, 55000, 'Active');

SELECT * FROM employees;

-- ---- Q1 Add a PRIMARY KEY constraint on departments.department_id.
ALTER TABLE departments
ADD PRIMARY KEY (department_id);

-- Q2. Add a PRIMARY KEY constraint on employees.employee_id.
ALTER TABLE employees
ADD PRIMARY KEY (employee_id);
SHOW CREATE TABLE employees;

-- Q3. Add a new column named location of type VARCHAR(100) to the departments table.-- 
ALTER TABLE departments
ADD COLUMN location VARCHAR(100);

-- Q4. Rename the column dept_name to department_name in the departments table, keeping its existing data type and
-- NOT NULL requirement.

-- Q5.Modify employees.salary to DECIMAL(12,2) and ensure that it does not allow NULL values.
ALTER TABLE employees
MODIFY COLUMN salary DECIMAL(12,2) NOT NULL;

-- 6. Set the default value of employees.status to Active.
ALTER TABLE employees
ALTER COLUMN status SET DEFAULT 'Active';

-- Q7. Add a UNIQUE constraint on employees.email.
ALTER TABLE employees
ADD CONSTRAINT unique_email
UNIQUE (email);

-- Q8. Rename the employees table to staff.
RENAME TABLE employees TO staff;

-- Q9. Add a FOREIGN KEY constraint on staff.department_id referencing departments.department_id.
ALTER TABLE staff
ADD CONSTRAINT fk_staff_department
FOREIGN KEY (department_id)
REFERENCES departments(department_id);

-- Q10. Drop the UNIQUE constraint added to staff.email in Question 7.
ALTER TABLE staff
DROP INDEX unique_email;

-- 11. Drop the FOREIGN KEY constraint created in Question 9 without dropping the department_id column.
ALTER TABLE staff
DROP FOREIGN KEY fk_staff_department;

-- 12. Drop the PRIMARY KEY constraint from the staff table, retaining its employee_id column.
ALTER TABLE staff
DROP PRIMARY KEY;

-- 13. Add the PRIMARY KEY constraint back on staff.employee_id.
ALTER TABLE staff
ADD PRIMARY KEY (employee_id);

-- 14. Drop the location column from the departments table.
ALTER TABLE departments
DROP COLUMN location;

-- Q15. Rename the database from company_training to company_management using MySQL-supported DDL operations.
-- Create the new database, move both tables to it, and remove the old empty database. (MySQL does not support a
-- direct RENAME DATABASE command.)

CREATE DATABASE company_management;

RENAME TABLE
company_training.departments
TO company_management.departments;

RENAME TABLE
company_training.staff
TO company_management.staff;

USE company_management;

SHOW TABLES;