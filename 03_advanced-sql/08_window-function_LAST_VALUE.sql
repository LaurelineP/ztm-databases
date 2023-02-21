/* -------------------------------------------------------------------------- */
/*                       WINDOW FUNCTION - `LAST_VALUE`                      */
/* -------------------------------------------------------------------------- */
/*
    "Returns a value evaluated against the last row within its partion"
*/

--  
/*  QUESTION: For each product, what's the current price --> compares to same category highest price'
    - Partition ===> look at prices by category
    - Range ===> taking into account all values before and after the current record
    - --> to get the FIRST_VALUE when ordered by price
    Note: using window function + LAST_VALUE
*/


 -- ✅ Personal practice using LAST_VALUE
 SELECT prod_id, price, category,
 	LAST_VALUE( price ) OVER(
		PARTITION BY category
		ORDER BY price
		RANGE BETWEEN 
			UNBOUNDED PRECEDING
			AND UNBOUNDED FOLLOWING
	) AS "highest price"
	FROM products
	ORDER BY price;

 -- ✅  Personal practice using MAX ( alternative )
 -- Note: here it takes max price in the catgory and add it to each records
SELECT prod_id, category, price, 
	MAX(price) OVER (
		PARTITION BY category
	) AS "highest price"
	FROM products
	ORDER BY price



-- See the price for each rows and order them by both category and price
-- to see the last record price
SELECT category, price FROM products
GROUP BY price, category
ORDER BY category, price

