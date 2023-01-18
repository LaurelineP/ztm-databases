-- Function
--   2 types:
--     AGGREGATE functions: take all the data and compute a single value
--      = operate on many records to produce 1 value > produces a summary
--     SCALAR functions: takes given inputs and applies it on each individual rows
--          CONCAT( <TEXT>, <TEXT> ) AS <NEW_COLUMN> to create a new column with the concatenation
--          Scalar(non-aggregate): operate on each record independently ( concat )
SELECT concat( "first_name", ' ' , "last_name" ) AS "fullName" FROM "public" . "employees"

