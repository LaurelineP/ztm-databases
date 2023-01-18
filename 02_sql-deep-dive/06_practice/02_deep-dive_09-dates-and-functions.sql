
--          DATES & BUILT-IN DATE FUNCTIONS & MANIPULATIONS

/* 1. Get current date */
SELECT NOW()::date; --> 2023-01-10
SELECT CURRENT_DATE; --> 2023-01-10

/* 2. Format a date */
SELECT TO_CHAR(CURRENT_DATE, 'DD/MM/YYYY'); --> 10/01/2023


/* Calculate Date difference */
-- Substraction with date string
SELECT NOW()::date - '1800/01/01'; --> 81458


/* Define a date value string as a date data type */
SELECT date '2023/01/01'; --> 2023-01-01


/* Get Age from date */
SELECT AGE('1962-05-07'::date); --> 60 years 8 mons 3 days


/* Calculate age between two dates */
SELECT AGE('1962-05-07'::date, '2022-03-08'::date);  --> -60 years -1 days
SELECT AGE( date '2022-03-08', date '1962-05-07');  --> 59 years 10 mons 1 days


/* Extract a day */
SELECT EXTRACT ( DAY FROM date '1992-07-05') AS DAY; --> 5
SELECT EXTRACT ( MONTH FROM date '1992-07-05') AS MONTH; --> 7
SELECT EXTRACT ( YEAR FROM date '1992-07-05') AS YEAR; --> 1992


/* Round down a date */
SELECT DATE_TRUNC('year', date '1992/11/13'); --> 1992-01-01 00:00:00+00
SELECT DATE_TRUNC('month', date '1992/11/13'); --> 1992-11-01 00:00:00+00
SELECT DATE_TRUNC('day', date '1992/11/13'); --> 1992-11-13 00:00:00+00


/* Interval */
SELECT * FROM orders
WHERE orderdate <= NOW() - INTERVAL '30 days'
LIMIT 3;

-- Exctracting from an interval
SELECT
    EXTRACT (
        YEAR
        FROM
            INTERVAL '24 months'
); --> 2

