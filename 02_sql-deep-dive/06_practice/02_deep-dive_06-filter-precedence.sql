-- Practice - precedence
/* 1. Select people either under 30 or over 50 with an income above 50000 that are from either Japan or Australia */

-- Result --> 1419
SELECT count(customerid) FROM public.customers
WHERE ( age < 30 OR age > 50 ) AND income > 50000
AND ( country = 'Australia' OR country = 'Japan' )



/* Correction

* DB: Store
* Table: Customers
* Question: 
* Select people either under 30 or over 50 with an income above 50000
* Include people that are 50
* that are from either Japan or Australia


SELECT firstname, income, age from customers
WHERE income > 50000 AND (age < 30 OR age >= 50)
and (country = 'Japan' OR country = 'Australia')

*/