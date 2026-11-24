DROP DATABASE IF EXISTS interview_commands_practice;
CREATE DATABASE interview_commands_practice;
USE interview_commands_practice;

SET autocommit = 1;

CREATE TABLE employees (
employee_id INT PRIMARY KEY,
employee_name VARCHAR(60),
department VARCHAR(30),
city VARCHAR(40),
salary DECIMAL(10, 2),
employment_status VARCHAR(15),
phone VARCHAR(15)
) ENGINE = InnoDB;
INSERT INTO employees
(employee_id, employee_name, department, city,
salary, employment_status, phone)
VALUES
(1, 'Rahul Sharma', 'IT', 'Delhi', 45000.00, 'Active', '9000000001'),
(2, 'Priya Verma', 'HR', 'Mumbai', 42000.00, 'Active', '9000000002'),
(3, 'Amit Patel', 'Sales', 'Ahmedabad', 38000.00, 'Inactive', '9000000003'),
(4, 'Anjali Singh', 'IT', 'Kolkata', 50000.00, 'Active', '9000000004'),
(5, 'Vijay Kumar', 'Finance', 'Bangalore', 55000.00, 'Active', '9000000005'),
(6, 'Sanjay Reddy', 'Sales', 'Hyderabad', 36000.00, 'Active', '9000000006'),
(7, 'Megha Iyer', 'IT', 'Chennai', 48000.00, 'Active', '9000000007'),
(8, 'Neha Gupta', 'HR', 'Delhi', 32000.00, 'Inactive', '9000000008'),
(9, 'Arjun Mehta', 'Finance', 'Pune', 52000.00, 'Active', '9000000009'),
(10, 'Pooja Shah', 'Sales', 'Mumbai', 40000.00, 'Active', '9000000010');
COMMIT;
SELECT * FROM employees;

-- 01. Insert one employee
-- A new employee has joined. Write an INSERT statement with an explicit column list to add the following record to
-- employees. Supply all seven values.
-- 11, Karan Malhotra, IT, Noida, 41000.00, Active, 9000000011
INSERT INTO employees
(employee_id, employee_name, department, city, salary, employment_status, phone)
VALUES
(11, 'Karan Malhotra', 'IT', 'Noida', 41000.00, 'Active', '9000000011');

-- 02. Insert several employees in one statement
-- Add both employees below using a single INSERT statement. Do not write a separate INSERT for each employee.
-- 12, Simran Kaur, HR, Delhi, 35000.00, Active, 9000000012
-- 13, Rohan Das, Sales, Pune, 33000.00, Inactive, 9000000013

INSERT INTO employees
(employee_id, employee_name, department, city, salary, employment_status, phone)
VALUES
(12, 'Simran Kaur', 'HR', 'Delhi', 35000.00, 'Active', '9000000012'),
(13, 'Rohan Das', 'Sales', 'Pune', 33000.00, 'Inactive', '9000000013');

-- 03. Update two values in one row
-- Karan Malhotra, employee_id 11, has moved to Gurgaon and received a salary revision. Change his city to
-- Gurgaon and his salary to 46000.00 in one UPDATE statement. Leave every other employee unchanged.
UPDATE employees
SET city = 'Gurgaon',
	salary = 46000
WHERE employee_id = 11; 

-- 04. Apply a salary increase
-- Give employees 1, 4 and 7 a 10% increase on their current salary using one UPDATE statement. Calculate the
-- increase from the stored salary; do not enter three replacement salary amounts. Run the statement only once.
UPDATE employees
SET salary = salary + (salary * 10 / 100)
WHERE employee_id IN (1, 4, 7);

-- 05. Delete selected employee records
-- Employees 3, 8 and 13 have left the company. Delete only these three records using one DELETE statement. Keep
-- the employees table and all other records.
-- For each task, check the affected row count and inspect the table data in MySQL Workbench. No joins, grouping
-- or subqueries are required.
DELETE FROM employees
WHERE employee_id IN (3, 8, 13);

SELECT *
FROM employees
WHERE employee_id IN (3, 8, 13);

-- 06. Add a new column
-- Use ALTER TABLE to add an email column with data type VARCHAR(100). Allow it to contain NULL. Existing
-- employees do not have email addresses yet, so do not fill the column with invented values.
ALTER TABLE employees
ADD COLUMN email VARCHAR(100) NULL;

-- 07. Change the size of a column
-- The phone column currently allows 15 characters. Use ALTER TABLE to increase it to VARCHAR(20), while keeping
-- the existing phone values. The column should still allow NULL.
ALTER TABLE employees
MODIFY COLUMN Phone VARCHAR(100) NULL;

-- 08. Rename a column
-- Use ALTER TABLE to rename city to work_city. Keep its VARCHAR(40) data type and all existing city values. Use the
-- new column name in later questions.
ALTER TABLE employees
CHANGE COLUMN city work_city VARCHAR(40);

SELECT* FROM employees;
-- 09. Remove an unused column
-- The company decides not to store email addresses in this table. Use ALTER TABLE to remove only the email
-- column added in Question 6. Keep every other column and every employee record.
ALTER TABLE employees
DROP COLUMN email;

-- 10. Rename the table
-- Use RENAME TABLE to change the table name from employees to staff. Keep the data and structure. Use staff for
-- Questions 11 to 15.
RENAME TABLE employees TO staff;

-- 11. Save a group of changes with COMMIT
-- Start a transaction. Insert the employee below into staff, then change the salary of employee 2 to 45000.00. Use
-- COMMIT to save both changes.
-- 14, Nisha Rao, IT, Noida, 44000.00, Active, 9000000014
-- The record order is unchanged, but city is now named work_city. After COMMIT, run ROLLBACK and check
-- whether either saved change is undone.
START TRANSACTION;

INSERT INTO staff
(employee_id, employee_name, department, work_city, salary, employment_status, phone)
VALUES
(14, 'Nisha Rao', 'IT', 'Noida', 44000.00, 'Active', '9000000014');

UPDATE staff
SET salary = 45000.00
WHERE employee_id = 2;
COMMIT;
ROLLBACK;
-- 12. Undo changes with ROLLBACK
-- Start a new transaction. Change employee 5&#39;s salary to 60000.00 and delete employee 6. Before saving, the
-- manager cancels both changes. Use ROLLBACK to undo them together.
-- Check that employee 5 has the previous salary and employee 6 still exists. Do not undo the committed changes
-- from Question 11.
START TRANSACTION;
UPDATE staff
SET salary = 60000
WHERE employee_id = 5;

DELETE FROM staff
WHERE employee_id = 6;

ROLLBACK;

-- 13. Undo part of a transaction with savepoints
-- Complete these steps in one new transaction:
-- a) Change employee 14&#39;s salary to 47000.00. Create a SAVEPOINT named salary_saved.
-- b) Change employee 14&#39;s work_city to Jaipur. Create another SAVEPOINT named city_saved.
-- c) Delete employee 14. Roll back to city_saved to undo only the deletion.
-- d) Roll back to salary_saved to undo the city change as well. Use COMMIT to save the remaining salary change.
-- Check the final salary and work_city of employee 14. Explain which changes were kept and which were undone.
START TRANSACTION;

-- Step A: Salary update
UPDATE staff
SET salary = 47000
WHERE employee_id = 14;

SAVEPOINT salary_saved;
-- Step B: City update
UPDATE staff
SET work_city = 'Jaipur'
WHERE employee_id = 14;

SAVEPOINT city_saved;
-- Step C: Employee delete
DELETE FROM staff
WHERE employee_id = 14;
-- Step D: Delete undo
ROLLBACK TO SAVEPOINT city_saved;
-- Step E: City change undo
ROLLBACK TO SAVEPOINT salary_saved;
-- Step F: Remaining change save
COMMIT;

-- 14. Remove all rows with TRUNCATE
-- The practice data is no longer needed. Start a new transaction, use TRUNCATE TABLE to remove every row from
-- staff, and then run ROLLBACK.
-- Inspect the table and record what happened. Did the rows return? Does the table structure still exist? Explain the
-- observed result in one sentence.
START TRANSACTION;

TRUNCATE TABLE staff;

ROLLBACK;

-- 15. Remove the table and database with DROP
-- Finish the exercise by using DROP TABLE to remove staff completely. Then use DROP DATABASE to remove
-- interview_commands_practice. Execute these commands only after completing Questions 1 to 14.
DROP TABLE staff;

DROP DATABASE interview_commands_practice;


-- --------------------DONE------------------------