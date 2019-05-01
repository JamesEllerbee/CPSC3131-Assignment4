/*
assignment 4, do one stored procedure that does the following
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

delimiter //
CREATE PROCEDURE sum_pay_increase ()
BEGIN
DROP TABLE IF EXISTS empSalary;
-- 4
DELETE FROM salary
WHERE to_date = "1987-06-28";

-- 7



-- 9

-- 1 create table
CREATE TABLE empSalary
(
	emp_no INT,
    title VARCHAR(255),
    salary INT,

    PRIMARY KEY(emp_no)
); 
-- 2 insert into table
INSERT INTO empSalary(emp_no)
SELECT emp_no
FROM employees;

-- 3 update a table
INSERT INTO empSalary(salary)
SELECT salaries.salary
FROM salaries
WHERE empSalary.emp_no = salaries.emp_no;

INSERT INTO empSalary(title)
SELECT title
FROM titles
WHERE empSalary.emp_no = titles.title;
-- 5
DROP TABLE IF EXISTS salary;
-- 6
-- what tables do you want in a union?

-- 8

END//
delimiter ;
