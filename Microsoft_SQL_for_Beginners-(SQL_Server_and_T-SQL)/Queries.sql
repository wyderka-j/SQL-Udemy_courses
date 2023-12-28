-- Microdoft SQL Server

USE AdventureWorksDW2017;

-- Basic SQL Syntax and Select

-- Select all
SELECT * FROM DimAccount;

-- Selected columns
SELECT AccountKey, AccountDescription
FROM DimAccount;

-- Aliases
SELECT AccountKey AS AK, AccountDescription AS AD
FROM DimAccount;

-- Select Distinct
SELECT DISTINCT AccountType
FROM DimAccount;

-- Where Clause
SELECT *
FROM FactInternetSales
WHERE OrderDate = '2010-12-29 00:00:00.000';

SELECT *
FROM FactInternetSales
WHERE OrderDate > '2010-12-29 00:00:00.000';

-- And, Or, Not
SELECT *
FROM FactInternetSales
WHERE CurrencyKey = 19 AND PromotionKey = 2;

SELECT *
FROM FactInternetSales
WHERE CurrencyKey = 19 OR CurrencyKey = 39;

SELECT *
FROM FactInternetSales
WHERE (CurrencyKey = 19 OR CurrencyKey = 39) AND PromotionKey = 2;

SELECT *
FROM FactInternetSales
WHERE CurrencyKey != 19;

-- Order By
SELECT FirstName, LastName
FROM DimEmployee
ORDER BY FirstName, LastName;

SELECT FirstName, LastName
FROM DimEmployee
ORDER BY FirstName DESC, LastName DESC;

-- Top
SELECT TOP 5 FirstName, LastName
FROM DimEmployee
ORDER BY FirstName, LastName;

-- Select top 50 product where the color is black and order by english product name 
SELECT TOP 50 *
FROM DimProduct
WHERE Color = 'Black'
ORDER BY EnglishProductName;

-- Max and Min
SELECT MAX(StandardCost) AS StandardCost
FROM DimProduct
WHERE StandardCost IS NOT NULL;

SELECT MIN(StandardCost) AS StandardCost
FROM DimProduct
WHERE StandardCost IS NOT NULL;

-- Like
SELECT *
FROM DimCurrency
WHERE CurrencyAlternateKey LIKE 'AFA';

SELECT *
FROM DimCurrency
WHERE CurrencyAlternateKey LIKE 'A%'
ORDER BY CurrencyAlternateKey;

SELECT *
FROM DimCurrency
WHERE CurrencyAlternateKey LIKE '%A'
ORDER BY CurrencyAlternateKey;

SELECT *
FROM DimCurrency
WHERE CurrencyName LIKE '%Ar%'
ORDER BY CurrencyName;

-- In
SELECT *
FROM DimCurrency
WHERE CurrencyName = 'Bolivar' OR CurrencyName = 'Cedi' OR CurrencyName = 'Cyprus Pound';

SELECT *
FROM DimCurrency
WHERE CurrencyName IN ('Bolivar', 'Cedi', 'Cyprus Pound');

-- Between
SELECT DISTINCT ReorderPoint
FROM DimProduct
WHERE ReorderPoint BETWEEN 10 AND 400;

SELECT DISTINCT ReorderPoint
FROM DimProduct
WHERE ReorderPoint >= 10 AND ReorderPoint <= 400;

-- Count, Avg and Sum
SELECT COUNT(StandardCost) AS  StandardCost
FROM DimProduct
WHERE StandardCost IS NOT NULL;

SELECT AVG(StandardCost) AS  StandardCost
FROM DimProduct
WHERE StandardCost IS NOT NULL;

SELECT SUM(StandardCost) AS  StandardCost
FROM DimProduct
WHERE StandardCost IS NOT NULL;

SELECT SUM(StandardCost) AS  StandardCost,
	AVG(ListPrice) AS ListPrice
FROM DimProduct
WHERE StandardCost IS NOT NULL;

-- Nulls
SELECT *
FROM DimProduct
WHERE WeightUnitMeasureCode IS NULL;

SELECT ISNULL(WeightUnitMeasureCode, 0)
FROM DimProduct;

-- Group By
SELECT EnglishProductName, SUM(ReorderPoint), MAX(ListPrice), AVG(StandardCost)
FROM DimProduct
WHERE StandardCost IS NOT NULL
GROUP BY EnglishProductName;

SELECT EnglishProductName, Color, SUM(ReorderPoint), MAX(ListPrice), AVG(StandardCost)
FROM DimProduct
WHERE StandardCost IS NOT NULL
GROUP BY EnglishProductName, Color
ORDER BY EnglishProductName;

-- Having
SELECT EnglishProductName, MAX(SafetyStockLevel) AS SafetyStockLevel
FROM DimProduct
GROUP BY EnglishProductName
HAVING MAX(SafetyStockLevel) <= 5;

-- Nested SQL
SELECT ProductKey
FROM DimProduct
WHERE Color = 'Black';

SELECT *
FROM DimProduct
WHERE ProductKey IN (SELECT ProductKey FROM DimProduct
						WHERE Color = 'Black');

-- Case
SELECT DISTINCT Color, CASE
		WHEN Color = 'Blue' THEN 'The color was blue'
		WHEN Color = 'Red' THEN 'Red Red Red'
		ELSE Color
		END
FROM DimProduct;

-- Temporary Tables
SELECT ProductKey, ProductAlternateKey, EnglishProductName
INTO #temp
FROM DimProduct
WHERE Color = 'Black';

SELECT * FROM #temp;

SELECT ProductKey FROM #temp;

CREATE TABLE #temp2(
	row1 int
);

SELECT * FROM #temp2;

-- Common Table Expressions
WITH DimProduct_CTE (ProductAlternateKey, EnglishProductName)
AS
(SELECT ProductAlternateKey, EnglishProductName
FROM DimProduct),
DimProduct_CTE2
AS
(SELECT ProductAlternateKey, Class
FROM DimProduct
)

SELECT *
FROM DimProduct_CTE2;

-- Date Functions

-- return the current date along with time
SELECT GETDATE() AS Currentdatetime;
-- return part of a date
SELECT DATEPART(DAY, GETDATE()) AS CurrentDate;
-- add or subtract dates
SELECT DATEADD(DAY, 10, GETDATE()) AS after10dayTimeFromCurrentDatetime;
-- difference between dates
SELECT DATEDIFF(HOUR, 2015-11-16, 2015-11-11);
-- convert dates
SELECT CONVERT(VARCHAR(19), GETDATE());
SELECT CONVERT(VARCHAR(10), GETDATE(),10);
SELECT CONVERT(VARCHAR(10), GETDATE(),110);

------------------------------------------------------------
-- Joins
------------------------------------------------------------
Create Table table1
(
	personname varchar(25)
	,age int
)


Create Table table2
(
	personname varchar(25)
	,age int
)

-- Insert into tables 
Insert Into table1
Select 'John', 22
Insert Into table1
Select 'Jill', 25
Insert Into table1
Select 'Frank', 28
Insert Into table1
Select 'Sue', 31


Insert Into table2
Select 'Jill', 25
Insert Into table2
Select 'Frank', 28
Insert Into table2
Select 'Sue', 31
Insert Into table2
Select 'Mark', 35
Insert Into table2
Select 'Beth', 21

--  Inner Join
SELECT * FROM table1;
SELECT * FROM table2;

SELECT *
FROM table1
JOIN table2
ON table1.personname = table2.personname;

SELECT table1.personname
FROM table1
JOIN table2
ON table1.personname = table2.personname;

-- left join
SELECT *
FROM table1
LEFT JOIN table2
ON table1.personname = table2.personname;

-- right join
SELECT *
FROM table1
RIGHT JOIN table2
ON table1.personname = table2.personname;

-- outer join
SELECT *
FROM table1
FULL OUTER JOIN table2
ON table1.personname = table2.personname;


 -- Get total sales in 2014 and group by product catogory to obaun best selling product
SELECT	-- p.ProductKEy,
		SUM(fis.SalesAmount) AS TotalAmound,
		-- d.FullDateAlternateKey,
		--YEAR(d.FullDateAlternateKey),
		EnglishProductCategoryName
FROM FactInternetSales AS fis
JOIN DimDate AS d
	ON fis.OrderDateKey = d.DateKey
JOIN DimProduct AS p
	ON fis.ProductKey = p.ProductKey
JOIN DimProductSubcategory AS ps
	ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
JOIN DimProductCategory AS pc
	ON ps.ProductCategoryKey = pc.ProductCategoryKey
WHERE YEAR(d.FullDateAlternateKey) = 2014
GROUP BY EnglishProductCategoryName
ORDER BY 1;

-- Union
SELECT * FROM table1
UNION 
SELECT * FROM table2;

--  Insert Into
INSERT INTO table1 (personname, age)
VALUES('john', 85);

--  Insert Into Select
INSERT INTO table1 (personname, age)
SELECT *
FROM table2;

SELECT * FROM table1;

-- Udpate
UPDATE table1
SET age = 99
WHERE personname = 'john';

SELECT * FROM table1;

-- Delete
DELETE FROM table1
WHERE personname = 'john';

SELECT * FROM table1;

-- Truncate
TRUNCATE TABLE table1;

SELECT * FROM table1;

DROP TABLE table1;
DROP TABLE table2;


-- Views
CREATE VIEW vDimDepartmentGroup
AS
SELECT * FROM DimDepartmentGroup
WHERE DepartmentGroupName IN ('Inventory Management', 'Quality Assurance');


SELECT * FROM vDimDepartmentGroup;


ALTER VIEW vDimDepartmentGroup
AS
SELECT ParentDepartmentGroupKey FROM DimDepartmentGroup
WHERE DepartmentGroupName IN ('Inventory Management', 'Quality Assurance');

--Stored Procedures
CREATE PROCEDURE uspTestProcedure
AS
SELECT * FROM DimAccount
GO;

EXEC uspTestProcedure;

CREATE PROCEDURE uspTestProcedure1 @param1 VARCHAR(25)
AS
SELECT * FROM DimAccount
WHERE AccountType = @param1;

EXEC uspTestProcedure1  'Liabilities';


CREATE PROCEDURE uspTestProcedure2 @param1 VARCHAR(25), @param2 INT
AS
SELECT * FROM DimAccount
WHERE AccountType = @param1
AND ParentAccountCodeAlternateKey = @param2;

EXEC uspTestProcedure2  'Liabilities', 2200;