
--Filtering Data
select ProductID, ProductName, ProductType, Price
from Product

--How to find all ProductType = 'P'
select ProductID, ProductName, ProductType, Price
from Product
where ProductType = 'P' -- Pizza

--How about ProductType P or I?
select ProductID, ProductName, ProductType, Price
from Product
where ProductType = 'P' or ProductType = 'I'

-- you can use IN as a shortcut.
select ProductID, ProductName, ProductType, Price
from Product
where ProductType in ('P', 'I')

-- adding not...
select ProductID, ProductName, ProductType, Price
from Product
where ProductType <> 'P' -- Pizza

select ProductID, ProductName, ProductType, Price
from Product
where not (ProductType = 'P' or ProductType = 'I')


select ProductID, ProductName, ProductType, Price
from Product
where ProductType not in ('P','I')


--comparisons
select ProductID, ProductName, ProductType, Price
from Product
where price > 5.00

select ProductID, ProductName, ProductType, Price
from Product
where price >= 5.00 and price <= 11.00

--shortcut use between!
select ProductID, ProductName, ProductType, Price
from Product
where price between 5.00 and 11.00

--partial searches using like.
select ProductID, ProductName, ProductType, Price
from Product
where ProductName like '%Pizza%' 

--Pizzas whos price is greater than 12.00
select ProductID, ProductName, ProductType, Price
from Product
where ProductName like '%Pizza%' and Price > 12.00



-- Using the Customer table, display the CustomerId, LastName, City for all Customers in the city Plainwill
SELECT CustomerID, LastName, City
FROM Customer
WHERE City = 'Plainwill'

-- Using the Customer table, find all customers having a last name that is greater than or equal to L.  Display the CustomerID and LastName.
SELECT CustomerID, LastName
FROM Customer
WHERE LastName >= 'L'

-- Using the Customer table, display the CustomerID, LastName, and PhoneNumber for all customer within the 249 area code.
SELECT CustomerID, LastName, PhoneNumber
FROM Customer
WHERE PhoneNumber LIKE '249%'

-- Display the ProductID, ProductName, ProductType, and Price for all product table items having a price NOT BETWEEN 5.00 and 11.00 dollars
SELECT ProductID, ProductName, ProductType, Price
FROM Product
WHERE Price NOT BETWEEN 5.00 AND 11.00

-- Display the ProductID, ProductName, ProductType, and Price for all Product table items having a price NOT BETWEEN 5.00 and 11.00 dollars whose ProductType is either P or B
SELECT ProductID, ProductName, ProductType, Price
FROM Product
WHERE Price NOT BETWEEN 5.00 AND 11.00 
    AND ProductType IN ('P','B')