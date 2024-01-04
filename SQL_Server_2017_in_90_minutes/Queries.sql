USE sqltutorials;

-- View everything from the table
SELECT * FROM Customers;
SELECT * FROM Suppliers;
SELECT * FROM Categories;
SELECT * FROM Products;

-- View selected columns
SELECT CustomerName, Phone,City, Country FROM Customers;

-- remove duplicated records - Country
SELECT DISTINCT(Country) FROM Customers;

-- Count how many countries there are
SELECT COUNT(DISTINCT(Country)) FROM Customers;

-- View all Customers from Country = Sweden
SELECT * FROM Customers WHERE Country='Sweden';

-- View all Customers where CustomerID is between 1 and 3
SELECT * FROM Customers WHERE CustomerID BETWEEN 1 AND 3;

-- View Customers from Country = Sweden and City Luleå
SELECT * FROM Customers WHERE Country='Sweden' AND City='Luleå';

-- View Customers from Germany or Spain
SELECT * FROM Customers WHERE Country='Germany' OR Country='Spain';

-- View all Customers except Customer with CustomerID = 1
SELECT * FROM Customers WHERE NOT CustomerID=1;

-- Sort results by country name alphabetically
SELECT * FROM Customers ORDER BY Country;

-- Sort results by country name descending from Z to A
SELECT * FROM Customers ORDER BY Country DESC;

-- View Customers without country name
SELECT * FROM Customers WHERE Country is NULL;

-- View Customers with country name
SELECT * FROM Customers WHERE Country is NOT NULL;

-- Update a record
SELECT * FROM Customers WHERE CustomerID=1;

UPDATE Customers SET CustomerName = 'Thomas Hardy A', City= 'England' WHERE CustomerID = 1;

SELECT * FROM Customers WHERE CustomerID=1;

--View top 4 Customers
SELECT TOP 4 * FROM Customers;

-- View top 50 % Customers
SELECT TOP 50 PERCENT * FROM Customers;

-- LIKE 

-- Select Customers where CustomerName start with letter m
SELECT * from Customers WHERE CustomerName LIKE 'm%';
-- Select Customers where CustomerName ends with letter m
SELECT * from Customers WHERE CustomerName LIKE '%d';
-- Select Customers where CustomerName have at least two characters
SELECT * from Customers WHERE CustomerName LIKE '%_%_%';
-- Select Customers where CustomerName start with letter a or c or e
SELECT * from Customers WHERE CustomerName LIKE '[ace]%';
-- Select Customers where CustomerName start with letter between a and e
SELECT * from Customers WHERE CustomerName LIKE '[a-e]%';
-- Select Customers where CustomerName not start with letter between a and e
SELECT * from Customers WHERE CustomerName NOT LIKE '[a-e]%';

-- IN 
SELECT * FROM Customers WHERE Country IN ('Brazil', 'Sweden');

-- Select Products with CategoryID = 6
SELECT * FROM Products WHERE CategoryID = 6;
-- Select Products with SupplierID = 2
SELECT * FROM Products WHERE SupplierID=2;

-- Calculate values
SELECT MIN(Price) FROM Products;
SELECT MAX(Price) as "Highest price" FROM Products;
SELECT AVG(Price) as "Average Price" FROM Products;
SELECT SUM(Price) as "Sum" FROM Products;
SELECT SUM(Price) as "Sum", COUNT(*) as "Number of Products" FROM Products;


-- JOINS

--inner join 1-n
SELECT Categories.*, Products.*
FROM Categories
INNER JOIN Products ON Categories.CategoryID=Products.CategoryID
ORDER BY Categories.CategoryID;

--left join 1-n
SELECT Categories.*, Products.*
FROM Categories
LEFT JOIN Products ON Categories.CategoryID=Products.CategoryID
ORDER BY Categories.CategoryID;

--right join 1-n
SELECT Categories.*, Products.*
FROM Categories
RIGHT JOIN Products ON Categories.CategoryID=Products.CategoryID
ORDER BY Categories.CategoryID;

--full outer join 1-n
SELECT Categories.*, Products.*
FROM Categories
FULL OUTER JOIN Products ON Categories.CategoryID=Products.CategoryID
ORDER BY Categories.CategoryID;

--inner join n-1
SELECT Products.*, Categories.*
FROM Products
INNER JOIN Categories ON Products.CategoryID=Categories.CategoryID
ORDER BY Products.ProductID;


--UNION
SELECT Suppliers.Country FROM Suppliers
UNION
SELECT Customers.Country FROM Customers
ORDER BY Country;

--UNION ALL => show dublicates
SELECT Suppliers.Country FROM Suppliers
UNION
SELECT Customers.Country FROM Customers
ORDER BY Country;

-- GROUP BY
SELECT COUNT(Customers.CustomerID), Customers.Country
FROM Customers
GROUP BY Customers.Country
HAVING Customers.Country IS NOT NULL;
--having is "where" of group

--exists
SELECT Suppliers.*
FROM Suppliers
WHERE EXISTS (SELECT ProductName FROM Products WHERE SupplierId = Suppliers.supplierId AND Price > 1000);


--case when
SELECT Products.*,
CASE
    WHEN Products.Price > 10 THEN 'Price: greater than 10'
    WHEN Products.Price > 100 THEN 'Price: greater than 100'
    ELSE 'Price: under 10'
END AS TextPrice
FROM Products;

-- Get date time
SELECT GETDATE();