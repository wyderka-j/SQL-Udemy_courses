/*In relational databases you have many tables.
So how do we combine data from two tables?
We can use an inner join
*/

--consider Employee and EmployeeHistory
select * from Employee;
select * from EmployeeHistory

--If I wan't to know when a person started working or stopped, I have to look up their ID
--from the employee table in the employee history table...

--I can also do this using SQL using an Inner Join clause.
--Here is the query
select Employee.EmployeeID, Employee.FirstName, Employee.LastName,
    EmployeeHistory.StartDate, EmployeeHistory.TerminationDate
from Employee
    inner join EmployeeHistory on Employee.EmployeeID = EmployeeHistory.EmployeeID

--I can make this easier to ready by using aliases
select e.EmployeeID, e.FirstName, e.LastName,
    h.StartDate, h.TerminationDate
from Employee e
    inner join EmployeeHistory h on e.EmployeeID = h.EmployeeID

--you can even sort by column in both tables.
--I can make this easier to ready by using aliases
select e.EmployeeID, e.FirstName, e.LastName,
    h.StartDate, h.TerminationDate
from Employee e
    inner join EmployeeHistory h on e.EmployeeID = h.EmployeeID
order by h.StartDate, e.LastName

--and we can even all where clauses
select e.EmployeeID, e.FirstName, e.LastName,
    h.StartDate, h.TerminationDate
from Employee e
    inner join EmployeeHistory h on e.EmployeeID = h.EmployeeID
where e.LastName like 'S%'
order by h.StartDate, e.LastName

--you can join more than two tables... lets find the store as well.  Recall that EmployeeHistory has ShopID.
select * from EmployeeHistory

--here is the query
select s.ShopName, e.EmployeeID, e.FirstName, e.LastName,
    h.StartDate, h.TerminationDate
from Employee e
    inner join EmployeeHistory h on e.EmployeeID = h.EmployeeID
    inner join Shop s on h.ShopID = s.ShopID
order by s.ShopName, e.LastName

--finally to show how to use with aggregrates, let show group by with a join
--how many current employees, past or present at each store?
select s.ShopName, count(1)
from Shop s
    inner join EmployeeHistory h on s.ShopID = h.ShopID
group by s.ShopName


-- The Product table has the following columns:ProductID, ProductName, ProductType, Price
-- CustomerOrderItem table has the following columns: CustomerOrderItemID, CustomerOrderID, ProductID, Quantity, SpecialInstructions
--- Can you create a query to return the following columns? CustomerOrderItemID, CustomerOrderID, ProductName, Price, Quantity

SELECT CustomerOrderItemID, CustomerOrderID, ProductName, Price, Quantity
FROM CustomerOrderItem AS c
INNER JOIN Product AS p
ON p.ProductID = c.ProductID
WHERE p.ProductType = 'P'

-- The CustomerOrder table has the following columns: CustomerOrderID, CustomerID, OrderTakerID, OrderDate, CouponID
-- And Customer has the following columns: CustomerID, PhoneNumber, Email, LastName, StreetAddress, City, StateProvidence, PostalCode
-- For your query include the following: CustomerOrderID, OrderDate, LastName, StreetAddress. Sort your result by OrderDate and LastName.
SELECT co.CustomerOrderID, co.OrderDate, c.LastName, c.StreetAddress
FROM CustomerOrder As co
INNER JOIN Customer AS c 
ON co.CustomerID = c.CustomerID
ORDER BY OrderDate, LastName

-- Create a query to return the following: OrderDate, LastName, StreetAddress, ProductName, Quantity, Price, TotalAmount
-- where the TotalAmount is the Quantity times Price.
-- order the result by TotalAmount in descending order
-- You can use the Product, CustomerOrderItem, CustomerOrder, and Customer tables to build your query.
-- The Product table has the following columns: ProductID, ProductName, ProductType, Price
-- CustomerOrderItem table has the following columns: CustomerOrderItemID, CustomerOrderID, ProductID, Quantity, SpecialInstructions
-- The CustomerOrder table has the following columns: CustomerOrderID, CustomerID, OrderTakerID, OrderDate, CouponID
-- And Customer has the following columns: CustomerID, PhoneNumber, Email, LastName, StreetAddress, City, StateProvidence, PostalCode
SELECT co.OrderDate, c.LastName, c.StreetAddress, p.ProductName, coi.Quantity, p.Price, coi.Quantity * p.Price AS TotalAmount
FROM  CustomerOrder AS co
JOIN Customer  AS c
    ON c.CustomerID = co.CustomerID
JOIN CustomerOrderItem AS coi
    ON co.CustomerOrderID = coi.CustomerOrderID
JOIN Product AS p
    ON p.ProductID = coi.ProductID
ORDER BY TotalAmount DESC