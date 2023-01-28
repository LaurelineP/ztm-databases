/* -------------------------------------------------------------------------- */
/*                                  GROUP BY                                  */
/* -------------------------------------------------------------------------- */
/*
	GROUP BY keyword allows to group a value according to an aggregated value
	- This summarizes or aggregating data by groups
	- Why ? to get in depth information by group

*/

-- Example: How many employees worked in each departments
	-- count what: employees
	-- per what: departments

SELECT dept_no, dept_name, COUNT(emp_no) FROM dept_emp
INNER JOIN departments USING(dept_no)
GROUP BY dept_no, dept_name;


/* -------------------------------------------------------------------------- */
/*                                  PRACTICE                                  */
/* -------------------------------------------------------------------------- */
/**
	Questions: https://github.com/mobinni/Complete-SQL-Database-Bootcamp-Zero-to-Mastery/blob/master/SQL%20Deep%20Dive/Group%20By/questions.sql
	Answers: https://github.com/mobinni/Complete-SQL-Database-Bootcamp-Zero-to-Mastery/blob/master/SQL%20Deep%20Dive/Group%20By/answers.sql

**/

-- Question 1: How many people were hired on any given hire date?
	-- count what: employees
	-- per what: hire date
SELECT hire_date, COUNT(emp_no) FROM employees
GROUP BY hire_date;



/* Question 2: Get all the employees hired after 1991
	and count the amount of positions they've had */
	-- count what: job titles
	-- per what: hire_date > 1991
SELECT hire_date, COUNT(emp_no) FROM Employees
INNER JOIN titles USING(emp_no)
WHERE EXTRACT ( YEAR FROM hire_date ) > 1991
GROUP BY hire_date, emp_no




/* Question 3: Show me all the employees that work in the department
	development and the from and to date. */
	-- count what: employees
	-- per what: work in development, show from and date
/* Epiphany:
	Here, 
		- GROUP BY is red first from joined table
			- kind of a selection columns in GROUP BY that need to be coherent
			( corresponds to the pattern of fields not present in the initial table and not foreign key? --> looks like it )
				- original table being employees with all its fields
					[ emp_no, birth_date, first_name, last_name, gender, fire_date ]
				- departments [ dept_no, dept_name ] --> dept_name
				- dept_emp [ dept_no, dept_no, from_date, to_date ] --> from_date, to_date
		- Select does not matter but to display the desired fields ( columns )

*/

-- second correct attempt but using join
SELECT emp_no, dept_name, from_date, to_date FROM employees
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
WHERE dept_name  = 'Development'
GROUP BY dept_name, emp_no, from_date, to_date


-- first correct attempt
SELECT CONCAT(first_name, ' ', last_name) AS "fullname", emp_no, from_date, to_date
	FROM employees
INNER JOIN dept_emp USING(emp_no)
INNER JOIN departments USING(dept_no)
WHERE dept_name = 'Development'
GROUP BY emp_no, from_date, to_date, dept_name -- followed sql error messages recommandation
ORDER BY from_date; -- extra: gets oldest from the companie

-- -- correction
SELECT e.emp_no, de.from_date, de.to_date
FROM employees as e
JOIN dept_emp AS de USING(emp_no)
WHERE de.dept_no = 'd005'
GROUP BY e.emp_no, de.from_date, de.to_date
ORDER BY e.emp_no, de.to_date;