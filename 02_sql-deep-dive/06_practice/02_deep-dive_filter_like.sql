-- Practice

/*
* DB: Employees
* Table: employees
* Question: Find the age of all employees who's name starts with M.
* Sample output: https://imgur.com/vXs4093
* Use EXTRACT (YEAR FROM AGE(birth_date)) we will learn about this in later parts of the course
Result:✅
*/
-- SELECT emp_no, EXTRACT (YEAR FROM AGE(birth_date)) as "age", first_name  FROM employees
-- WHERE first_name ILIKE 'M%';


/*
* DB: Employees
* Table: employees
* Question: How many people's name start with A and end with R?
* Expected output: 1846
Result: 1846  ✅ ( with firstname )
*/
-- SELECT COUNT(emp_no) FROM employees
-- WHERE  first_name ILIKE 'A%R';

                                                  
/*
* DB: Store
* Table: customers
* Question: How many people's zipcode have a 2 in it?.
* Expected output: 4211 
Response: ✅
*/
-- SELECT COUNT(zip) FROM customers
-- WHERE zip::text ILIKE '%2%';


/*
* DB: Store
* Table: customers
* Question: How many people's zipcode start with 2 with the 3rd character being a 1.
* Expected output: 109
    Result: ✅
*/
-- SELECT COUNT(zip) FROM customers
-- WHERE CAST(zip AS text) ILIKE '2_1%';


/*
* DB: Store
* Table: customers
* Question: Which states have phone numbers starting with 302?
* Replace null values with "No State"                                                  
* Expected output: https://imgur.com/AVe6G4c
Result: ✅
*/
-- SELECT coalesce(state, 'No State'), phone AS text FROM customers
-- WHERE phone LIKE '302%';


/* ------------------------------- CORRECTION ------------------------------- */
-- https://github.com/mobinni/Complete-SQL-Database-Bootcamp-Zero-to-Mastery/blob/master/SQL%20Deep%20Dive/Like%20Operator/answers.sql
-- /*
-- * DB: Employees
-- * Table: employees
-- * Question: Find the age of all employees who's name starts with M.
-- * Sample output: https://imgur.com/vXs4093
-- */

-- SELECT emp_no, first_name, EXTRACT (YEAR FROM AGE(birth_date)) as "age" FROM employees
-- WHERE first_name ILIKE 'M%';

-- /*
-- * DB: Employees
-- * Table: employees
-- * Question: How many people's name start with A and end with R?
-- * Expected output: 1846
-- */

-- SELECT count(emp_no) FROM employees
-- WHERE first_name ILIKE 'A%R';
                                                  
-- /*
-- * DB: Store
-- * Table: customers
-- * Question: How many people's zipcode have a 2 in it?.
-- * Expected output: 4211 
-- */

-- SELECT count(customerid) FROM customers
-- WHERE zip::text LIKE '%2%';


-- /*
-- * DB: Store
-- * Table: customers
-- * Question: How many people's zipcode start with 2 with the 3rd character being a 1.
-- * Expected output: 109 
-- */

-- SELECT count(customerid) FROM customers
-- WHERE zip::text LIKE '2_1%';

-- /*
-- * DB: Store
-- * Table: customers
-- * Question: Which states have phone numbers starting with 302?
-- * Replace null values with "No State"                                                  
-- * Expected output: https://imgur.com/AVe6G4c
-- */

-- SELECT coalesce(state, 'No State') as "State" FROM customers
-- WHERE phone::text LIKE '302%';