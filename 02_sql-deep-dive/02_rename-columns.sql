--  See data through selecting all of them
-- SELECT * FROM "public" . "employees"


--  1. Rename 3 ( + extra one )first column headers [ emp_no, birth_date, first_name, last_name ]
SELECT
    emp_no AS "employeeRef",
    birth_date AS "birthDate",
    first_name AS "firstName",
    last_name AS "lastName"
FROM "public" . "employees";