-- ordering data
select ProductID, ProductName, ProductType, Price
from Product
order by ProductName asc

--asc is the default so you don't need to specifiy if.
select ProductID, ProductName, ProductType, Price
from Product
order by ProductName

-- ordering in descending order
select ProductID, ProductName, ProductType, Price
from Product
order by ProductName desc

--Of course you can combine ordering with filtering.
--Here we select all the 'P' product type and order by price
select ProductID, ProductName, ProductType, Price
from Product
where ProductType = 'P'
order by Price

--You can also order by more than one column
select ProductID, ProductName, ProductType, Price
from Product
order by ProductType, ProductName

--here we use desc to order type in descending order
select ProductID, ProductName, ProductType, Price
from Product
order by ProductType desc, ProductName

-- You can also sort on an expression.  Here is a crazy sort showing just that!
select ProductID, ProductName, ProductType, Price, Price * ProductID CrazySort
from Product
order by price * productID

--limit your results to the first five
select ProductID, ProductName, ProductType, Price, Price * ProductID CrazySort
from Product
order by price * productID
limit 5

--SQL Server is a bit different, here you use TOP
select top 5 ProductID, ProductName, ProductType, Price, Price * ProductID CrazySort
from Product
order by price * productID



-- Select LastName, City, and PostalCode from the customer table in LastName order.
SELECT LastName, City, PostalCode
FROM Customer
ORDER BY LastName

-- Select LastName, City, and PostalCode from Customer in order of City and LastName.  The Last Names should be in descending order.
SELECT LastName, CIty, PostalCode
FROM Customer
ORDER BY City, LastName DESC

-- What are the top five highest priced products?  Use the product table and display the Product's name and Price.
SELECT TOP 5 ProductName, Price
FROM Product
ORDER BY Price DESC 