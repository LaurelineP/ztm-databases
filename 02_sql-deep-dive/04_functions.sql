-- Function aggregate functions
-- AVG(): calculates the average of a set of values
-- COUNT(): counts rows in a specified table or view
-- MIN(): gets the minumal value in a set of values
-- MAX(): gets the maxial value in a set of values
-- SUM(): calculates the sum of a set of vsalues
-- https://www.postgresql.org/docs/12/functions-aggregate.html



-- How many people work in the company ? --> 300024
SELECT count(emp_no) FROM employees;


-- Gets the highest salary available --> 158220
SELECT MAX(salary) from salaries


-- Gets the total amount of salaries paid --> 181480757419
SELECT SUM(salary) FROM salaries 