-- MySQL

USE SQL_101;

-- Selecting info from a table

SELECT * FROM attendees;

SELECT * FROM avgsalary;

-- Calcutation on culumns

SELECT *, assets/salary AS frugalmeasure
FROM attendees
ORDER BY frugalmeasure desc;

-- Subquery example

-- Select Superhero from cities where avg salary is greater than 10000 (Using Correlated Subquery)

SELECT * 
FROM   attendees 
WHERE  city IN (SELECT city 
                FROM   avgsalary 
                WHERE  avgsalary > 10000); 

-- Remainder function Mod example
-- Get even persinID 

SELECT *
FROM   attendees
WHERE  Mod(personid, 2) = 0;

-- Concatenating two columns of string type

SELECT *, 
       CONCAT(heroname, ' ', sector) 
FROM attendees;

-- Casting number to Character for string concatenation

SELECT * ,
CONCAT (CAST(assets/1000 as CHAR), 'k') Assetsink
FROM attendees;

-- Case statement to display Queens and Others by checking each value

SELECT heroname,
CASE
   WHEN city = "Q" THEN "Queens"
    ELSE "Other City"
END
FROM attendees;

-- GROUP BY

-- Example 1:

SELECT Sector, AVG(age) 
FROM Attendees
GROUP BY Sector;

-- Example 2:

SELECT Sector, MAX(assets)  
FROM Attendees
GROUP BY Sector;

-- Adding order by in the group by statement

SELECT Sector, AVG(Assets) 
FROM attendees
GROUP BY Sector
HAVING AVG(Assets) >400000
ORDER BY AVG(Assets) DESC;

-- Complete group by including having command

SELECT AVG(salary), sector
FROM attendees
WHERE age > 35 
GROUP BY sector
HAVING AVG(salary) > 11500;

SELECT AVG(salary), sector
FROM attendees
WHERE age > 35 AND age < 150
GROUP BY sector
HAVING AVG(salary) > 11500;

-- Show an example with Having, Where and Order by in the same query

SELECT sector, 
       Avg(assets) 
FROM   attendees 
WHERE  age > 18 
GROUP  BY sector 
HAVING Avg(assets) > 400000 
ORDER  BY Avg(assets); 

-- Use IN command to pass in the list/array of cities

SELECT * 
FROM   attendees 
WHERE  city IN ( 'B', 'M', 'Q' ); 

-- Find Hero with highest assets

SELECT * 
FROM   attendees 
WHERE  assets IN (SELECT MAX(assets) 
                  FROM   attendees); 

-- Value (now not the row) of the 2nd highest asset:

SELECT Max(assets) 
FROM   attendees 
WHERE  assets Not IN (SELECT MAX(assets) 
                  FROM   attendees); 

-- Heroname containing the string man
SELECT * 
FROM   attendees 
WHERE  heroname LIKE '%man%'; 


-- JOINS

-- This is for SQL server as Full outer join not supported in MySQL
/*
select *
from attendees
full outer join avg
salary on attendees.city = avgsalary.city2
*/

-- Below works with MYSQL

SELECT *
FROM attendees
INNER JOIN avgsalary ON attendees.city = avgsalary.city2;

-- Creating Alias and then joining

SELECT * 
FROM ( SELECT * FROM Attendees 
	WHERE Age>60 ) AS A
JOIN Avgsalary ON A.City = Avgsalary.City2;

-- Union stacks one table below the other

SELECT * FROM Avgsalary
UNION ALL
SELECT * FROM Avgsalary2;

-- First Group by City to find avg salary and then join with avg salary to compare avg salary of people who attended the session 

SELECT asal, 
       city 
FROM   (SELECT Avg(salary) AS ASal, 
               city 
        FROM   attendees 
        GROUP  BY city) AS T 
       JOIN avgsalary 
         ON avgsalary.city2 = T.city;

-- First Join and then group by avgsalary:

SELECT Avg(avgsalary), 
       sector 
FROM   Attendees 
       JOIN Avgsalary 
         ON Avgsalary.City2 = Attendees.City 
GROUP  BY sector;
