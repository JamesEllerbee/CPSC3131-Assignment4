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
SET @oldsum = 0;
SET @newsum = 0;
SET @sumdif = 0; 
DROP PROCEDURE IF EXISTS sum_pay_increase; -- Drops procedure from previous execution
delimiter //
CREATE PROCEDURE sum_pay_increase (OUT sumdif)
BEGIN

-- Delete old Salary records
DROP TABLE IF EXISTS retiredEmployees
CREATE TABLE retiredEmployees
(
	emp_no INT,
	dept_name VARCHAR(255),
    salary INT,
    from_date DATE,
    to_date DATE, 

    PRIMARY KEY(emp_no)
);

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
DROP TABLE IF EXISTS oldSalaries;
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
    from_date DATE,
    to_date DATE, 

    PRIMARY KEY(emp_no)
);
DROP TRIGGER IF EXISTS Before_newSalaries_delete
DROP TRIGGER IF EXISTS before_newSalaries_update
DELIMITER $$
CREATE TRIGGER before_newSalaries_delete 
    BEFORE DELETE ON newSalaries
    FOR EACH ROW 
BEGIN
    INSERT INTO retiredEmployees
    SET action = 'update',
     emp_no = OLD.emp_no,
	   dept_name = OLD.dept_name,
       salary = OLD.salary,
       from_date = OLD.from_date,
       to_date = OLD.to_date,
        changedat = NOW(); 
END$$
DELIMITER ;
DELETE FROM newSalaries
WHERE to_date < "1987-06-28";
DROP TRIGGER IF EXISTS after_newSalaries_insert
CREATE TRIGGER after_newSalaries_insert 
    AFTER INSERT ON newSalaries
    FOR EACH ROW SET @oldsum = @oldsum + NEW.salary;

CREATE TABLE oldSalaries
(
	emp_no INT,
	dept_name VARCHAR(255),
    salary INT,
    from_date DATE,
    to_date DATE, 

    PRIMARY KEY(emp_no)
);

-- 9 create trigger for updating oldSalaries when newSalaries changes
DROP TRIGGER IF EXISTS before_newSalaries_update
DELIMITER $$
CREATE TRIGGER before_newSalaries_update 
    BEFORE UPDATE ON newSalaries
    FOR EACH ROW 
BEGIN
    INSERT INTO oldSalaries
    SET action = 'update',
     emp_no = OLD.emp_no,
	   dept_name = OLD.dept_name,
       salary = OLD.salary,
       from_date = OLD.from_date,
       to_date = OLD.to_date,
        changedat = NOW(); 
        SET @newsum = @newsum + new.salaries;
END$$
DELIMITER ;
-- 2 insert into table
-- insert the emp_no into the new salary table
INSERT INTO newSalaries(emp_no)
SELECT employees.emp_no
FROM employees;

-- insert the dept_name into the new salaries table
INSERT INTO newSalaries(dept_name)
SELECT departments.dept_name
FROM departments, dept_emp, employees
WHERE (employees.emp_no = dept_emp.emp_no) AND (dept_emp.dept_no = departments.dept_no);

-- insert the salary from salaries table into new salaries, where the new salaries emp_no == salaries.emp_no
INSERT INTO newSalaries(salary)
SELECT salaries.salary
FROM salaries
WHERE newSalaries.emp_no = salaries.emp_no;

-- insert from date into the new salaries table
INSERT INTO newSalaries(from_date)
SELECT salaries.from_date
FROM salaries
WHERE employees.emp_no = salaries.emp_no;

-- insert the to_date 
INSERT INTO newSalaries(to_date)
SELECT salaries.to_date
FROM salaries
WHERE employees.emp_no = salaries.emp_no;

-- 3 update table (honesty these should *count* as a if, else if)
UPDATE newSalaries
SET
	salary = salary + (salary * custServ)
WHERE newSalaries.dept_name = 'Customer Service';

UPDATE newSalaries
SET
	salary = salary + (salary * devel)
WHERE newSalaries.dept_name = 'Development';

UPDATE newSalaries
SET
	salary = salary + (salary * finan)
WHERE newSalaries.dept_name = 'Finance';

UPDATE newSalaries
SET
	salary = salary + (salary * human)
WHERE newSalaries.dept_name = 'Human Resources';

UPDATE newSalaries
SET
	salary = salary + (salary * market)
WHERE newSalaries.dept_name = 'Marketing';

UPDATE newSalaries
SET
	salary = salary + (salary * product)
WHERE newSalaries.dept_name = 'Production';

UPDATE newSalaries
SET
	salary = salary + (salary * quality)
WHERE newSalaries.dept_name = 'Quality Management';

UPDATE newSalaries
SET
	salary = salary + (salary * research)
WHERE newSalaries.dept_name = 'Research';

UPDATE newSalaries
SET
	salary = salary + (salary * sales)
WHERE newSalaries.dept_name = 'Sales';

END//
delimiter ;
SET @sumdif = @newSalary - @oldSalary;
-- call procedure and return total payroll increase
CALL sum_pay_increase(@sumdif);