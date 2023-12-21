-- MySQL

-- ------------------------------------------------------------------------------------------------
--  Correlated Subqueries
-- ------------------------------------------------------------------------------------------------

USE DemoDB;
 
-- Create 
 
CREATE TABLE Dept(
    DeptID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    Location VARCHAR(50) NOT NULL
); 
 
CREATE TABLE Employee(
    EmpID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName  VARCHAR(50) NOT NULL,
    DeptID INT REFERENCES Dept,
    Salary NUMERIC(10,2) NOT NULL CHECK (Salary > 0)
); 
 
-- Sample Records 
 
INSERT INTO Dept(Name, Location) VALUES('Inventory', 'Loc1');
INSERT INTO Dept(Name, Location) VALUES('Sales', 'Loc2');
INSERT INTO Dept(Name, Location) VALUES('HR', 'Loc2');
 
-- When you are inserting master data and if you do not know the generated ID then the query could be used to get the 
-- generated ID and given as input to the insert.
-- Here the output of the select command is given as input for DeptID column value.
 
INSERT INTO Employee(FirstName, LastName, DeptID, Salary)
VALUES('A','A', (SELECT DeptID FROM Dept WHERE Name ='Inventory'), 11000);
 
INSERT INTO Employee(FirstName, LastName, DeptID, Salary)
VALUES('B','B', (SELECT DeptID FROM Dept WHERE Name ='Sales'), 12000);
 
INSERT INTO Employee(FirstName, LastName, DeptID, Salary)
VALUES('C','C', (SELECT DeptID FROM Dept WHERE Name ='HR'), 21000);
 
INSERT INTO Employee(FirstName, LastName, DeptID, Salary)
VALUES('D','D', (SELECT DeptID FROM Dept WHERE Name ='HR'), 22000);
 
-- Normal sub query and if you observe the subquery output is static i.e. it just returns the HR department ID and the same value could 
-- be used for the entire outer query. It is almost like select * from Employee where DeptID = 3;
 
SELECT * FROM Employee WHERE DeptId = (SELECT DeptId FROM Dept WHERE Name = 'HR');
 
-- Translation of above query using correlated subquery.
 
-- In case of this query the reference to e.DeptId is made which is an outer query column. 
-- And this column value changes for each record in the Employee table and hence the subquery need to be evaluated for each record. 
-- And this is slightly in efficient.
 
-- Here it the inner query check for the existence of a record with employees departmentId whose name is HR. 
-- If record exists then Employee record is selected otherwise not.
 
SELECT * FROM Employee AS e
WHERE 
EXISTS (SELECT * FROM Dept WHERE DeptId = e.DeptId AND Name = 'HR');
 
-- Translation using JOIN. Most of the times JOIN might turns out to be a better option.
 
SELECT e.* FROM Employee AS e
INNER JOIN Dept AS d ON (e.DeptId = d.DeptId AND d.Name = 'HR');

-- Drop

DROP TABLE Dept;
DROP TABLE Employee;