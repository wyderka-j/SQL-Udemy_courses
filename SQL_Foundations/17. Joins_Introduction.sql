-- MySQL

-- ------------------------------------------------------------------------------------------------
--  Joins Introduction
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
 
-- Sample records

-- Department Records
 
INSERT INTO Dept VALUES(101, 'Inventory');
INSERT INTO Dept VALUES(102, 'Sales');
 
-- Employee Records
	
INSERT INTO Employee VALUES(1, 'A', 101);
INSERT INTO Employee VALUES(2, 'B', 102);
INSERT INTO Employee VALUES(3, 'C', NULL);
 
 
-- Individual table queries.
 
SELECT * FROM Dept;
SELECT * FROM Employee;
 	
-- Cartesian product
 
SELECT * FROM Employee,Dept;
 
-- Cross Join to pick only those records whose DeptID matches.
 
SELECT * FROM Employee, Dept
WHERE Employee.DeptID = Dept.DeptID;
 	
-- Query with alias
 
SELECT * FROM Employee AS e, Dept AS d
WHERE e.DeptID = d.DeptID;
 
-- Same is achieved through INNER JOIN
 
SELECT * FROM Employee AS e
INNER JOIN Dept AS d ON e.DeptID = d.DeptID;

-- Drop 

DROP TABLE Employee;
DROP TABLE Dept;
