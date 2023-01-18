
/* -------------------------------------------------------------------------- */
/*                                  ORDER BY                                  */
/* -------------------------------------------------------------------------- */
/*
    🔸 `ORDER BY` clause allows to sort data based on a criteria.
    
    🔸 The criteria is a column name and optional [ ASC/ DESC ] order
        - ASC: ascendant
        - DESC: descendant
        
    🔸 When ORDER BY is applied on multiple columns and has an optional
    order criteria [ ASC/DESC ] - this is applied to the right most column
    
    🔸 ORDER BY can be used with expression ( using built in function )

*/


-- Example: Is the order applied to all columns or else?
SELECT * FROM employees
ORDER BY first_name, last_name DESC; -- DESC is applied to last_name only


-- Example: Each column can apply an order option [ ASC/DESC ]
SELECT * FROM employees
ORDER BY first_name ASC, last_name DESC; -- DESC is applied to last_name only


-- Example: Order By with expression ( expression LENGTH(x) <ORDER> )
SELECT * FROM employees
ORDER BY LENGTH(last_name) DESC;



/* -------------------------------- PRACTICE -------------------------------- */
/*    
    Correction: 
    https://github.com/mobinni/Complete-SQL-Database-Bootcamp-Zero-to-Mastery/blob/master/SQL%20Deep%20Dive/Order%20By/answers.sql
*/
/*
* DB: Employees
* Table: employees
* Question: Sort employees by first name ascending and last name descending
    - is response correct ? ✅
*/
SELECT * FROM employees
ORDER BY first_name ASC, last_name DESC;

/*
* DB: Employees
* Table: employees
* Question: Sort employees by age
    - is response correct ? ✅
*/
-- clasic approach: sort without really checking age value
SELECT * FROM employees
ORDER BY AGE(birth_date) ; -- + extra Age resolution is added here

-- other approach: creating a new column "emp_age" to check age value
SELECT *, EXTRACT( YEAR FROM AGE(birth_date) ) AS "emp_age" FROM employees
ORDER BY emp_age ASC;

/*
* DB: Employees
* Table: employees
* Question: Sort employees who's name starts with a "k" by hire_date
    - is response correct ? ✅
*/
SELECT * FROM employees
WHERE first_name LIKE 'K%'
ORDER BY hire_date;