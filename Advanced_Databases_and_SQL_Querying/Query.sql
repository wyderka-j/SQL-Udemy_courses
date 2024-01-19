-- SQL Server Management Studio 

USE AdventureWorks2012;

-- SelectTopNRows  
SELECT TOP 1000 [TerritoryID],
      [Name],
      [CountryRegionCode],
      [Group],
      [SalesYTD],
      [SalesLastYear],
      [CostYTD],
      [CostLastYear],
      [rowguid],
      [ModifiedDate]
  FROM [AdventureWorks2012].[Sales].[SalesTerritory];

 ---------------------------------------------------------
-- Views
 ---------------------------------------------------------

-- US View
CREATE VIEW MyCustomUSView
AS
SELECT * FROM [AdventureWorks2012].[Sales].[SalesTerritory]
WHERE CountryRegionCode LIKE 'US';

SELECT * FROM MyCustomUSView;

-- North America View
CREATE VIEW NASalesQuota
AS
SELECT [Name], [Group], [SalesQuota], [Bonus]
FROM [AdventureWorks2012].[Sales].[SalesTerritory] A INNER JOIN [Sales].[SalesPerson] B 
ON A.TerritoryID = B.territoryID
WHERE [Group] LIKE 'North America';

SELECT * FROM NASalesQuota;

 ---------------------------------------------------------
 -- TRIGGER
 ---------------------------------------------------------
 SELECT * FROM [HumanResources].[Shift];

 CREATE TRIGGER Demo_Trigger
 ON [HumanResources].[Shift]
 AFTER INSERT
 AS
 BEGIN
 PRINT 'INSERT IS NOT ALLOWED. YOU NEED APPROVAL'
 ROLLBACK TRANSACTION
 END
 GO

  --TEST THE TRIGGER
 INSERT INTO [HumanResources].[Shift] ([Name], [StartTime], [EndTime],[ModifiedDate])
VALUES('RAKESH2','07:00:00.0000000','8:00:00.0000000',getdate());


SELECT * FROM [HumanResources].[Shift];

-- DATABASE LEVEL TRIGGER

CREATE TRIGGER DEMO_DBLEVELTRIGGER
ON DATABASE
AFTER CREATE_TABLE
AS
BEGIN
PRINT 'CREATION OF NEW TABLES NOT ALLOWED'
ROLLBACK TRANSACTION
END
GO

CREATE TABLE MYDEMOTABLE(Col1 varchar(10));

---------------------------------------------------------
-- Stored Procedures
---------------------------------------------------------

CREATE PROCEDURE MyTestProc
AS
SET NOCOUNT ON
SELECT * FROM [HumanResources].[Shift]

EXECUTE MyTestProc


CREATE PROCEDURE MyTestProc2
AS
SET NOCOUNT OFF
SELECT * FROM [HumanResources].[Shift]

EXEC MyTestProc2


DROP PROC MytestPRoc
DROP PROC MytestPRoc2

--
CREATE PROCEDURE MyFirstParamProcedure
@Param_Name VARCHAR(50)
AS
SET NOCOUNT ON
SELECT * FROM [HumanResources].[Shift]
WHERE Name  = @Param_Name

EXEC MyFirstParamProcedure @Param_Name = 'Day'
EXEC MyFirstParamProcedure 'Day'
EXEC MyFirstParamProcedure -- don't work, function 'MyFirstParamProcedure' expects parameter

DROP PROC MyFirstParamProcedure


CREATE PROCEDURE MyFirstParamProcedure
@Param_Name VARCHAR(50) = 'Evening'
AS
SET NOCOUNT ON
SELECT * FROM [HumanResources].[Shift]
WHERE Name  = @Param_Name

EXEC MyFirstParamProcedure 'Day'
EXEC MyFirstParamProcedure


--OUTPUT PARAMETERS
CREATE PROC MyOutputSP
@TopShift varchar(50) OUTPUT
AS 
SET @TopShift = (SELECT TOP(1) ShiftID FROM [HumanResources].[Shift])


DECLARE @outputresult VARCHAR(50)
EXEC MyOutputSP @outputresult output
select @outputresult


DROP PROC MyOutputSP


--RETURNING VALUES FROM STORED PROCEDURES
CREATE PROC myFirstReturningSP
AS
RETURN 12 

DECLARE @resturnvalue INT
EXEC @resturnvalue =  myFirstReturningSP 
SELECT @resturnvalue


------------------------------------------
-- User Defined Functions
------------------------------------------
SELECT * FROM [Sales].[SalesTerritory];

CREATE FUNCTION YTDSALES()
RETURNS MONEY
AS
BEGIN
DECLARE @YTDSALES MONEY
SELECT @YTDSALES = SUM(SALESYTD) FROM [Sales].[SalesTerritory]
RETURN @YTDSALES
END

DECLARE @YTDRESULTS AS MONEY
SELECT @YTDRESULTS = dbo.YTDSALES()
PRINT @YTDRESULTS


DROP FUNCTION YTDSALES

---PARAMETERIZED FUNCTIONS
SELECT * FROM [Sales].[SalesTerritory];


CREATE FUNCTION YTD_GROUP
(@GROUP VARCHAR(50))

RETURNS MONEY
AS 
BEGIN
DECLARE @YTDSALES AS MONEY
SELECT @YTDSALES = SUM(SalesYTD) FROM [Sales].[SalesTerritory]
WHERE [GROUP] = @GROUP
RETURN @YTDSALES
END


DECLARE @RESULTS MONEY
SELECT @RESULTS = dbo.YTD_GROUP('Europe')
PRINT @RESULTS


DROP FUNCTION YTD_GROUP

-----------------------------------------------------
---FUNCTIONS RETURNING TABLES

CREATE FUNCTION ST_TABVALUED
(@TerritoryID INT)
RETURNS TABLE
AS RETURN 
SELECT Name, CountryRegionCode, [Group], SalesYTD
FROM Sales.SalesTerritory
Where TerritoryID = @TerritoryID


SELECT Name, [Group] FROM dbo.ST_TABVALUED(7);


-----------------------------------------------------------
---Transactions and Error Handling
-----------------------------------------------------------
SELECT * FROM [Sales].[SalesTerritory];


BEGIN TRANSACTION
	UPDATE Sales.SalesTerritory
	SET CostYTD = 1.00
	WHERE TerritoryID = 1
COMMIT TRANSACTION


SELECT * FROM [Sales].[SalesTerritory];


--@@error 0 = success, > 0 means error

DECLARE @ERRORRESULTS VARCHAR(50)
BEGIN TRANSACTION
INSERT INTO [Sales].[SalesTerritory]
           ([Name]
           ,[CountryRegionCode]
           ,[Group]
           ,[SalesYTD]
           ,[SalesLastYear]
           ,[CostYTD]
           ,[CostLastYear]
           ,[rowguid]
           ,[ModifiedDate])
     VALUES
           ('ABC',
           'us',
           'na',
           1.00,
           1.00,
           1.00,
           1.00,
           '43689A10-E30B-497F-B0DE-11DE20267FF3',
           GETDATE())

SET @ERRORRESULTS = @@ERROR

IF(@ERRORRESULTS = 0)
BEGIN
	PRINT 'SUCCESS!!!!'
	COMMIT TRANSACTION
END
ELSE
BEGIN
	PRINT 'STATEMENT FAILED!!!!'
	ROLLBACK TRANSACTION
END


SELECT * FROM [Sales].[SalesTerritory];

--custom error message

DECLARE @ERRORRESULTS VARCHAR(50)
BEGIN TRANSACTION
INSERT INTO [Sales].[SalesTerritory]
           ([Name]
           ,[CountryRegionCode]
           ,[Group]
           ,[SalesYTD]
           ,[SalesLastYear]
           ,[CostYTD]
           ,[CostLastYear]
           ,[rowguid]
           ,[ModifiedDate])
     VALUES
           ('ABC',
           'us',
           'na',
           1.00,
           1.00,
           1.00,
           1.00,
           '43689A10-E30B-497F-B0DE-11DE20267FF3',
           GETDATE())

SET @ERRORRESULTS = @@ERROR

IF(@ERRORRESULTS = 0)
BEGIN
	PRINT 'SUCCESS!!!!'
	COMMIT TRANSACTION
END
ELSE
BEGIN
	RAISERROR('STATEMENT FAILED - THIS IS MY CUSTOM MESSAGE', 16, 1)
	ROLLBACK TRANSACTION
END


--TRY AND CATCH
BEGIN TRY
BEGIN TRANSACTION

DECLARE @ERRORRESULTS VARCHAR(50)
BEGIN TRANSACTION
INSERT INTO [Sales].[SalesTerritory]
           ([Name]
           ,[CountryRegionCode]
           ,[Group]
           ,[SalesYTD]
           ,[SalesLastYear]
           ,[CostYTD]
           ,[CostLastYear]
           ,[rowguid]
           ,[ModifiedDate])
     VALUES
           ('ABC',
           'us',
           'na',
           1.00,
           1.00,
           1.00,
           1.00,
           '43689A10-E30B-497F-B0DE-11DE20267FF3',
           GETDATE())

		   COMMIT TRANSACTION
END TRY

BEGIN CATCH
	PRINT 'CATCH STATEMENT ENTERED'
	ROLLBACK TRANSACTION
END CATCH

-----------------------------------------------------------
--CTE, Group by, Rollup, Cube
-----------------------------------------------------------
SELECT * FROM [Sales].[SalesTerritory];

WITH CTE_SALESTERR
AS
(
	SELECT Name, CountryRegionCode FROM Sales.SalesTerritory
)

SELECT * FROM CTE_SALESTERR
WHERE NAME LIKE 'North%';

---GROUP BY 
SELECT * FROM [Sales].[SalesTerritory];

SELECT Name, NUll, NULL, SUM(SalesYTD)
FROM [Sales].[SalesTerritory]
GROUP BY Name
UNION ALL
SELECT Name, CountryRegionCode, NULL,  SUM(SalesYTD)
FROM [Sales].[SalesTerritory]
GROUP BY Name, CountryRegionCode
UNION ALL
SELECT Name, CountryRegionCode, [Group], SUM(SalesYTD)
FROM [Sales].[SalesTerritory]
GROUP BY Name, CountryRegionCode,  [group]

---GROUPING SETS
SELECT Name, CountryRegionCode, [Group], SUM(SalesYTD)
FROM [Sales].[SalesTerritory]
GROUP BY GROUPING SETS
(
	(Name),
	(Name, CountryREgionCode),
	(Name, CountryRegionCode, [Group])
)

--ROLLUP 
SELECT Name, CountryRegionCode, [Group], SUM(SalesYTD)
FROM [Sales].[SalesTerritory]
GROUP BY ROLLUP
(
	(Name, CountryRegionCode, [Group])
)

--CUBE 
SELECT Name, CountryRegionCode, [Group], SUM(SalesYTD)
FROM [Sales].[SalesTerritory]
GROUP BY CUBE
(
	(Name, CountryRegionCode, [Group])
)

-----------------------------------------------------
--Ranking Functions
-----------------------------------------------------

SELECT * FROM [Person].[Address];

SELECT POSTALCODE FROM [Person].[Address]
WHERE POSTALCODE IN ('98052', '98027', '98055' , '97205');


SELECT POSTALCODE,
	ROW_NUMBER() OVER (ORDER BY POSTALCODE) AS 'ROW NUMBER',
	RANK() OVER (ORDER BY POSTALCODE) AS 'RANK',
	DENSE_RANK() OVER (ORDER BY POSTALCODE) AS 'DENSE RANK',
	NTILE(10) OVER (ORDER BY POSTALCODE) AS 'NTILE'
FROM [Person].[Address]
WHERE POSTALCODE IN ('98052', '98027', '98055' , '97205');

-------------------------------------------------------
-- Partitions 
-------------------------------------------------------
CREATE DATABASE partitiondb;

USE partitiondb;


CREATE PARTITION FUNCTION cust_part_func (INT)
AS RANGE RIGHT
FOR VALUES (1000, 2000, 3000, 4000, 5000);


CREATE PARTITION SCHEME cust_part_scheme
AS PARTITION cust_part_func
TO (fgp1, fgp2, fgp3,fgp4,fgp5,fgp6);


--CREATE A DB Called Partition, THen create filegroups, then logical secondary partitions and asscociate it. Show all secondary filegroups.
CREATE TABLE tbpartition
(	empid INT IDENTITY(1,1) NOT NULL,
	empdate DATETIME NULL
)
ON cust_part_scheme(empid);

DECLARE @i INT
SET @i = 0
WHILE @i < 10000
BEGIN
INSERT INTO tbpartition (empdate) VALUES (GETDATE())
SET @i = @i + 1
END

SELECT $PARTITION.cust_part_func(EMPID) AS 'partition number', *
FROM tbpartition;

----------------------------------------------------
-- Dynamic Queries and Pivots
----------------------------------------------------
USE AdventureWorks2012;

SELECT * FROM sales.salesterritory;

SELECT countryregioncode, [group], salesytd
FROM sales.salesterritory;

---countryregioncode |NorthAmerica | Europe
-- US                | 23          |...

SELECT countryregioncode , [North America], [Europe]
FROM sales.salesterritory
PIVOT
(
	SUM(salesytd) FOR [group]
	IN ([North America], [Europe], [Pacific])
)
AS pvt;

---Dynamic Queries
DECLARE @sqlstring VARCHAR(2000)
SET @sqlstring = 'select countryregioncode, [group], '
SET @sqlstring = @sqlstring + 'salesytd from sales.salesterritory'

PRINT @sqlstring 
EXEC (@sqlstring)


