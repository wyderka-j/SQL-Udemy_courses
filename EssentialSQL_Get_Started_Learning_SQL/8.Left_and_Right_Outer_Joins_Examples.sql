

--What products haven't been ordered?
select p.ProductName, coi.Quantity
from Product p
    left outer join CustomerOrderItem coi on p.ProductId = coi.ProductID
order by coi.Quantity desc

--Answer
select p.ProductName, coi.Quantity
from Product p
    left outer join CustomerOrderItem coi on p.ProductId = coi.ProductID
where coi.quantity is null
order by coi.Quantity desc

--What would that look like as a right join?


--Will this work?
select p.ProductName, coi.Quantity
from Product p
    left outer join CustomerOrderItem coi on p.ProductId = coi.ProductID and coi.quantity is null
order by coi.Quantity desc

--why doesn't it work?
select p.ProductName, coi.Quantity, p.ProductId, coi.ProductID
from Product p
    left outer join CustomerOrderItem coi on p.ProductId = coi.ProductID and coi.quantity is null
order by coi.Quantity desc

--huh?
select p.ProductName, coi.Quantity, p.ProductId, coi.ProductID
from Product p
    left outer join CustomerOrderItem coi on p.ProductId = coi.ProductID --and coi.quantity is null
order by coi.Quantity desc
