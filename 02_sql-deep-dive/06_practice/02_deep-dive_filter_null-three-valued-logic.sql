
/*
* DB: Store
* Table: customers
* Question: adjust the following query to display the null values as "No Address"
*/
-- SELECT address2 
-- FROM customers

-- Response:
SELECT *, COALESCE(address2, 'No Address')
FROM customers;




/*
* DB: Store
* Table: customers
* Question: Fix the following query to apply proper 3VL
*/
-- SELECT *
-- FROM customers
-- WHERE COALESCE(address2, null) IS NOT null;

-- Response:
SELECT *
FROM customers
WHERE address2 IS NOT NULL;
-- 


-- Correction: https://github.com/mobinni/Complete-SQL-Database-Bootcamp-Zero-to-Mastery/blob/master/SQL%20Deep%20Dive/3%20Valued%20Logic%20Exercises/answers.sql



/*
* DB: Store
* Table: customers
* Question: Fix the following query to apply proper 3VL
*/
-- SELECT coalesce(lastName, 'Empty'), * from customers
-- where (age = null);

-- Response:
SELECT COALESCE(lastName, 'Empty'), * FROM customers
WHERE (age IS NULL);