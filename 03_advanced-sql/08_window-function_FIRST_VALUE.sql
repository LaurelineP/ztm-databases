/* -------------------------------------------------------------------------- */
/*                       WINDOW FUNCTION - `FIRST_VALUE`                      */
/* -------------------------------------------------------------------------- */
/*
    "Returns a value evaluated against the first row within its partion"
*/

--  
/*  QUESTION: For each product, what's the current price --> compares to same category lowest price'
    - Partition ===> look at prices by category
    - Range ===> taking into account all values before and after the current record
    - --> to get the FIRST_VALUE when ordered by price
    Note: using window function + LAST_VALUE
*/
-- ❌ Personal anticipation
SELECT prod_id, category, price,
    FIRST_VALUE(price) OVER(
        PARTITION BY category
        RANGE 
            BETWEEN UNBOUNDED PRECEDING
            AND UNBOUNDED FOLLOWING

    ) AS "lowest price for its category"
    FROM products ORDER BY category;
    
    
-- ✅ Personal anticipation adjustments
--     - missing in window function ORDER BY
-- ( getting the first value from category but not ordered 
-- will not get the smallest price but just the first record price value in this category )
SELECT prod_id, category, price,
    FIRST_VALUE(price) OVER(
        PARTITION BY category
        ORDER BY price
        RANGE 
            BETWEEN UNBOUNDED PRECEDING
            AND UNBOUNDED FOLLOWING

    ) AS "lowest price for its category"
    FROM products ORDER BY category;
    
-- Course query solution/explanation
SELECT prod_id,
    price,
    category,
    FIRST_VALUE(price) OVER(
        PARTITION BY category   -- = group by categoy
        ORDER BY price          -- order by price to get the sorted prices
        /* ✅ (tested)
            The following range window is not mandatory 
            as by default the range window will evaluate all
            preceding and following record */
--         RANGE BETWEEN UNBOUNDED PRECEDING
--         AND UNBOUNDED FOLLOWING
    ) AS "cheapest in category"
    FROM products;
    
    
-- Course alternative query solution/explanation without using LAST_VALUE
SELECT prod_id, price, category,
    MIN(price) OVER(
        PARTITION BY category
        /* by default: applied to all records */
    )
    FROM products;
    
/*
    In a bigger picture LAST_VALUE is not necessarily the worth or best approach
    as alternatives may also output the right solution
    As long as it outputs the correct solution ( trying to check yourself
    the data to have an hint wether it fits the expected solution or not )
*/

