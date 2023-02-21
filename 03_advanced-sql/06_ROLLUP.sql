/* -------------------------------------------------------------------------- */
/*                                   ROLLUP                                   */
/* -------------------------------------------------------------------------- */
/*
	`ROLLUP()` is also a subgroup of `GROUP BY` allowing to group by
	multiple groupings in a shorter and efficient way
	It correlates any combination there is with the group

	- Used for specific reasons and not used that often

	Using Database store
*/
/* --------------------------- COURSE PRESENTATION -------------------------- */
-- How many order per year, per month and per day were sold?
-- Display this granurally

/**
 STEP 1: this query attempt to show granurally hom many was it sold
 through time : year, month date
*/

-- 1. Gets year, month, day from the date to group by each ref
SELECT
	EXTRACT ( YEAR FROM orderdate ) AS "YEAR",
	EXTRACT ( MONTH FROM orderdate ) AS "MONTH",
	EXTRACT ( DAY FROM orderdate ) AS "DAY",
	SUM(quantity)
	FROM orderlines
-- 2. Groups it granurally
	GROUP BY GROUPING SETS (
		(
			EXTRACT ( YEAR FROM orderdate )
		), 
		(
			EXTRACT ( YEAR FROM orderdate ),
			EXTRACT ( MONTH FROM orderdate )
		), 
		(
			EXTRACT ( YEAR FROM orderdate ),
			EXTRACT ( MONTH FROM orderdate ),
			EXTRACT ( DAY FROM orderdate )
		),
		(
			EXTRACT ( MONTH FROM orderdate ),
			EXTRACT ( DAY FROM orderdate )
		),
		(
			EXTRACT ( MONTH FROM orderdate )
		),
		(
			EXTRACT ( DAY FROM orderdate )
		),
		()
	)
	ORDER BY 
		EXTRACT ( YEAR FROM orderdate ),
		EXTRACT ( MONTH FROM orderdate ),
		EXTRACT ( DAY FROM orderdate )

-- 1. Gets year, month, day from the date to group by each ref
SELECT 
	EXTRACT ( YEAR FROM orderdate ) AS "YEAR",
	EXTRACT ( MONTH FROM orderdate ) AS "MONTH",
	EXTRACT ( DAY FROM orderdate ) AS "DAY",
	SUM(quantity)
	FROM orderlines

-- 2. Groups it granurally
	GROUP BY ROLLUP (
		EXTRACT ( YEAR FROM orderdate ),
		EXTRACT ( MONTH FROM orderdate ),
		EXTRACT ( DAY FROM orderdate )
	)
	ORDER BY 
		EXTRACT ( YEAR FROM orderdate ),
		EXTRACT ( MONTH FROM orderdate ),
		EXTRACT ( DAY FROM orderdate )