-- Create database asltutorials;
CREATE DATABASE sqltutorials;

USE sqltutorials;

-- Create table
CREATE TABLE Customers (
	CustomerID int NOT NULL IDENTITY PRIMARY KEY,    
    CustomerName varchar(300),
    Address varchar(1000),
    Phone varchar(20),
    City varchar(150),
    Country varchar(200),
);


INSERT INTO Customers(CustomerName,Address,Phone,City,Country) VALUES('Thomas Hardy', '120 Hanover Sq','0123-456-789','London', 'UK');
INSERT INTO Customers(CustomerName,Address,Phone,City,Country) VALUES('Ann Devon', '35 King George','0234-458-417', 'Madrid', 'Spain');
INSERT INTO Customers(CustomerName,Address,Phone,City,Country) VALUES('Maria Larsson', 'Åkergatan 24','0111-456-325', 'Bräcke', 'Sweden');
INSERT INTO Customers(CustomerName,Address,Phone,City,Country) VALUES('Christina Berglund', 'Berguvsvägen 8','0111-456-325', 'Luleå', 'Sweden');
INSERT INTO Customers(CustomerName,Address,Phone,City,Country) VALUES('André Fonseca', 'Av. Brasil, 442','0333-142-687', 'Campinas', 'Brazil');
INSERT INTO Customers(CustomerName,Address,Phone,City,Country) VALUES('Lehmanns Marktstand', 'Magazinweg 7','0222-596-977', 'Frankfurt', 'Germany');

INSERT INTO Customers(CustomerName,Address,Phone,City,Country) VALUES('John Steel', '12 Orchestra Terrace','0222-596-977', 'Walla Walla', NULL);


CREATE TABLE Suppliers (
    SupplierID int NOT NULL IDENTITY PRIMARY KEY,    
    SupplierName varchar(400),
    ContactName varchar(400),
    Address varchar(1000),
    Phone varchar(20),
    City varchar(150),
    Country varchar(200)
);

INSERT INTO Suppliers(SupplierName,ContactName,Address,Phone,City,Country) VALUES('Pavlova, Ltd', 'Ian Devling','74 Rose St. Moonie Ponds','(03) 444-2343','Melbourne','Australia');
INSERT INTO Suppliers(SupplierName,ContactName,Address,Phone,City,Country) VALUES('G''s day', 'Wendy Mackenzie','170 Prince Edward Parade Hunter''s Hill','(02) 555-5914','Sydney','Australia');
INSERT INTO Suppliers(SupplierName,ContactName,Address,Phone,City,Country) VALUES('New Orleans Cajun Delights', 'Shelley Burke','P.O. Box 78934','(03) 444-2343','New Orleans','USA');
INSERT INTO Suppliers(SupplierName,ContactName,Address,Phone,City,Country) VALUES('Svensk Sjöföda AB', 'Michael Björn','Brovallavägen 231','08-123 45 67','Melbourne','Sweden');
INSERT INTO Suppliers(SupplierName,ContactName,Address,Phone,City,Country) VALUES('Karkki Oy', 'Anne Heikkonen','Valtakatu 12','(953) 10956','Lappeenranta','Finland');
INSERT INTO Suppliers(SupplierName,ContactName,Address,Phone,City,Country) VALUES('Escargots Nouveaux', 'Marie Delamare','22, rue H. Voiron','85.57.00.07','Montceau','France');
INSERT INTO Suppliers(SupplierName,ContactName,Address,Phone,City,Country) VALUES(' Leka Trading', 'Chandra Leka','471 Serangoon Loop, Suite #402','555-8787','Singapore','Singapore');


CREATE TABLE Categories (
    CategoryID int NOT NULL IDENTITY PRIMARY KEY,    
    CategoryName varchar(400),
    Description text
);

INSERT INTO Categories(CategoryName, Description) VALUES('Beverages', 'Soft drinks, beer, coffee, tea');
INSERT INTO Categories(CategoryName, Description) VALUES('Seafood', 'Fish, crabs, oysters');
INSERT INTO Categories(CategoryName, Description) VALUES('Cereals', 'Bread, cereals, corn');
INSERT INTO Categories(CategoryName, Description) VALUES('Confections', 'Candies, and sweet breads');
INSERT INTO Categories(CategoryName, Description) VALUES('Electronics', 'Laptop, desktop, iphone, ipad, macbook');


CREATE TABLE Products (
    ProductID int NOT NULL IDENTITY PRIMARY KEY,    
    ProductName varchar(400),
    SupplierID int,
    CategoryID int,
    Unit varchar(250),
    Price float,
);

INSERT INTO Products(ProductName,SupplierID,CategoryID,Unit,Price) VALUES('Chocolade', 2,4,'boxes', 12);
INSERT INTO Products(ProductName,SupplierID,CategoryID,Unit,Price) VALUES('Macbook pro 15.4 inches 2017', 2,6,'boxes', 2200);
INSERT INTO Products(ProductName,SupplierID,CategoryID,Unit,Price) VALUES('Ipad mini 2014', 2,6,'pieces', 712.35);
INSERT INTO Products(ProductName,SupplierID,CategoryID,Unit,Price) VALUES('Japanese seafood sushi', 7,2,'dishes', 25.5);
INSERT INTO Products(ProductName,SupplierID,CategoryID,Unit,Price) VALUES('Beer 555', 3,1,'cups', 12);
INSERT INTO Products(ProductName,SupplierID,CategoryID,Unit,Price) VALUES('Bird-watching Coffee', 4, 4,'cups', 10.2);
INSERT INTO Products(ProductName,SupplierID,CategoryID,Unit,Price) VALUES('Schoggi Schokolade', 5,4,'cups', 12);
INSERT INTO Products(ProductName,SupplierID,CategoryID,Unit,Price) VALUES('Northwoods Cranberry Sauce', 5,2,'jars', 12);


-- list of all tables
SELECT * FROM Sys.Tables;


--clone a table
SELECT Products.* INTO ProductsBackup FROM Products;

SELECT Customers.* INTO CustomersBackup FROM Customers WHERE Customers.Country='Sweden';

SELECT * FROM ProductsBackup;

--clone a backup table with no-data
SELECT Products.* INTO ProductsBackup1 FROM Products WHERE 2=3;
SELECT * FROM ProductsBackup1;

--backup using "insert into"
INSERT INTO ProductsBackup(ProductName, Price)
SELECT Products.ProductName, Products.Price FROM Products;



CREATE TABLE Orders (
    OrderID int NOT NULL IDENTITY PRIMARY KEY,    
    CustomerID int, 
    EmployeeID int, 
    OrderDate datetime,
    ShipperID int, 
);

CREATE TABLE Shippers (
    ShipperID int NOT NULL IDENTITY PRIMARY KEY,    
    ShipperName varchar(400),
    Phone varchar(20),
    Description text
);

INSERT INTO Shippers(ShipperName, Phone, Description) VALUES('Grab', '(123)-456-789', 'Install Grab in App Store and call');
INSERT INTO Shippers(ShipperName, Phone, Description) VALUES('Speedy Express', '(503) 555-9831', 'Deliver very fast');
INSERT INTO Shippers(ShipperName, Phone, Description) VALUES('Federal Shipping', '(500) 555-9931', 'Deliver with low cost');


CREATE TABLE Employees (
    EmployeeID int NOT NULL IDENTITY PRIMARY KEY,    
    FullName varchar(400),
    DateOfBirth datetime,
    Notes text
);


CREATE TABLE OrderDetails (
    OrderDetailID int NOT NULL IDENTITY PRIMARY KEY,    
    OrderID int,
    ProductID int,
    Quantity int
);


---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
DROP TABLE Products;

CREATE TABLE Products (
    ProductID int NOT NULL IDENTITY PRIMARY KEY,    
    ProductName varchar(400),
    SupplierID int,
    CategoryID int,
    Unit varchar(250),
    Price float,

    CONSTRAINT FK_CategoryProduct
    FOREIGN KEY (CategoryID)
    REFERENCES Categories(CategoryID)
    --CONSTRAINT Check_Product CHECK (Price>=0 AND Price<=2000)
);

INSERT INTO Products(ProductName,SupplierID,CategoryID,Unit,Price) VALUES('Chocolade', 2,4,'boxes', 12);
-- category 6 doesn't exist so this will not work
INSERT INTO Products(ProductName,SupplierID,CategoryID,Unit,Price) VALUES('Macbook pro 15.4 inches 2017', 2,6,'boxes', 2200);

SELECT * FROM Products;

SELECT * FROM Categories WHERE CategoryID=6;

-- another way to make a constraint on existing table
ALTER TABLE Products
ADD CONSTRAINT FK_CategoryProduct
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

-- remove constraint from the table
ALTER TABLE Products
DROP CONSTRAINT FK_CategoryProduct;

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='Products';

INSERT INTO Products(ProductName,SupplierID,CategoryID,Unit,Price) VALUES('Ipad mini 2014', 2,6,'pieces', 712.35);

-- Check constraint
ALTER TABLE Products
ADD CONSTRAINT Check_Product CHECK (Price>=0 AND Price<=2000);
-- test constraint
INSERT INTO Products(ProductName,SupplierID,CategoryID,Unit,Price) VALUES('Japanese seafood sushi', 7,2,'dishes', 2001);
--Modify to:
INSERT INTO Products(ProductName,SupplierID,CategoryID,Unit,Price) VALUES('Japanese seafood sushi', 7,2,'dishes', 25.5);

-- Unique constraint
ALTER TABLE Products
ADD CONSTRAINT UN_Product UNIQUE (ProductName);

INSERT INTO Products(ProductName,SupplierID,CategoryID,Unit,Price) VALUES('Beer 555', 3,1,'cups', 12);
INSERT INTO Products(ProductName,SupplierID,CategoryID,Unit,Price) VALUES('Bird-watching Coffee', 4, 4,'cups', 10.2);

INSERT INTO Products(ProductName,SupplierID,CategoryID,Unit,Price) VALUES('Schoggi Schokolade', 5,4,'cups', 12);
INSERT INTO Products(ProductName,SupplierID,CategoryID,Unit,Price) VALUES('Northwoods Cranberry Sauce', 5,2,'jars', 12);


--datetime values
INSERT INTO Employees(FullName, DateOfBirth, Notes) VALUES('Margaret Fuller','1994-10-25', 'He is in sales department');
--default date
ALTER TABLE Orders
ADD CONSTRAINT DF_OrderDate 
DEFAULT GETDATE() FOR OrderDate;

INSERT INTO Orders(CustomerID,EmployeeID,ShipperID) VALUES(2,1,3);
SELECT * FROM Orders;










-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
--trigger
CREATE TRIGGER trg_UpdateProduct 
ON Products AFTER UPDATE AS
DECLARE @Price AS FLOAT
SET @Price = (SELECT TOP 1 Price FROM Products WHERE Price<0)
IF @Price < 0
BEGIN
    RAISERROR  ('Cannot update negative Price',16,10);
    ROLLBACK
END



ALTER TABLE Products
DROP CONSTRAINT Check_Product;

-- test trigger
UPDATE Products 
SET Price=-2.2
WHERE ProductID=8;

--Add "counts" field to Categories
ALTER TABLE Categories
ADD counts INT;

--update NULL to 0
UPDATE Categories
SET Categories.counts=0
WHERE Categories.counts is NULL;

SELECT * FROM Categories;


CREATE TRIGGER trg_InsertProduct 
ON Products AFTER INSERT AS
DECLARE @CategoryID AS INT
BEGIN

    set @CategoryID=(select CategoryID from inserted)
    UPDATE Categories
    SET counts = counts+1
    WHERE CategoryID = @CategoryID;
END

-- test trigger
INSERT INTO Products(ProductName, SupplierID, CategoryID, Unit, Price)
VALUES('Iphone XS Plus', 2,1,'pieces',233);

SELECT * FROM Categories;


-- trigger after delete
CREATE TRIGGER trg_DeleteProduct 
ON Products AFTER DELETE AS
DECLARE @CategoryID AS INT
BEGIN
    set @CategoryID=(select CategoryID from deleted)
    UPDATE Categories
    SET counts = counts-1
    WHERE CategoryID = @CategoryID AND counts > 0;
END

-- test
SELECT * FROM Products;
SELECT * FROM Categories;

DELETE FROM Products
WHERE ProductID=15;

SELECT * FROM Products;
SELECT * FROM Categories;

-- Procedure = function without 'return value'
CREATE PROCEDURE searchProducts
	@NameContain NVARCHAR(200)
AS
	SELECT *
	FROM Products
	WHERE ProductName LIKE '%'+@NameContain+'%';
Go

-- test procedure
EXECUTE searchProducts N'japanese'


 

-------------------------------------------------------------------------
-------------------------------------------------------------------------
-------------------------------------------------------------------------
-------------------------------------------------------------------------

CREATE DATABASE TravelManagement;

USE TravelManagement;

CREATE TABLE tblTravels(
	id INT PRIMARY KEY NOT NULL IDENTITY(1, 1), --start from 1, increase 1
	name VARCHAR(200) NOT NULL,
	price FLOAT DEFAULT 0.0,
	numberOfDays INT DEFAULT 1,
	startDate DATE DEFAULT GETDATE() --today
);

SELECT * FROM tblTravels;

CREATE TABLE tblCategories(
	id INT PRIMARY KEY NOT NULL IDENTITY(1, 3), --start from 1, increase 1
	name VARCHAR(250) NOT NULL,
	numberOfTravels INT CHECK(numberOfTravels >= 0) NOT NULL DEFAULT 0
);


--
exec sp_columns tblCategories;

ALTER TABLE tblTravels ADD categoryId INT;

exec sp_columns tblTravels;

-- add foreign key for tblTravels
ALTER TABLE tblTravels ADD CONSTRAINT FK_TravelsCategories
FOREIGN KEY (categoryId) REFERENCES tblCategories(id);

-- numberOfDays must be 1 -> 20 => using  CHECK constraint
ALTER TABLE tblTravels ADD CONSTRAINT CK_NumberOfDays CHECK(numberOfDays >= 1 AND numberOfDays <=20);

-- test data
INSERT INTO tblTravels(name, price, numberOfDays, startDate)
VALUES('travel from Vietnam to Sweden', 12300.0, 12, '2019-12-21');

INSERT INTO tblTravels(name, price, numberOfDays, startDate)
VALUES('travel from Vietnam to China', 2200.0, 2, '2019-12-25');

INSERT INTO tblTravels(name, price, numberOfDays)
VALUES('travel from Vietnam to China', 2200.0, 2);
-- don't work
INSERT INTO tblTravels(name, price, numberOfDays)
VALUES('travel from Vietnam toSingapore', 4100.0, 25);

SELECT * FROM tblTravels;

-- name must be unique
DELETE FROM tblTravels WHERE id =2;

ALTER TABLE tblTravels ADD CONSTRAINT UC_Name UNIQUE(name);

ALTER TABLE tblCategories ADD CONSTRAINT UC_CategoryName UNIQUE(name);

INSERT INTO tblCategories(name) VALUES('Family travels');
INSERT INTO tblCategories(name) VALUES('Beaches');
INSERT INTO tblCategories(name) VALUES('Fod and drinks');

SELECT * FROM tblCategories;


