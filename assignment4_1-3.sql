/*
Adam Davies, James Ellerbee, Taylor Woods
CPSC 3131
Assignment 4; parts 1 - 3,

do one stored procedure that does the following
has to read from at least 3 tables (to be done on the employees table) has to:

1 add a table - add table of percentage salary increases by department
2 instert into a table - calculate salary increase from percentage and use for updating
3 update a table
4 delete a record from a table
5 delete a table
6 do an inner join
7 have an if else satements
8 return a value
9 code a trigger on each three ops: Update, insert, delete
*/

-- Question: create a table of percent pay increase by department which includes name and emp_no and title
-- Insert into salary table
-- delete old pay increase table
-- delete old pay increase columns
-- Triggers
-- Update: if a table is inserted into salaries update the salary column
-- Delete: when a new percent pay increase table is created delete old percent insertions
-- Insert: when a new percent pay increase table is created insert percentages
-- return sum of pay increases to clarify, the salary increase should be calculated based on percentages and then inserted into the appropriate department table

DROP PROCEDURE IF EXISTS sum_pay_increase; -- Drops procedure from previous execution
delimiter //
CREATE PROCEDURE sum_pay_increase ()
BEGIN
-- Precentage values, todo: update these values
-- Customer Service
DECLARE custServ FLOAT DEFAULT 0.01;
-- Development
DECLARE devel FLOAT DEFAULT 0.02;
-- Finance
DECLARE finan FLOAT DEFAULT 0.03;
-- Human Resources
DECLARE human FLOAT DEFAULT 0.04;
-- Marketing
DECLARE market FLOAT DEFAULT 0.05;
-- Production
DECLARE product FLOAT DEFAULT 0.06;
-- Quality Management
DECLARE quality FLOAT DEFAULT 0.07;
-- Research
DECLARE research FLOAT DEFAULT 0.08;
-- Sales
DECLARE sales FLOAT DEFAULT 0.09;
-- drop tables from previous execution
DROP TABLE IF EXISTS salariesCopy;
DROP TABLE IF EXISTS newSalaries;
-- copy salaries table into copy to avoid making presistent changes to database (avoid reimport of employee DB)
CREATE TABLE salariesCopy LIKE salaries;
INSERT salariesCopy SELECT * FROM salaries;

-- 1 create table
 -- table will be used to store the current salary of the employees
CREATE TABLE newSalaries
(
	emp_no INT,
	dept_name VARCHAR(255),
    salary INT,
    hire_date DATE
);
-- 2 insert into table
-- insert values into the new salaries table
INSERT INTO newSalaries(emp_no, dept_name, salary, hire_date)
SELECT employees.emp_no, departments.dept_name, salaries.salary, employees.hire_date
FROM employees, dept_emp, departments, salaries
WHERE (employees.emp_no = salaries.emp_no) AND (employees.emp_no = dept_emp.emp_no) AND (dept_emp.dept_no = departments.dept_no);

-- 3 update table (honesty these should *count* as a if, else if)
-- update salary for customer service
UPDATE newSalaries
SET
	salary = salary + (salary * custServ)
WHERE newSalaries.dept_name = 'Customer Service';
-- update salary for development
UPDATE newSalaries
SET
	salary = salary + (salary * devel)
WHERE newSalaries.dept_name = 'Development';
-- update salaru for finance
UPDATE newSalaries
SET
	salary = salary + (salary * finan)
WHERE newSalaries.dept_name = 'Finance';
-- update salary for human resources
UPDATE newSalaries
SET
	salary = salary + (salary * human)
WHERE newSalaries.dept_name = 'Human Resources';
-- update salary for marketing
UPDATE newSalaries
SET
	salary = salary + (salary * market)
WHERE newSalaries.dept_name = 'Marketing';
-- update salary for production
UPDATE newSalaries
SET
	salary = salary + (salary * product)
WHERE newSalaries.dept_name = 'Production';
-- update salary for quality Management
UPDATE newSalaries
SET
	salary = salary + (salary * quality)
WHERE newSalaries.dept_name = 'Quality Management';
-- update salary for research
UPDATE newSalaries
SET
	salary = salary + (salary * research)
WHERE newSalaries.dept_name = 'Research';
-- update salary for sales
UPDATE newSalaries
SET
	salary = salary + (salary * sales)
WHERE newSalaries.dept_name = 'Sales';
-- return value, change this to sum
END//
delimiter ;
CALL sum_pay_increase();
