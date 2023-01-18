--                  TIMESTAMPS


/*
    1. Creates timezoens columns with:
        - ts: timestamp
        - tz: timezone
        then comment
*/
-- CREATE TABLE timezones (
--     ts TIMESTAMP WITHOUT TIME ZONE,
--     tz TIMESTAMP WITH TIME ZONE
-- )


/* 2. Add values into columns cells, then comment */
-- INSERT INTO timezones VALUES(
--     TIMESTAMP WITHOUT TIME ZONE '2000-01-01 10:00:00-05',
--     TIMESTAMP WITH TIME ZONE '2000-01-01 10:00:00-05'
-- )



/*  3. Check  */
SELECT * FROM timezones;
