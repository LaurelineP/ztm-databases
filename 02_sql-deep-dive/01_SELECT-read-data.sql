-- 1. Get all employees 
-- SELECT * from employees              -- personnal implementation
-- SELECT * from "public" . "employees"    -- correction: with schema path implementation
-- SELECT * from "employees";               -- correction: without schema path implementation



-- 2. How many departments are there in the company ? (answer: 9)
SELECT count( * ) FROM "departments";       -- personnal implementation
-- SELECT * FROM "departments";         -- correction: without schema path + visualise 
                                    -- how many there are using GUI



-- 3. How manu times has employee 10001 had raise ? (answer: 17)
SELECT count("emp_no") FROM "salaries" WHERE "emp_no" = 10001; -- personnal implementation
-- SELECT * FROM "salaries";         -- correction: without schema path + counts 
                                    -- how many there are using GUI




-- 4. What title has 1006 ? (answer: Senior Engineer )
SELECT "title", "emp_no" FROM "titles" WHERE "emp_no" = 10006;
-- SELECT * FROM "titles";         -- correction: without schema path + check title 
                                -- using GUI

