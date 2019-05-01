/*
Adam Davies, James Ellerbee, Taylor Woods
CPSC 3131
Assignment 4; all parts,

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

END//
delimiter ;
