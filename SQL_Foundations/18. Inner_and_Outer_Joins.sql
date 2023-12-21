-- MySQL

-- ------------------------------------------------------------------------------------------------
--  Inner and Outer Joins
-- ------------------------------------------------------------------------------------------------

	USE DemoDB;

-- Create  

	CREATE TABLE Dept(
		DeptID INT PRIMARY KEY,
		Name VARCHAR(50)
	); 

	CREATE TABLE Employee(
		EmpID INT PRIMARY KEY,
		Name VARCHAR(50),
		DeptID INT REFERENCES Dept
	); 

-- INSERT 

	-- Department Records

	INSERT INTO Dept VALUES(101, 'Inventory');
	INSERT INTO Dept VALUES(102, 'Sales');
	INSERT INTO Dept VALUES(103, 'HR');

	-- Employee Records
	
	INSERT INTO Employee VALUES(1, 'A', 101);
	INSERT INTO Employee VALUES(2, 'B', 102);
	INSERT INTO Employee VALUES(3, 'C', NULL);

-- Select

	SELECT * FROM Dept;
	SELECT * FROM Employee;

--  Inner join - Retrieves only matching Employee and Dept records

	SELECT * FROM Employee AS e
	INNER JOIN Dept AS d ON e.DeptID = d.DeptID;

-- Outer Join

-- 1. Left outer Join
-- Retrieves all employees irrespective of whether they have a matching department record or not.

	SELECT * FROM Employee AS e
	LEFT JOIN Dept AS d ON e.DeptID = d.DeptID;
 
 
-- 2. Right outer Join
-- Retrieves all department records irrespective of whether they have a matching department record or not.
 
	SELECT * FROM Employee AS e
	RIGHT JOIN Dept AS d ON e.DeptID = d.DeptID;
 
-- 3. Full outer Join	
-- Below query is valid in MS Sql Server; but not in MySql
-- SELECT * FROM Employee as e
-- FULL JOIN Dept as d ON e.DeptID = d.DeptID;
        
-- Full Join Simulation in MySQL
    
	SELECT * FROM Employee AS e
	LEFT JOIN Dept AS d ON e.DeptID = d.DeptID	
	UNION 
	SELECT * FROM Employee AS e
	RIGHT JOIN Dept AS d ON e.DeptID = d.DeptID;


-- Drop 

	DROP TABLE Employee;
	DROP TABLE Dept;
