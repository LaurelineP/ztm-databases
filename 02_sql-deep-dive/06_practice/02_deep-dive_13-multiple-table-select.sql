
/* -------------------------------------------------------------------------- */
/*                          MULTIPLE TABLE SELECT                             */
/* -------------------------------------------------------------------------- */
/* -------------------------------------------------------------------------- */
/*                               WHERE CLAUSE
    🔸 Multiple table selection is possible by chaining ( with a comma )
    the `FROM` clause with the tables names combined to their respective
    table alias.

    🔸 Regarding the columns to select: it should be declared with a dot 
    notation <TABLE ALIAS>.<COLUMN FIELD> for each fields required
    
    🔸 `WHERE` clause will check for the primary_key equality ( field in common 
    between both table ) - 📌 this avoids the query to assign values and make 
    duplicates

    This is commonly known as a basic approach to "join" the tables
    ( cf keyword JOIN that can do that : better practice ) 


    ```
        SELECT <TABLE_ALIAS_1>.<COLUMN>,  <TABLE_ALIAS_2>.<COLUMN>
        FROM <TABLE_1> AS <TABLE_ALIAS_1>, <TABLE_2> AS <TABLE_ALIAS_2>
        WHERE <COLUMN_PRIM_KEY> = <COLUMN_FOREIGN_KEY>
    ```

*/


SELECT a.emp_no, b.salary
FROM public.employees AS a, public.salaries AS b
WHERE a.emp_no = b.emp_no
ORDER BY a.emp_no;



/* -------------------------------------------------------------------------- */
/*                             JOIN: INNER JOIN
    🔸 Multiple table selection is possible using `INNER JOIN` too

    🔸 The order of the column import matters
    
    🔸 DB still not sorting them by default, `ORDER BY <COLUMN> [ ASC/DESC ]
    is recommanded

    This is the better approach to "join" the tables
*/

SELECT a.emp_no, b.salary
FROM public.employees AS a
INNER JOIN public.salaries AS b
ON a.emp_no = b.emp_no
ORDER BY a.emp_no ASC;

/* Bonus question - curvebale
    What is the employee salary but only the one that led to a new job title ? 
    Note: job salary changes after 2 days
*/
-- Attempt before head
SELECT a.emp_no, b.salary, TO_CHAR(b.from_date, 'DD/MM/YYYY') AS "promoted_on", c.title
FROM employees AS a
INNER JOIN salaries AS b ON a.emp_no = b.emp_no
INNER JOIN titles AS c
    ON b.emp_no = c.emp_no
    AND (
        c.from_date = b.from_date -- added to see original salary
        OR c.from_date = b.from_date + INTERVAL '2 days'
    ) -- changes after 2 days - mentioned later in video
ORDER BY a.emp_no ASC;

 --         Course approach 
 
 
SELECT a.emp_no, 
        CONCAT(a.first_name, ' ', a.last_name) AS "name",
        b.salary,
        COALESCE(c.title, 'No title change'),
        COALESCE(c.from_date::TEXT, '-') AS "title_taken_on"
FROM employees AS a
INNER JOIN salaries AS b ON a.emp_no = b.emp_no
INNER JOIN titles AS c 
    ON c.emp_no = a.emp_no
    AND (
        c.from_date = b.from_date
        OR c.from_date = b.from_date + INTERVAL '2 days'
    )
ORDER BY a.emp_no;

/* -------------------------------------------------------------------------- */
/*                             JOIN: SELF JOIN
    🔸 Sometimes a table hold both primary_key and foreign_key
    In those cases we could "self join" the table in order to refer to
    its own field
    Example on Note: Table with users for instance and supervisor
        the link would be the user id which is refered in supervisor

    -- Clasic Join with WHERE Clause
    SELECT a.id, a.name AS "employee", b.name AS "supervisor"
    FROM <TABLE_1> AS a, <TABLE_1> AS b
    WHERE a.supervisor_id = b.id


    -- Best practice Join: INNER JOIN
    SELECT a.id, a.name AS "employee", b.name AS "supervisor"
    FROM <TABLE_1> AS a INNER JOIN <TABLE_1> AS b
    ON a.supervisor_id = b.id

*/

/* -------------------------------------------------------------------------- */
/*                             JOIN: LEFT [ OUTER ] JOIN
    🔸 For Table that needs to join fields ( = columns ) not matching
    ( column that does not exist on the Table )

*/

SELECT a.emp_no, b.title
FROM employees AS a
LEFT JOIN dept_manager AS b
ON a.emp_no IN b.emp_no
WHERE b.emp_no IS NULL;



/* -------------------------------------------------------------------------- */
/* https://www.db-fiddle.com/f/dAb6mjWqWay6ECY1o2v478/0 */
/* -------------------------------------------------------------------------- */
/*           JOIN ( LESS COMMON ): CROSS JOIN - a.k.a Cartesian Product
    🔸 Purpose: join all records from a table into another table
    Syntax: 
        SELECT * FROM <TABLE1>
        CROSS JOIN <TABLE2>

*/
-- CREATE TABLE "cartesianA" (id INT);
-- CREATE TABLE "cartesianB" (id INT);

-- INSERT INTO "cartesianA" VALUES(1);
-- INSERT INTO "cartesianA" VALUES(2);
-- INSERT INTO "cartesianA" VALUES(3);

-- INSERT INTO "cartesianB" VALUES(1);
-- INSERT INTO "cartesianB" VALUES(2);
-- INSERT INTO "cartesianB" VALUES(3);

-- INSERT INTO "cartesianB" VALUES(4);
-- INSERT INTO "cartesianB" VALUES(5);
-- INSERT INTO "cartesianB" VALUES(6);

-- SELECT * FROM "cartesianA"
-- CROSS JOIN "cartesianB";



/* -------------------------------------------------------------------------- */
/*           JOIN ( LESS COMMON ): FULL OUTER JOIN - a.k.a Cartesian Product
    🔸 Purpose: Returns results from both tables wether they match or not
        in the combination ( include returning the NULL values)
    Syntax: 
        SELECT * FROM <TABLE1> as x
        FULL JOIN <TABLE2> as y

*/



/* -------------------------------------------------------------------------- */
/*           JOIN ( LESS COMMON ): FULL JOIN - a.k.a Cartesian Product
    🔸 Purpose: Returns results from both tables wether they match or not
        in the combination ( include returning the NULL values)
    Syntax: 
        SELECT * FROM <TABLE1>
        CROSS JOIN <TABLE2>

*/
SELECT * FROM "cartesianA" AS "a"
FULL JOIN "cartesianB" AS "b"
ON a.id = b.id;


/* -------------------------------------------------------------------------- */
/*                                      Practice                             */
-- Questions https://github.com/mobinni/Complete-SQL-Database-Bootcamp-Zero-to-Mastery/blob/master/SQL%20Deep%20Dive/Joins/Inner%20Join/questions.sql



/*
* DB: Store
* Table: orders
* Question: Get all orders from customers who live in Ohio (OH), New York (NY) or Oregon (OR) state
* ordered by orderid
*/

SELECT * FROM orders AS a
INNER JOIN customers AS b
    ON a.customerid = b.customerid AND (b.state = 'OR' OR b.state = 'NY' OR b.state = 'OH')
ORDER BY a.customerid ASC;



/*
* DB: Store
* Table: products
* Question: Show me the inventory for each product
*/

SELECT * FROM inventory AS i
INNER JOIN products AS p
    ON i.prod_id = p.prod_id
ORDER BY i.prod_id ASC;



/*
* DB: Employees
* Table: employees
* Question: Show me for each employee which department they work in
*/
SELECT * FROM employees AS e
INNER JOIN dept_emp AS d
    ON e.emp_no = d.emp_no
INNER JOIN departments AS dep
    ON dep.dept_no = dep.dept_no
ORDER BY e.emp_no ASC;

/* -------------------------------------------------------------------------- */
/*                              USING keyword
    🔸 Purpose: compare the primary key with its foreign key
    Syntax: 
        SELECT <PRIMARY/FOREIGN-KEY> FROM <TABLE1>
        INNER JOIN USING(<PRIMARY/FOREIGN-KEY-WITHOUT-ALIAS> )

*/
SELECT * FROM employees AS a
INNER JOIN dept_emp AS b USING(emp_no);