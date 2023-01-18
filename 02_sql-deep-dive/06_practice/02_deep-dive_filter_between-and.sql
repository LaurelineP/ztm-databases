/*
    Practice - BETWEEN and AND

*/

-- Who between the ages of 30 and 50 has an income less than 50 000?
-- (include 30 and 50 in the results)
-- Response: 2362 customers

-- Selecting people with details
SELECT age, income
FROM customers
WHERE ( age BETWEEN 30 AND 50 ) AND income < 50000
ORDER BY income DESC;

-- Counting people: 2362 customers
SELECT count(customers.customerid)
FROM customers
WHERE ( age BETWEEN 30 AND 50 ) AND income < 50000;



-- What is the average income between the ages of 20 and 50? (Including 20 and 50)
-- Response: 59361.925908612832

SELECT AVG(income) FROM customers
WHERE age BETWEEN 20 AND 50;


-- Correction
/*

-- Who between the ages of 30 and 50 has an income less than 50 000?
-- (include 30 and 50 in the results)
SELECT *
FROM customers
WHERE age BETWEEN 30 AND 50 AND income < 50000;


-- What is the average income between the ages of 20 and 50? (Including 20 and 50)
SELECT AVG(income)
FROM customers
WHERE age BETWEEN 20 AND 50;

*/