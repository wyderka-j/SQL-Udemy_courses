select *
from CustomerOrderDetail

--one want to group data, is to just select distinct values.
--here is a distinct list of customer of products they bought.
select distinct CustomerName, ProductName
from CustomerOrderDetail

--We can also use group by.
select CustomerName, ProductName
from CustomerOrderDetail
group by CustomerName, ProductName

--the cool thing about using group by summarize data along the group.
--for instance we can count how many times customers orders a certain product.
select CustomerName, ProductName,
    Count(ProductName) TimesOrdered
from CustomerOrderDetail
group by CustomerName, ProductName

--there are other functions you can use to sumarize data.
--the most common are SUM, AVG, MIN and MAX.
select CustomerName, ProductName,
    Count(ProductName) TimesOrdered,
    Sum(PurchaseAmount) TotalPurchaseAmount 
from CustomerOrderDetail
group by CustomerName, ProductName

--you can also use them in formulas
select CustomerName, ProductName, 
    Sum(PurchaseAmount) TotalPurchaseAmount, 
    Price  * Sum(Quantity) TotalPurchaseAmountCalc
from CustomerOrderDetail
group by CustomerName, ProductName, price

--you can also sort and filter the results.
select CustomerName, ProductName, 
    Sum(PurchaseAmount) TotalPurchaseAmount, 
    Price  * Sum(Quantity) TotalPurchaseAmountCalc
from CustomerOrderDetail
where ProductName like '%Pizza%'
group by CustomerName, ProductName, price
order by CustomerName, ProductName

--finally you don't have to use group by..
-- here is a way to get total count of orderdetails
select count(1)
from CustomerOrderDetail

--or total purchases
select sum(PurchaseAmount) GrandTotal
from CustomerOrderDetail


-- What is the average price of a product by product type? You can use the product table.  Display the ProductType and AveragePrice
SELECT ProductType, AVG(Price) AS AveragePrice
FROM Product
GROUP BY ProductType

-- How may employees are there in the Employee table?
SELECT count(*) 
FROM Employee