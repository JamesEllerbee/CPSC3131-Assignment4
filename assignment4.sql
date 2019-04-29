/*
assignment 4, do one stored procedure that does the following
has to read from at least 3 tables (to be done on the employees table) has to:
1 add a table
2 instert into a table
3 update a table
4 delete a record from a table
5 delete a table
6 do an inner join
7 have an if else satements
8 return a value
9 code a trigger on each three ops: Update, insert, delete
*/

-- return sum of pay increases to clarify, the salary increase should be calculated based on percentages and then inserted into the appropriate department table
delimiter //
CREATE PROCEDURE sum_pay_increase ()
BEGIN

END//
delimiter ;

--4
DELETE FROM salary
WHERE to_date = "1987-06-28";
--5
DROP TABLE salary;

--6
--what tables do you want in a union? 
