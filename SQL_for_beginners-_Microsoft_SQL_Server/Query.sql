USE SchoolDB;

-- Selecting data from multiple tables

-- INNER JOIN

-- Select the list of students who have courses and which course they having
SELECT *
FROM Table_Student
INNER JOIN Table_StudentCourse
ON Table_Student.StudentID = Table_StudentCourse.StudentID;

-- SQL Alias
SELECT *, (FirstName + ' ' + LastName) AS FullName
FROM Table_Student;

SELECT *
FROM Table_Student AS s
INNER JOIN Table_StudentCourse AS sc
ON s.StudentID = sc.StudentID;

--RIGHT OUTER JOIN
SELECT *
FROM Table_StudentCourse AS sc
RIGHT OUTER JOIN Table_Student AS s
ON s.StudentID = sc.StudentID
ORDER BY FirstName;

-- LEFT OUTER JOIN
SELECT *
FROM Table_Student AS s
LEFT OUTER JOIN Table_StudentCourse AS sc
ON s.StudentID = sc.StudentID;

-- FULL OUTER JOIN
SELECT *
FROM Table_Student AS s
FULL OUTER JOIN Table_StudentCourse AS sc
ON s.StudentID = sc.StudentID;

-- Sub-queries
SELECT s.StudentID, s.FirstName, s.LastName, g.Name AS Gender, s.BirthDate, s.EmailAddress, s.Address
FROM Table_Student AS s
INNER JOIN Table_Gender AS g
ON s.GenderID = g.GenderID;


SELECT StudentID, FirstName, LastName, 
	(SELECT Name FROM Table_Gender AS g WHERE s.GenderID = g.GenderID) AS Gender, 
	BirthDate, EmailAddress, Address
FROM Table_Student AS s;

-- CASE
SELECT FirstName, BirthDate, 
	CASE GenderID WHEN 1 THEN 'Male'
				  WHEN 2 THEN 'Female'
				  WHEN 3 THEN 'Rather not say'
				  ELSE 'Unknown'
	END AS Gender
FROM Table_Student;

-- Filtering data

-- TOP N
-- Top 3 youngest students
SELECT TOP 3 *
FROM Table_Student
ORDER BY BirthDate DESC;

-- DISTINCT
SeLECT DISTINCT GenderID
FROM Table_Student;

-- IN and NOT IN
SELECT *
FROM Table_Student
WHERE StudentID = 2 OR StudentID = 4 OR StudentID = 10;

SELECT *
FROM Table_Student
WHERE StudentID IN (2, 4, 10);

SELECT *
FROM Table_Student
WHERE StudentID NOT IN (2, 4, 10);

-- NULL and NOT NULL
-- list of students who does not have any course
SELECT *
FROM Table_Student AS s
LEFT OUTER JOIN Table_StudentCourse AS sc
ON s.StudentID = sc.StudentID
WHERE sc.StudentCourseID IS NULL;

-- list of students who have a course
SELECT *
FROM Table_Student AS s
LEFT OUTER JOIN Table_StudentCourse AS sc
ON s.StudentID = sc.StudentID
WHERE sc.StudentCourseID IS NOT NULL;

-- LIKE
-- students with name started on letter S
SELECT *
FROM Table_Student
WHERE FirstName LIKE 'S%';

SELECT *
FROM Table_Student
WHERE FirstName LIKE 'S%' AND MiddleName LIKE 'A%';

-- all students with yahoo email
SELECT *
FROM Table_Student
WHERE EmailAddress LIKE '%yahoo%';

-- BETWEEN and NOT BETWEEN
SELECT *
FROM Table_Student
WHERE StudentID >= 4 AND StudentID <= 12;

SELECT *
FROM Table_Student
WHERE StudentID BETWEEN 4 AND 12;

-- Aggregating data

-- GROUP BY
SELECT GenderID
FROM Table_Student
GROUP BY GenderID;

-- COUNT
SELECT GenderID, COUNT(GenderID) AS NumberOfStudents
FROM Table_Student
GROUP BY GenderID;

-- SUM
SELECT s.StudentID, (FirstName + ' ' + LastName) AS FullName, SUM(CreditHour) AS TotalCreditHour
FROM Table_Student AS s
INNER JOIN Table_StudentCourse sc
	ON s.StudentID = sc.StudentID
INNER JOIN Table_Course AS c
	ON sc.CourseCode = c.CourseCode
GROUP BY s.StudentID, (FirstName + ' ' + LastName)
ORDER BY TotalCreditHour DESC;

--  MIN and MAX
-- the youngers student
SELECT TOP 1 *
FROM Table_Student
ORDER BY BirthDate DESC;

SELECT MAX(BirthDate)
FROM Table_Student;

-- list of all students exept the youngest one
SELECT  *
FROM Table_Student
WHERE BirthDate < (SELECT MAX(BirthDate) FROM Table_Student);

-- HAVING
-- all the students with their credit hours and only those students whose credit is greater than 5
SELECT s.StudentID, FirstName, SUM(CreditHour) AS TotalCreditHour
FROM Table_Student AS s
INNER JOIN Table_StudentCourse sc
	ON s.StudentID = sc.StudentID
INNER JOIN Table_Course AS c
	ON sc.CourseCode = c.CourseCode
GROUP BY s.StudentID, FirstName
HAVING SUM(CreditHour) > 5;

-- Set operations

-- UNION and UNION ALL
SELECT TOP 5 *
FROM Table_Student
WHERE GenderID = 1
UNION
SELECT TOP 5 *
FROM Table_Student
WHERE GenderID = 2;


SELECT *
FROM Table_Student
WHERE BirthDate <= '1984-11-24'
UNION 
SELECT *
FROM Table_Student
WHERE GenderID =1;

SELECT *
FROM Table_Student
WHERE BirthDate <= '1984-11-24'
UNION ALL
SELECT *
FROM Table_Student
WHERE GenderID =1;

-- INTERSECT
SELECT *
FROM Table_Student
WHERE BirthDate <= '1984-11-24'
INTERSECT
SELECT *
FROM Table_Student
WHERE GenderID =1;

-- join the result of the two requests, select all female students, select top 6 male students
SELECT *
FROM Table_Student
WHERE GenderID = 2
UNION 
SELECT TOP 6 *
FROM Table_Student
WHERE GenderID = 1;