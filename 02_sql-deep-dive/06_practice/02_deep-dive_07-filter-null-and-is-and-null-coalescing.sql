/*
* Pratice
* DB: https://www.db-fiddle.com/f/PnGNcaPYfGoEDvfexzEUA/0
* Question: 
* Assuming a students minimum age for the class is 15, what is the average age of a student?
* Reponse: 30.4000000000000000
*/
SELECT AVG(COALESCE(age, 15)) FROM "Student";

/*
* DB: https://www.db-fiddle.com/f/PnGNcaPYfGoEDvfexzEUA/0
* Question: 
* Replace all empty first or last names with a default?
Reponse: 
*/
SELECT COALESCE(name, lastname, 'unknown') AS "_any_name" FROM "Student";

SELECT *, COALESCE(name, 'unknown'), COALESCE(lastname, 'unknown') FROM "Student";

-- Correction: https://github.com/mobinni/Complete-SQL-Database-Bootcamp-Zero-to-Mastery/blob/master/SQL%20Deep%20Dive/Null%20Values/answers.sql