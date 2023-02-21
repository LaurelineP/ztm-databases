/* -------------------------------------------------------------------------- */
/*                       WINDOW FUNCTION - `SUM`                      */
/* -------------------------------------------------------------------------- */
/*
    "Returns a value evaluated against the last row within its partion"
*/

--  
/*  QUESTION: How much, cumulatively, a customer has ordered
	at the store?
*/


/* -------------------------------------------------------------------------- */
/*                         Personal practice using SUM                        */
/* -------------------------------------------------------------------------- */

 -- ✅ Personal practice using SUM
SELECT * FROM orders ORDER BY customerid;

-- ❌ Good approach but did not pay attention to the question
-- "what do we want to sum?"
SELECT customerid, orderid,
	SUM(orderid) OVER(
		PARTITION BY customerid
	) as "order sum"
	FROM orders
	ORDER BY orderid



/* 🔄 Investigation:
	Verifying an example where the customerid
	did order multiple times and what the query
	would output
*/
SELECT customerid, orderid FROM orders
WHERE customerid = 41



/* 🔄 Investigation:
	Assuming the interest of the question was to count
	how many time the customerid 41 did order
	+ review WHERE clauses
*/
SELECT customerid, orderid, COUNT(orderid) OVER(
	PARTITION BY customerid
	ORDER BY orderid
) FROM orders
WHERE customerid = 41


/* ✅ Investigation/ Attempt ( cumulatively )
	After reading back the question and the
	topic of the file: window function with SUM
	Why Sum ?
	--> How much, cumulatively, a customer did order?
	Sum - calculating progressively the amount of the order
	Note: customerid 1 does not appear ? Why ?
		Answer: Did not exist
*/
SELECT customerid, orderid, totalamount, 
	SUM(totalamount) OVER(
		PARTITION BY( customerid )
		ORDER BY orderid
	) FROM orders
	ORDER BY customerid;


/* -------------------------------------------------------------------------- */
/*                               EXTRA PRACTICE                               */
/* -------------------------------------------------------------------------- */
/** Gets how many times a custom did order ( not cumulatively ) */

-- ❌ Outputs same count for multiple same customerid instead 
-- of having one record and one count
-- ( Missing DISTINCT )
SELECT customerid,
	COUNT(customerid) OVER(
		PARTITION BY customerid
	) FROM orders
	ORDER BY customerid;

-- 🔄 🙌✅  Unsure: looks to be the expected output: is it the way ? ( not cumulatively )
SELECT DISTINCT customerid,
	COUNT(customerid) OVER(
		PARTITION BY customerid
	) AS "ordered times"
	FROM orders
	ORDER BY customerid




-- (repeated) How much a customer did spent on the store? ( not cumulatively )
SELECT DISTINCT customerid,
	SUM(totalamount) OVER ( PARTITION BY customerid )
	FROM orders
	ORDER BY customerid;


-- (repeated) How much a customer did spent on the store and how many order was made? ( not cumulatively )
SELECT DISTINCT customerid,
	SUM(totalamount) OVER (PARTITION BY customerid ) AS "ordered times",
	COUNT(orderid) OVER(PARTITION BY customerid) AS "total spent"
	FROM orders
	ORDER BY customerid;



/* -------------------------------------------------------------------------- */
/*                               COURSE APPROACH                              */
/* -------------------------------------------------------------------------- */
SELECT orderid, customerid, netamount,
	SUM( netamount ) OVER (
		PARTITION BY customerid
		ORDER BY orderid
	) AS "cum sum"
	FROM orders
	ORDER BY customerid;


SELECT * FROM customers;


/* -------------------------------------------------------------------------- */
/*                      MENTORING: DISTINCT explained                         */
/* -------------------------------------------------------------------------- */
/*  With and without DISTINCT: explanation to a student
	How many curstomers are living in the same state ?
		-- what we want:
			- one total count of customers / state
			- on state
		-- using window function we know we will get a new column
			for each record with the calculated value
		-- all records are not unique to the state ( state is repeated by customer )

*/
/* Here it adds a new column count for each row 
	- each row representing a customer but it is the same information
	- at the end we do not need the duplicated information
	- this is where DISTINC comes handy
*/
-- without DISTINCT
SELECT state,
	COUNT(customerid) OVER( PARTITION BY state )
	FROM customers
	ORDER BY state;

-- with DISTINCT
/* One unique row per state with the total count of customers */
SELECT DISTINCT state,
	COUNT(customerid) OVER ( PARTITION BY state )
	FROM customers
	ORDER BY state;


