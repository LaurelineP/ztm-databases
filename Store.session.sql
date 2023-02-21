SELECT prod_id, category, price,
	FIRST_VALUE(price) OVER (
		PARTITION BY category
		RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
	)
	FROM products
	ORDER BY prod_id, category;


SELECT customerid,
	OVER(
		PARTITION BY customerid,
	)

	FROM cust_hist
	JOIN O