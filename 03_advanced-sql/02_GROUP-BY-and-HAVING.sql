/* -------------------------------------------------------------------------- */
/*                                  HAVING                                  */
/* -------------------------------------------------------------------------- */
/*
	HAVING keyword allows to filter after a grouping 
	Questions: https://github.com/mobinni/Complete-SQL-Database-Bootcamp-Zero-to-Mastery/blob/master/SQL%20Deep%20Dive/Having/questions.sql
	Solutions: https://github.com/mobinni/Complete-SQL-Database-Bootcamp-Zero-to-Mastery/blob/master/SQL%20Deep%20Dive/Having/answers.sql

*/
-- Get the amount of employees in a department per departments

-- ✅ working by Joining with ON
-- SELECT d.dept_name, COUNT(e.emp_no) AS "emp_count" FROM employees AS e
-- 		INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no
-- 		INNER JOIN departments AS d ON de.dept_no = d.dept_no
-- 		GROUP BY d.dept_name
-- 		HAVING COUNT(e.emp_no) > 25000;

-- ✅ working by joining with USING
SELECT dept_name, COUNT(emp_no) AS "emp_count" FROM employees
	INNER JOIN dept_emp USING( emp_no )
	INNER JOIN departments USING( dept_no )
	GROUP BY dept_name
	HAVING COUNT(emp_no) > 25000


/* -------------------------------------------------------------------------- */
/*                              PERSONAL PRACTICE                             */
/* -------------------------------------------------------------------------- */

-- Personal practice: How many women and men there are from employed in the development departments
SELECT dept_name, gender, COUNT(gender) FROM employees
	INNER JOIN dept_emp USING (emp_no)
	INNER JOIN departments USING (dept_no)
	WHERE gender = 'F' OR gender = 'M'
	GROUP BY dept_name, gender
	HAVING dept_name LIKE 'D%';



/* -------------------------------------------------------------------------- */
/*                                  PRACTICE                                  */
/* -------------------------------------------------------------------------- */
/**
	Questions: https://github.com/mobinni/Complete-SQL-Database-Bootcamp-Zero-to-Mastery/blob/master/SQL%20Deep%20Dive/Having/questions.sql
	Answers: https://github.com/mobinni/Complete-SQL-Database-Bootcamp-Zero-to-Mastery/blob/master/SQL%20Deep%20Dive/Having/answers.sql

**/
/*
*  Show me all the employees, hired after 1991, that have had more than 2 titles
*  Database: Employees
	---- Results:
		- ✅ records: 52
*/
SELECT emp_no, COUNT(hire_date), EXTRACT( YEAR FROM hire_date ) as "hired year" FROM employees
	INNER JOIN titles USING(emp_no)
	WHERE EXTRACT( YEAR FROM hire_date ) > 1991
	GROUP BY emp_no, EXTRACT( YEAR FROM hire_date ) > 1991
	HAVING COUNT(hire_date) > 2
	ORDER BY emp_no

-- ********************		SOLUTION	*************************
/*	---- Results:
	- records: 52
*/
SELECT e.emp_no, count(t.title) as "amount of titles"
FROM employees as e
JOIN titles as t USING(emp_no)
WHERE EXTRACT (YEAR FROM e.hire_date) > 1991
GROUP BY e.emp_no
HAVING count(t.title) > 2
ORDER BY e.emp_no;
-- **************************************************************


/*
*  Show me all the employees that have had more than 15 salary changes that
	 work in the department development

*  Database: Employees
---- Results:
		- records: 38865
*/

-- ❌ forgot about development department
-- SELECT emp_no, COUNT(salary) FROM employees
-- JOIN salaries USING(emp_no)
-- GROUP BY emp_no HAVING COUNT(salary) > 15
-- ORDER BY emp_no
-- LIMIT 10;


-- - RESULT - records: 38865
-- ❌ Not the same amount of records: because calculating 
-- the changes from salary whereas the solution count
-- the date_from hired date
SELECT emp_no, COUNT(salary), dept_name FROM employees
JOIN salaries USING(emp_no)
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
JOIN titles USING(emp_no)
-- GROUP BY emp_no, title, dept_name ---> see emp_no title changes
GROUP BY emp_no, dept_name ---> see real unique records 
HAVING dept_name = 'Development' AND COUNT(salary) > 15
ORDER BY emp_no


-- ********************		SOLUTION	*************************
---- RESULTS -  records: 11493

SELECT e.emp_no, count(s.from_date) as "amount of raises"
FROM employees as e
JOIN salaries as s USING(emp_no)
JOIN dept_emp AS de USING(emp_no)
WHERE de.dept_no = 'd005'
GROUP BY e.emp_no
HAVING count(s.from_date) > 15
ORDER BY e.emp_no;
-- **************************************************************



/*
*  Show me all the employees that have worked for multiple departments
*  Database: Employees
	RESULT: 31579 records
*/
SELECT emp_no, COUNT(dept_no) FROM employees
	JOIN dept_emp USING (emp_no)
	GROUP BY emp_no
	HAVING COUNT(dept_no) > 1
	ORDER BY emp_no

-- ********************		SOLUTION	*************************
---- RESULTS -  records: 31579
SELECT e.emp_no, count(de.dept_no) as "worked for # departments"
FROM employees as e
JOIN dept_emp AS de USING(emp_no)
GROUP BY e.emp_no
HAVING count(de.dept_no) > 1
ORDER BY e.emp_no;
-- **************************************************************


