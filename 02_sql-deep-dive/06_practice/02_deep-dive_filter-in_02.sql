/* Practice - Filter and IN - DB World */

/*
* DB: World
* Table: city
* Question: How many cities are in the district of Zuid-Holland, Noord-Brabant and Utrecht?
*/

-- Response: 12
SELECT count(city.id) FROM city
WHERE district IN ('Zuid-Holland', 'Noord-Brabant', 'Noord-Brabant', 'Utrecht' );

-- Correction: https://github.com/mobinni/Complete-SQL-Database-Bootcamp-Zero-to-Mastery/blob/master/SQL%20Deep%20Dive/IN/answers.sql

-- SELECT COUNT(id)
-- FROM city
-- WHERE district IN ('Zuid-Holland', 'Noord-Brabant', 'Utrecht');