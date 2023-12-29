--Here is a query to get the overall average price.
select Avg(Price) from Product

--and here is a query to display that in our detail query
select ProductID,
    ProductName,
    ProductType, Price,
    8.013636 AvgPrice
from Product

--but that seems silly, as the average price will most likely change.
--how can we protect ourselves from this?
--can we embed the query?  Sure can!  it is called a sub query.

--A sub query is just a query inside another...

select ProductID,
    ProductName,
    ProductType, Price,
    (select Avg(Price) from Product) AvgPrice
from Product

--error
select * from employeehistory
select ProductID,
    ProductName,
    ProductType, Price,
    (select Price from Product) AvgPrice
from Product

--error?
select * from employeehistory
select ProductID,
    ProductName,
    ProductType, Price,
    (select avg(Price), count(price) from Product) AvgPrice
from Product

-- select price and overall product average.
select ProductID,
    ProductName,
    ProductType, Price,
    Price - (select Avg(Price) from Product) PriceDifference
from Product



-- For each product in the Product table,  list the ProductID, ProductName, Price, and Average ProductPrice as AverageProductPrice.
-- Order your results by ProductName in ascending order
SELECT ProductID, ProductName, Price, (SELECT AVG(Price) FROM Product) AS AverageProductPrice
FROM Product 
ORDER BY ProductName

-- Here is a query to get the average price for all Pizzas select avg(price) from Product Where ProductName like '%Pizza%'
-- Using that as part of your subquery, list all Pizza relate products and compare their price to the average price for pizzia.
-- Your result should contain the following columns: ProductID, ProductName, Price, AveragePizzaPrice, PriceDifference
-- where PriceDifference is Price minus the Average Pizza Price
-- order your result by ProductName
SELECT ProductID, ProductName, Price,
    (SELECT AVG(price) FROM Product WHERE ProductName LIKE '%Pizza%') AveragePizzaPrice,
    Price - (SELECT AVG(price) FROM Product WHERE ProductName LIKE '%Pizza%') PriceDifference
FROM Product
WHERE ProductName LIKE '%Pizza%'
ORDER BY ProductName
