-- BEFORE YOU START
/*
 * What database should I use for these exercises?
 * Name: Employees
 */
-- 
-- ✅✨ Question 1: What is the average salary for the company? --> 63810.744836143706
-- Table: Salaries
-- SELECT AVG(salary) FROM salaries;


-- ❌ Question 2: What year was the youngest person born in the company? --> 1952-02-01 --> 1952 
-- Table: employees
-- SELECT MIN(birth_date) FROM employees;
-- 📝 Correction : SELECT MAX(birth_date) FROM employees; -- Result: 1965-02-01





/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
-- BEFORE YOU START
/*
 * What database should I use for these exercises?
 * Name: France
 */
-- 

-- ✅ Question 1: How many towns are there in france? --> 36684
-- Table: Towns
-- Select COUNT(towns) FROM "public"."towns"
-- 📝 --> select count(id) from towns;


-- BEFORE YOU START
/*
 * What database should I use for these exercises?
 * Name: World
 */
-- "public"."countrylanguage"

-- ✅ Question 1: How many official languages are there? --> 238 official / 984 non official
-- Table: countrylanguage
-- SELECT COUNT(language) FROM countrylanguage WHERE isofficial = TRUE;
-- 📝 --> select count(countrycode) from countrylanguage where isofficial = true;


-- ✅✨ Question 2: What is the average life expectancy in the world? --> 66.486
-- Table: country
-- SELECT AVG(lifeexpectancy) FROM country 


-- ✅✨  Question 3: What is the average population for cities in the netherlands?
-- Table: city
SELECT AVG(population) FROM city WHERE countrycode = 'NLD'
