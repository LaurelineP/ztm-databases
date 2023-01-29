/* -------------------------------------------------------------------------- */
/*                       UNION & GROUPING SETS                                */
/* -------------------------------------------------------------------------- */
/*
	Purpose:  `UNION` | `UNION ALL` | `GROUPING SETS()` are meant 
	to make multiple grouping by merging grouping set ( results of each 
	grouping )

	1.`UNION` keyword
		Allows to combine multiple "queries" and removes duplicates
		( from SELECT clause up to the last clause = 1 "query" )

	2. `UNION ALL` keywords
		Do the same but without removing duplicates / in some 
		circumstance we want to keep duplicated records

	3. `GROUPING SETS() function`
		Allows to make multiple grouping within one "query" 
		definition
		( *one* SELECT clause up to its last clause = 1 "query" )
*/



/* -------------- 1. `UNION` AND `UNION ALL` EXAMPLE ------------------------- */
-- Gets the total count of quantity
SELECT NULL AS "prod_id", SUM( quantity ) FROM orderlines

	-- UNION 
	UNION ALL

-- Gets the total count of quantity per "prod_id" records
SELECT prod_id AS "prod_id", SUM( quantity ) FROM orderlines
GROUP BY prod_id
ORDER BY prod_id DESC;


/* ---------------------- 2. `GROUPING SETS()` EXAMPLE ---------------------- */
SELECT prod_id, orderlineid, SUM( quantity )  FROM orderlines
GROUP BY
	GROUPING SETS(
		(), 			-- Gets the total count of quantity ( all records )
		(prod_id),		-- Gets the total count of quantity per prod_id
		(orderlineid) 	-- Gets the total count of quantity per orderlineid, to see the ids
	)
ORDER BY prod_id DESC, orderlineid DESC;


/* -------------------------------------------------------------------------- */
/*                                  PRACTICE                                  */
/* -------------------------------------------------------------------------- */
/*
	Exercises: https://github.com/mobinni/Complete-SQL-Database-Bootcamp-Zero-to-Mastery/blob/master/SQL%20Deep%20Dive/Grouping%20Sets/exercises.sql
	Solutions: 
*/

/*
*  Calculate the total amount of employees per department 
	and the total using grouping sets
*  Database: Employees
*  Table: Employees
*/
-- UNION Practice
SELECT NULL AS "dept_no", COUNT(emp_no) AS "employees_count"  FROM dept_emp

UNION

SELECT dept_name, COUNT( dept_no ) FROM dept_emp
JOIN departments USING( dept_no )
GROUP BY dept_name, dept_no
ORDER BY dept_no ASC;

-- GROUPING SETS Practice
SELECT dept_name, COUNT(emp_no) AS "employees_count" FROM dept_emp
INNER JOIN departments USING( dept_no )
GROUP BY 
	GROUPING SETS(
		(dept_name),
		()
	)
ORDER BY dept_name ASC;

/* ---------------------------- COURSE CORRECTION --------------------------- */
select grouping(e.dept_no), e.dept_no, COUNT(e.emp_no)
FROM public.dept_emp as e
GROUP BY
	GROUPING SETS (
		(e.dept_no),
     		()
	)
order by e.dept_no





/*
*  Calculate the total average salary per department
 and the total using grouping sets

*  Database: Employees
*  Table: Employees

	RESULT: 10 records ( includes a new record ==> TOTAL_COUNT )
	
*/
-- UNION PRACTICE
-- TOTAL AVG = 63805.400520353458
SELECT 'TOTAL_COUNT' AS "dept_no", 'TOTAL_COUNT' AS "dept_name", AVG(salary) FROM dept_emp
	JOIN departments USING( dept_no )
	JOIN salaries USING( emp_no )

UNION
SELECT  dept_no, dept_name, AVG(salary) FROM dept_emp
	JOIN departments USING( dept_no )
	JOIN salaries USING( emp_no )
	GROUP BY dept_no, dept_name
	ORDER BY dept_no;



-- TOTAL AVG = 63805.400520353458
SELECT 'TOTAL_COUNT' AS "dept_no", 'TOTAL_COUNT' AS "dept_name", AVG(salary) FROM dept_emp
	JOIN departments USING( dept_no )
	JOIN salaries USING( emp_no )

UNION
SELECT  dept_no, dept_name, AVG(salary) FROM dept_emp
	JOIN departments USING( dept_no )
	JOIN salaries USING( emp_no )
	GROUP BY dept_no, dept_name
	ORDER BY dept_no;

-- GROUPING SETS PRACTICE - WIP
-- TOTAL - 63805.400520353458 ( diff from bellow observations )
SELECT dept_no, AVG(salary) FROM dept_emp
JOIN departments USING( dept_no )
JOIN salaries USING( emp_no )
GROUP BY 
	GROUPING SETS(
		(),
		(dept_no)
	);

/* ---------------------------- COURSE CORRECTION --------------------------- */
select grouping(de.dept_no), de.dept_no, AVG(e.salary)
FROM public.salaries as e
JOIN public.dept_emp as de USING (emp_no)
GROUP BY
	GROUPING SETS (
		(de.dept_no),
     	()
	)
order by de.dept_no














-- TOTAL AVG - 63805.400520353458
SELECT AVG(salary) FROM dept_emp
JOIN salaries USING( emp_no )

-- TOTAL AVG = 63810.744836143706
SELECT AVG(salary) FROM employees
JOIN salaries USING( emp_no )



-- Insightfull 63810.744836143706: average is different from grouped by 
SELECT * FROM salaries


-- employee: 2844047 /  salary: 2844047 / sum: 181480757419 /  avg 63810.744836143706
SELECT COUNT(emp_no), COUNT(salary), SUM(salary), AVG(salary) FROM salaries

-- employee: 331603 / 
SELECT COUNT(emp_no) FROM dept_emp


SELECT
	COUNT(emp_no) AS "number of employees",
	COUNT(salary) AS "number of salaries",
	SUM(salary) AS "sum of salaries",
	AVG(salary) AS "avg of salaries",
	(SUM(salary) /COUNT(emp_no)) AS "by hand"
	FROM salaries

SELECT
	COUNT(emp_no) AS "number of employees",
	COUNT(dept_emp) AS "🔥 number of dept employees",
	COUNT(salary) AS "number of salaries",
	SUM(salary) AS "sum of salaries",
	AVG(salary) AS "avg of salaries",
	(SUM(salary) /COUNT(emp_no)) AS "by hand"
	FROM dept_emp JOIN salaries USING ( emp_no )



