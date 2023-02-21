/* -------------------------------------------------------------------------- */
/*                               WINDOW FUNCTION                              */
/* -------------------------------------------------------------------------- */
/* Window functions create a new column
	based on function performed on
	a subset ( or "window" ) of data requested
	on the query

		- using OVER() sets the subset of
		all records ( empty parentheses )
	
	- This applies to ALL records
*/

/* --------------------------------- HOW TO --------------------------------- */
/* Using the window function to find the maximum salary */

-- Regular query: outputs one value --> Max salary
SELECT MAX(salary) FROM salaries;

/* Window function: apply/adds a new column AVG salary to all records
	-  Use: 
		each row will have the new column that can help getting to know
 		the delta between the employee's salary and the max salary

		- output: added "max" column with the value 158220
*/
SELECT *, MAX(salary)
	OVER() -- over all records - when no arguments
	FROM salaries;


/* Window function: applies/adds a new column avg to all records */
		-- output: added "max" column with the value 158220
SELECT *, AVG(salary)
	OVER()
	FROM salaries;


/* Limiting the query will decrease the query performence time
	- this query executes faster

	the function window applies to the window of data queried only:
	meaning it gets the max out from all salaries records 
	and add a column on the returned and limited data
		- output: added "max" column with the value 158220

*/
SELECT *, MAX(salary) OVER() FROM salaries
	LIMIT 10;


/* Window data applied on a filtered query
	the function window is applied based on the returned 
	and filtered data 
	- it will find the max salary among the salary records
	being under 70000
	( max value on the max column will be a number under 70000 )
		- output: added "max" column with the value 69999

*/
SELECT *, MAX(salary) OVER() FROM salaries
	WHERE salary < 70000
	LIMIT 10;


/* -------------------------------------------------------------------------- */
/*                               PARTITIONS                                   */
/* -------------------------------------------------------------------------- */
/*
	...OVER([ <PARTIION> BY <PARTION EXPRESSION>]) as "<COLUMN NAME REF>"
	and
	...OVER([ <ORDER BY> BY 
		<SORT EXPRESSION [ ASC | DESC ]]>
		[ NULL { FIRST | LAST }]
	])  as "<COLUMN NAME REF>"
*/


/* ------------------------------ PARTITION BY ------------------------------ */
	-- Partition by: divides rows into group to apply function against



-- Gets the global average salary ?
	-- ouptut: a new column avg with the value 63810.744836143706
SELECT *, AVG(salary) OVER() FROM salaries;


-- Gets the average salary but by their department ?
-- Partitions are like Group within the OVER
-- to which it group by the provided column name
-- = within the function window applied
SELECT *,
	AVG(salary) OVER(
		PARTITION BY dept_name
	)
	FROM salaries
	JOIN dept_emp USING (emp_no)
	JOIN departments USING (dept_no);
	
	
/* Another example: this partitioner sum 
    for each employee the amount of salary they had
    and add this amount for each row ( =record )
*/
SELECT emp_no, dept_name, COUNT(salary)
    OVER(
        PARTITION BY emp_no
    )
    FROM salaries
    JOIN dept_emp USING( emp_no )
    JOIN departments USING( dept_no );


/* -------------------------------- ORDER BY -------------------------------- */
/* ORDER BY: order the result
	Within a "window function" this may act strangely:
		- ORDER BY: is actually framing function by the criteria asked ( here by salary )
		--> in fact those queries mean: for each emp_no count all before me + my own count
		--> like a cummulated sum operation
*/

/* Here is a query using the COUNT function 
( in order to best reveal the problematic 
that raises ORDER BY within a partiion  )

"count salaries per employee for each rows ( records )"
equivalent to "how many salary each employees did had"?"

*/

-- Init query to see how it behaves without ORDER BY within the partition
--- output: count for every row is: 2844047
-- Observation: this is the global count
SELECT emp_no,
    COUNT(salary) OVER()
    FROM salaries;


-- 
/*
    Partitionner PARTITION BY:
    Here this count per emp_no how many salary they had 
*/
SELECT emp_no,
    COUNT(salary) OVER(
        PARTITION BY emp_no
    )
    FROM salaries;
    

    
-- Adjusted query with ORDER BY within the partition
--- output: count differs and varies sometimes between rows
--- Attempt Observation: this counts how many salaries the same employee had?
--- Observation: cumulative / the query counts granularly : revealing 
---     how the query went from a number to another
--         Ex: emp_no 10001 counted in its rows 17,
--             ( counted the first same employee 10001 records => 17 )
--             right after with emp_no 10002, it is 23,
--             ( counted how many saraly records 10002 had + the first 17 => 17 + 6 = 23 )
--              and so forth

/*
    Partionner ORDER BY 
    Here is cumulatively (+= )counting all salary
    cumulate each employee amount: taking the prior value
    added to the next one

    Note: ORDER BY changes the frame of the window function
    telling the query "to count everything before with myself"
*/

SELECT emp_no, salary, COUNT(salary)
    OVER(
        ORDER BY emp_no
    )
    FROM salaries;



/* -------------------------------------------------------------------------- */
/*                                FRAME CLAUSE                                */
/* -------------------------------------------------------------------------- */
/*
	Frame clause allows to create a sub range or frame in the "window function"

		--> here it adds the detail on total count per emp in cumulative way 
		--> higlights how many salary one employee cumulated + count in a cumulative way
			the the count of the next employee 
		--> count of the employee x + count of the employee x+1
*/

/*
    This following query output will SUM the number of salary changes
    for each rows
    "ORDER BY" emp_no here: SUM all salary per emp_no
        --> emp_no being present x times --> the cell in count
            wuould display the total for each emp_no
*/
SELECT emp_no, salary, COUNT(salary)
	OVER(
        PARTITION BY emp_no
        ORDER BY emp_no
	)
	FROM salaries;
	
	
/*
    This following query output granularly count 1 by 1
    all salary: how the granularity happens?
    
    It happens because
    "ORDER BY" emp_no here: calculate each different salary
    through all the table, since all salary are different,
    the cumulative count will happen 1 by 1 per emp_no
    ( count will continue as long as the emp_no is the same 
        otherwise the count reset to one
    )
*/
SELECT emp_no, salary, COUNT(salary)
	OVER(
        PARTITION BY emp_no
        ORDER BY salary
	)
	FROM salaries;
	
	
	
	
	
/* -------------------------------------------------------------------------- */
/*                       FRAMING CLAUSE WITH SUB RANGES                       */
/* -------------------------------------------------------------------------- */
/*
    Reminder: 
    - RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING is eq. to default 
        behavior all frame based on emp_no
    - in no range are given, the default behavior is eq. to all rows too
    Hence here, the result would have:
        - count all salary for the partition by `emp_no`
        (eq: count salary for all group with the same `emp_no`)
        - no cumulative result over each same rows just the totol
        In HERE: replacing `range` per `ROWS` would also output the same result
        
*/
SELECT emp_no, salary, hire_date, count(salary)
	OVER (
		PARTITION BY emp_no
		/* with or without the following frame, this would output the same result */
		RANGE
			BETWEEN UNBOUNDED PRECEDING
			AND UNBOUNDED FOLLOWING
	) FROM salaries JOIN employees USING(emp_no);


/* -------------------------------------------------------------------------- */
/*                       SOLVING FOR CURRENT MAX SALARY                       */
/* -------------------------------------------------------------------------- */
/*
    1. Select distinct emp_no: to get one unique row per column
    1a. do not add more columns otherwise it would not necesarrily
        have one unique row per column
    2. LAST VALUE - function aggregation : allows to select (analysing the the framing window)
        the last value recorded for the given emp_no
    3. The framing window:
        - ORDER BY "from_date" column allows to evaluate ( with the LAST_VALUE state in the selection)
        - RANGE ( or ROWS ) BETWEEN: ceil the framing window by stating which rows for a same emp_no
        are to evaluate
        The function applied to all record will iterate over all rows for a given emp_no
        its current value + the previous one + the next ones
        
*/
SELECT DISTINCT emp_no, 
    LAST_VALUE(salary) OVER(
		PARTITION BY emp_no
		ORDER BY from_date
		RANGE 
			BETWEEN UNBOUNDED PRECEDING
			AND UNBOUNDED FOLLOWING
	),
	LAST_VALUE(from_date) OVER(
            PARTITION BY emp_no
            ORDER BY from_date
		RANGE 
			BETWEEN UNBOUNDED PRECEDING
			AND UNBOUNDED FOLLOWING
         )
	FROM salaries JOIN employees USING(emp_no)
	ORDER BY emp_no;
	
	
/*
    A simpler way to do it with DISTINCT
    
*/
SELECT DISTINCT emp_no, salary, MAX(from_date)
	FROM salaries JOIN employees USING(emp_no)
	ORDER BY emp_no;