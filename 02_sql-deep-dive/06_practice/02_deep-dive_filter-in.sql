/* Practice - Filter and IN - DB Store*/

/*
* DB: Store
* Table: orders
* Question: How many orders were made by customer 7888, 1082, 12808, 9623
*/


SELECT count(customerid) FROM orders
WHERE customerid IN (7888, 1082, 12808, 9623)



-- Correction: https://github.com/mobinni/Complete-SQL-Database-Bootcamp-Zero-to-Mastery/blob/master/SQL%20Deep%20Dive/IN/answers.sql

-- SELECT COUNT(orderid)
-- FROM orders
-- WHERE customerid IN (7888, 1082, 12808, 9623)