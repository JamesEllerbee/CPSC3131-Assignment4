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
DROP PROCEDURE IF EXISTS sum_pay_increase; -- allows multiple executions
delimiter //
CREATE PROCEDURE sum_pay_increase ()
BEGIN
-- drop tables from previous execution
DROP TABLE IF EXISTS salariesCopy;
DROP TABLE IF EXISTS newSalaries;
-- copy salaries table into copy to avoid making presistent changes to database
CREATE TABLE salariesCopy LIKE salaires;
INSERT salariesCopy SELECT * FROM salaries; -- this is a good idea because this table remains until the SQL script is ran again.

-- 1 create table
 -- table will be used to store the current salary of the employees
CREATE TABLE newSalaries
(
	emp_no INT,
	dept_name VARCHAR(255),
    salary INT,

    PRIMARY KEY(emp_no)
);
-- 2 insert into table
INSERT INTO newSalaries(emp_no)
SELECT employees.emp_no
FROM employees;

INSERT INTO newSalaries(dept_name)
SELECT departments.dept_name
FROM departments, dept_emp, employees
WHERE (employees.emp_no = dept_emp.emp_no) AND (dept_emp.dept_no = departments.dept_no);

-- 3 update table


END//
delimiter ;
