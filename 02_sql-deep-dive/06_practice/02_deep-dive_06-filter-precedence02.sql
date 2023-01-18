-- Practice - precedence






-- 2. What was our total sales in June of 2004 for orders over 100 dollars?
-- Result --> Sum is 197886.13
SELECT SUM(totalamount) FROM public.orders
WHERE (date_lt(orderdate, '2004-07-01') AND date_gt(orderdate,'2004-06-01'))
AND totalamount > 100


/* Correction

* DB: Store
* Table: Orders
* Question: 
* What was our total sales in June of 2004 for orders over 100 dollars?


SELECT SUM(totalamount) from orders
WHERE (orderdate >= '2004-06-01' AND orderdate <= '2004-06-30') 
AND totalamount > 100

*/