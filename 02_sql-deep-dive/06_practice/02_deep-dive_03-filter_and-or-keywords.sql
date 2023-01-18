/* Practice - Filtering with OR and AND logical keyword operator
    - How many female customers are from Oregon or New York
*/

-- SELECT count(customerid) FROM "public"."customers"
-- WHERE gender = 'F' AND state = 'OR'
-- OR gender = 'F' AND state = 'NY'
-- 

SELECT count(customerid) FROM "public"."customers"
WHERE gender = 'F'
AND (state = 'OR' OR state = 'NY')

