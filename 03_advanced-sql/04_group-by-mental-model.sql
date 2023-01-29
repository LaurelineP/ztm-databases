/* -------------------------------------------------------------------------- */
/*                            GROUP BY MENTAL MODEL                           */
/* -------------------------------------------------------------------------- */
/*
	One must represents her/his self 
		- the SQL capacities
		- the Databases' available details
		to answer or build a question
*/

/* ----------------------- INIT GROUP BY MENTAL MODEL ----------------------- */

-- Q: [ original ] Get the most recent date employees got their salary from ?
-- Q: What was the latest employees' salary change ?
	-- subject( = DB ): employees and salaries ( > 1 table = Joining action )
	-- SQL links 	: how to join: emp_no
	-- SQL detail 	: "most recent date" = MAX(<column_date>)
	-- Should we group: yes as MAX is aggregate function 

-- Practice before seeing the video
-- Result:  records 300024
SELECT emp_no, MAX(from_date), COUNT(salary) from employees
	JOIN salaries USING( emp_no )
	GROUP BY emp_no;


-- Course code
-- RESULT: 300024 records
SELECT emp_no, MAX(from_date) FROM salaries
GROUP BY emp_no;

/*
	Delta observation between personal practice and course
		DB resolution:
			--> not focused enough
		- course code: more efficient - uses one table

		Result resolution:
		- personal practice: aggregate function on last date
		- course code: aggregate function on salary
		🤔 --> Self-Questionning:
			is it relevant enough to assume
			the max salary is the latest received ?
*/ 
-- Next step - adding order



/* ------------ NEXT STEP: CORRELATE MATCHED DATE WITH ITS SALARY ----------- */
/*
-- Q: [ original ] Get the most recent date employees got their salary from + the salary
	associated to the date

	 Note: 👍 the questionning the course is raising is exactly the question I had earlier
	 Case example: last date salary may not be a raise of prior salaries / but a new one 
					or regressed one 
					ex: 
						| emp_no 	| salary | date year 	|
						| 001 		| 200000 | 2021 		|
						| 001 		| 205000 | 2022 		|
						| 001 		| 202500 | 2023 		|
		Hence getting the MAX( salary ) combined to MAX( date year )
		would not ensure the related salary to the related date

*/

-- Personal practice - no sucess displaying salary associated
SELECT emp_no, MAX(from_date) AS "last_salary_change_date" FROM salaries
GROUP BY emp_no;


---> Continues on next sheet 05_GROUPING-SETS
