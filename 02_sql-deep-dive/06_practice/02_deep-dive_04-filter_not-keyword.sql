/*
Practice - How many customers are not 55 yo?
*/

SELECT COUNT(age) FROM "public"."customers"
WHERE NOT age = 55;