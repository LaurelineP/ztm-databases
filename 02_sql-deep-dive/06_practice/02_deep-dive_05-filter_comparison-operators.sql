-- How many female customers do we have from the state of Oregon (OR)?
-- Result --> 106
SELECT COUNT("customerid") FROM "public"."customers"
WHERE state = 'OR' AND gender = 'F';


-- Who over the age of 44 has an income of 100 000 or more?
-- Result --> 2497
SELECT COUNT("customerid") FROM "public"."customers"
WHERE age > 44 AND income >= 100000;


-- Who between the ages of 30 and 50 has an income of less than 50 000?
-- Result --> 1452
SELECT COUNT("customerid") FROM "public"."customers"
WHERE age >= 30 AND age <= 50 AND income < 50000;



-- What is the average income between the ages of 20 and 50? (Excluding 20 - 50)
-- Result --> 59375.602700096432
SELECT AVG(income) FROM "public"."customers"
WHERE age >= 20 AND age < 50;
