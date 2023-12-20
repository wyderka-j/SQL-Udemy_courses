-- MySQL

-- ------------------------------------------------------------------------------------------------
--  Referential Integrity
-- ------------------------------------------------------------------------------------------------

USE DemoDB;
 
-- Create  
 
CREATE TABLE Dept (
    DeptID   INT PRIMARY KEY,
    Name     VARCHAR(50),
    Location VARCHAR(50)
); 
 
CREATE TABLE Employee(
    EmpID 	INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName  VARCHAR(50),
    DeptID 	INT,
    Salary 	NUMERIC(10,2),
	CONSTRAINT fk_DeptID FOREIGN KEY(DeptID) REFERENCES Dept(DeptId)
); 
 
 
-- Sample Department Records
 
INSERT INTO Dept
VALUES(101, 'Inventory', 'Loc1');
 
INSERT INTO Dept
VALUES(102, 'Sales', 'Loc2');
 
-- Sample Employee Records
	
INSERT INTO Employee
VALUES(1, 'A','A', 101, 11000);
 
INSERT INTO Employee
VALUES(2, 'B','B', 102, 12000);
 
-- NULL value for DeptID is allowed in Employee table because foreign key allows NULL values.
-- If there is a need to restrict NULL values then you can apply NOT NULL constraint for DeptID column in Employee. 
 
INSERT INTO Employee
VALUES(3, 'C','C', NULL, 21000);
 
INSERT INTO Employee
VALUES(4, 'D','D', 102, 22000);
 
-- Below insert will fail because 103 is not an existing DeptID in Dept table.
 
INSERT INTO Employee
VALUES(4, 'D','D', 103, 22000);
 
-- Select
 
SELECT * FROM Dept;
SELECT * FROM Employee;
 
 
-- While dropping tables or deleting records, we first need to delete the referencing entries before deleting the referred entries.
 
DROP TABLE Employee;
DROP TABLE Dept;