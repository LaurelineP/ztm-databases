/* -------------------------------------------------------------------------- */
/*                          ORDERING BY GROUPED DATA                          */
/* -------------------------------------------------------------------------- */

-- Q: How many people work per department ?
SELECT dept_name, COUNT(emp_no) FROM employees
	JOIN dept_emp USING (emp_no)
	JOIN departments USING (dept_no)
	GROUP BY dept_name;

-- Course code
SELECT d.dept_name, COUNT(e.emp_no) FROM employees AS e
INNER JOIN dept_emp AS de ON de.emp_no = e.emp_no
INNER JOIN departments AS d ON d.dept_no = de.dept_no
GROUP BY d.dept_name;

-- Next step - adding order
SELECT d.dept_name, COUNT(e.emp_no) FROM employees AS e
INNER JOIN dept_emp AS de ON de.emp_no = e.emp_no
INNER JOIN departments AS d ON d.dept_no = de.dept_no
GROUP BY d.dept_name


/* -------------------------------- ORDER BY -------------------------------- */
-- Q: How many people work per department ?
SELECT dept_name, COUNT(emp_no) FROM employees
	JOIN dept_emp USING (emp_no)
	JOIN departments USING (dept_no)
	GROUP BY dept_name
	-- ORDER BY dept_name
	ORDER BY COUNT(emp_no)
