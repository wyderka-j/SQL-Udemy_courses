-- Microsoft SQL Server 

USE AdventureWorks2014;

-- Show all the department names
SELECT Name 
FROM HumanResources.Department;

-- Show all the groups
SELECT GroupName 
FROM HumanResources.Department;

-- Show all distinct group names
SELECT DISTINCT GroupName 
FROM HumanResources.Department;

-- Show all the department names who are part of manufacturing
SELECT Name, GroupName
FROM HumanResources.Department
WHERE GroupName LIKE 'Manufacturing';

-- Show all the employees from the employee table
SELECT *
FROM HumanResources.Employee;

-- Show all employees who have OrganizationLevel = 2
SELECT *
FROM HumanResources.Employee
WHERE OrganizationLevel = 2;

-- Show all employees who have OrganizationLever = 2 or 3
SELECT *
FROM HumanResources.Employee
WHERE OrganizationLevel IN (2,3);

-- Show employees who have a title as  Facilities Manager
SELECT *
FROM HumanResources.Employee
WHERE JobTitle LIKE 'Facilities Manager';

-- Show employees who have a word Manager in their title
SELECT *
FROM HumanResources.Employee
WHERE JobTitle LIKE '%Manager%';

-- Show employees who are born after 1 Jan 1980
SELECT *
FROM HumanResources.Employee
WHERE BirthDate > '1980-01-01';

-- Show employees who are born between 1 Jan 1970 and 1 Jan 1980
SELECT *
FROM HumanResources.Employee
WHERE BirthDate >= '1970-01-01' AND BirthDate <= '1980-01-01';

SELECT *
FROM HumanResources.Employee
WHERE BirthDate BETWEEN '1970-01-01' AND '1980-01-01';

-- Calculated columns
SELECT * 
FROM Production.Product;

-- Show names, listPrice and increased listPrice by 10
SELECT Name, ListPrice, ListPrice + 10 AS Adjusted_list_price
FROM Production.Product;

-- Into
-- Create new table using columns names, listPrice and increased listPrice by 10 from Product
SELECT Name, ListPrice, ListPrice + 10 AS Adjusted_list_price
INTO Production.Product_2
FROM Production.Product;

SELECT *
FROM Production.Product_2;

-- temporary table
SELECT Name, ListPrice, ListPrice + 10 AS Adjusted_list_price
INTO #tmpname
FROM Production.Product;

SELECT *
FROM #tmpname;

-- delete data from table
DELETE FROM Production.Product_2
WHERE Name LIKE 'Bearing Ball';

-- Update
-- Update name Blade to Blade_New in table Product_2
UPDATE Production.Product_2
SET Name = 'Blade_New'
WHERE Name LIKE 'Blade';

------------------------------------------------
-- JOINS
------------------------------------------------

-- 
CREATE TABLE MyEmployee(
	EmployeeID INT,
	FirstName VARCHAR(20),
	LastName VARCHAR(20)
);


INSERT INTO MyEmployee 
VALUES (1, 'Michael', 'Scott'),
	   (2, 'Pam', 'Beesly'),
	   (3, 'Dwight', 'Schrute');

SELECT * FROM MyEmployee;

CREATE TABLE MySalary(
	EmployeeID INT,
	Salary FLOAT
);

INSERT INTO MySalary 
VALUES (1, 10000),
	   (2, 8000),
	   (3, 6000);

SELECT * FROM MySalary;

-- Show employees with salaries
SELECT e.FirstName, e.LastName, s.Salary
FROM MyEmployee AS e
INNER JOIN MySalary AS s
ON e.EmployeeID = s.EmployeeID;

-- left outer join 
CREATE TABLE MyPhone(
	EmployeeID INT,
	PhoneNumber INT
);

INSERT INTO MyPhone 
VALUES (1, 1211123342),
	   (2, 1111111111);

-- Show all employees and phone numbers from another table
SELECT e.FirstName, e.LastName, p.PhoneNumber
FROM MyEmployee AS e
LEFT JOIN MyPhone AS p
ON e.EmployeeID = p.EmployeeID;

-- right outer join
CREATE TABLe MyParking(
	EmployeeID INT,
	ParkingSpot VARCHAR(20)
);

INSERT INTO MyParking
VALUES (1, 'a1'),
	   (2, 'a2');

-- Show parking space and all employee names from another table
SELECT pa.ParkingSpot, e.FirstName, e.LastName
FROM MyParking AS pa
RIGHT JOIN MyEmployee AS e
ON pa.EmployeeID = e.EmployeeID;

-- full outer join
CREATE TABLE MyCustomer(
	CustomerID INT,
	CustomerName VARCHAR(20)
);	

INSERT INTO MyCustomer
VALUES (1, 'Rakesh'),
	   (2, 'John'),
	   (3, 'Jane');

CREATE TABLE MyOrder(
	OrderNumber INT,
	OrderName VARCHAR(20),
	CustomerID INT
);	

INSERT INTO MyOrder
VALUES (1, 'SomeOrder1', 1),
	   (2, 'SomeOrder2', 2),
	   (3, 'SomeOrder3', 7),
	   (4, 'SomeOrder4', 8);

-- Show all customers and all orders
SELECT c.CustomerID, c.CustomerName, o.OrderNumber, o.OrderName
FROM MyCustomer AS c
FULL OUTER JOIN MyOrder AS o
ON c.CustomerID = o.CustomerID;

-- cross join
SELECT *
FROM MyCustomer
CROSS JOIN MySalary;

------------------------------------------------
-- Functions
------------------------------------------------

-- Date functions

-- Show current date
SELECT GETDATE();

-- Show the date two days ago
SELECT GETDATE()-2;

-- Datepart
-- Show only year
SELECT DATEPART(yyyy, GETDATE()) AS Year;

-- Show only month
SELECT DATEPART(MM, GETDATE()) AS Month;

-- Show only day
SELECT DATEPART(DD, GETDATE()) AS Day;

-- Dateadd
-- Show date in four days
SELECT DATEADD(day, 4, GETDATE());


--
SELECT WorkOrderID, ProductID, StartDate, EndDate, DATEDIFF(day, StartDate,EndDate)
FROM Production.WorkOrder;


-- Show first day of this month
SELECT (DATEADD(dd, -(DATEPART(day, GETDATE()) - 1), GETDATE()));


-- Functions
SELECT * FROM MySalary;

--Aggragate Functions
-- average
SELECT AVG(Salary) FROM MySalary;
-- number of salaries
SELECT COUNT(Salary) FROM MySalary;
-- number of all rows
SELECT COUNT(*) FROM MySalary;
-- sum
SELECT SUM(Salary) FROM MySalary;
-- minimum 
SELECT MIN(Salary) FROM MySalary;
-- maximum salary
SELECT MAX(Salary) FROM MySalary;


--String functions
SELECT * FROM MyOrder;

-- CONCAT
SELECT OrderNumber, OrderName, CONCAT(OrderName, ' ' , OrderName) AS ConcatenatedText 
FROM MyOrder;

--RAND()
SELECT OrderNumber, OrderName, CONCAT(OrderName, ' ' , RAND(5))  AS ConcatenatedText 
FROM MyOrder;

--LEFT
SELECT OrderNumber, OrderName, LEFT(OrderName, 5) 
FROM MyOrder;

--RIGHT
SELECT OrderNumber, OrderName, RIGHT(OrderName, 5) 
FROM MyOrder;

--SUBSTRING
SELECT OrderNumber, OrderName, SUBSTRING(OrderName, 2, 5) 
FROM MyOrder;

--LOWERCASE
SELECT OrderNumber, OrderName, LOWER(OrderName) 
FROM MyOrder;

--UPPERCASE
SELECT OrderNumber, OrderName, UPPER(OrderName) 
FROM MyOrder;

--LENGHT OF STRING
SELECT OrderNumber, OrderName, LEN(OrderName) 
FROM MyOrder;

SELECT OrderNumber, OrderName, CONCAT(UPPER(LEFT(OrderName, 1)), LOWER(SUBSTRING(OrderName, 2, LEN(OrderName)))) 
FROM MyOrder;

--TRIM 
SELECT '   MyText    ';
SELECT LEN('   MyText    ');

SELECT LTRIM('   MyText    ');
SELECT RTRIM('   MyText    ');
SELECT TRIM('   MyText    ');
