
/* -------------------------------------------------------------------------- */
/*                                  DISTINCT                                  */
/* -------------------------------------------------------------------------- */
/*
    `DISTINCT` clause allows to to get unique values from column(s) and will
    not list the duplicates

*/
-- Example: Select all unique salary from all salaries
SELECT DISTINCT salary FROM salaries;


/* -------------------------------- PRACTICE -------------------------------- */
/*    
    Correction: 
    https://github.com/mobinni/Complete-SQL-Database-Bootcamp-Zero-to-Mastery/blob/master/SQL%20Deep%20Dive/Distinct/answers.sql
*/

/* DB: Employees
* Table: titles
* Question: What unique titles do we have?
    -------------------------------------------------
 Response: 7 ( Assistant Engineer, Engineer, Manager,
    Senior Engineer, Senior Staff , Staff, Technique Leader )
*/
SELECT DISTINCT title FROM titles;



/* DB: Employees
* Table: employees
* Question: How many unique birth dates are there?
    -------------------------------------------------
-- Response: 4750
*/
SELECT COUNT(DISTINCT birth_date) FROM employees;




/* DB: World
* Table: country
* Question: Can I get a list of distinct life expectancy ages
* Make sure there are no nulls
    -------------------------------------------------
 Response: 160
*/

SELECT DISTINCT lifeexpectancy FROM country
WHERE lifeexpectancy IS NOT NULL;

------- Correction for this one ----------

SELECT DISTINCT lifeexpectancy FROM country
WHERE lifeexpectancy IS NOT NULL
ORDER BY lifeexpectancy;

