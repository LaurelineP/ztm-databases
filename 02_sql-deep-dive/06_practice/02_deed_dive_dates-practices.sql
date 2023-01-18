
--                                  PRACTICE WITH DATES
-- Questions: 
-- Solutions: https://github.com/mobinni/Complete-SQL-Database-Bootcamp-Zero-to-Mastery/blob/master/SQL%20Deep%20Dive/Date%20Filtering/answers.sql
-----------------------------------------------------------------------------------
/*
* DB: Employees
* Table: employees
* Question: Get me all the employees above 60, use the appropriate date functions
*/

-- First solution found
-- Response: --> filters people under 60
-- Resonse 2: -->  counts 229836

-- SELECT COUNT(emp_no) FROM employees
SELECT *, AGE( birth_date ) AS "emp_age" FROM employees
WHERE EXTRACT( YEAR FROM AGE( birth_date )) > 60;


-- Response 3: --> Creates a new column is_eq_lt_60 based on the extraction
SELECT *,
    EXTRACT ( YEAR FROM AGE( birth_date )) > 60 AS is_eq_gt_60
    FROM employees;
    
            ---------------- CORRETION ----------------
            
SELECT AGE(birth_date), * FROM employees
WHERE (
   EXTRACT (YEAR FROM AGE(birth_date))
) > 60 ;

-- alternative

-- alternative
SELECT count(birth_date) FROM employees
WHERE birth_date < now() - INTERVAL '61 years' -- 61 years before the current date



------------------------------------------------------------

/*
* DB: Employees
* Table: employees
* Question: How many employees where hired in February?
*/

-- Response: 24448
SELECT COUNT(emp_no) FROM employees
WHERE EXTRACT ( MONTH FROM hire_date ) = 2;

        ---------------- CORRETION ----------------
SELECT count(emp_no) FROM employees
WHERE EXTRACT (MONTH FROM hire_date) = 2;

------------------------------------------------------------


/*
* DB: Employees
* Table: employees
* Question: How many employees were born in november?
*/

-- Response: 23862
SELECT COUNT(emp_no) FROM employees
WHERE EXTRACT ( MONTH FROM hire_date ) = 11;

        ---------------- CORRETION ----------------

SELECT COUNT(emp_no) FROM employees
WHERE EXTRACT (MONTH FROM birth_date) = 11;
        

------------------------------------------------------------

/*
* DB: Employees
* Table: employees
* Question: Who is the oldest employee? (Use the analytical function MAX)
*/

-- Response: 70
SELECT MAX( EXTRACT( YEAR FROM AGE( birth_date ))) FROM employees;

        ---------------- CORRETION ----------------
        
SELECT MAX(AGE(birth_date)) FROM employees;

------------------------------------------------------------


/*
* DB: Store
* Table: orders
* Question: How many orders were made in January 2004?
*/

-- Response: 1000
SELECT COUNT(orderid) FROM orders
WHERE EXTRACT ( YEAR FROM orderdate ) = 2004
    AND EXTRACT ( MONTH FROM orderdate ) = 1;
    
            ---------------- CORRETION ----------------
    
    SELECT COUNT(orderid)
FROM orders
WHERE DATE_TRUNC('month', orderdate) = date '2004-01-01';
    
------------------------------------------------------------