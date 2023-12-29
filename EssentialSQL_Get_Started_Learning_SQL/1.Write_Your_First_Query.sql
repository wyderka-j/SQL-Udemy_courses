-- Microsoft SQL Server

--show the entire table
select * from Customer

--select specific columns such as LastName, Email, and Phone
select LastName, Email, PhoneNumber
from Customer

--OK, so I don't like the column headers, can I change those?
--SQL Server
select LastName [Last Name], Email [Email Address], PhoneNumber [Phone Number]
from Customer

--we can also display expressions... here is one with math
select ProductID, ProductName, ProductType, Price
from Product

select ProductID, ProductName, ProductType, Price, Price * 1.04 ProposedPrice
from Product

select ProductID, ProductName, ProductType, Price, Price * 1.04 ProposedPrice, Price * 1.04 - Price PriceChage
from Product

--format SQL to make it easier to read
select ProductID, ProductName, ProductType, Price,
    Price * 1.04 ProposedPrice,
    Price * 1.04 - Price PriceChage
from Product

--maybe some help from algebra and an inline comment to explain. :)
select ProductID, ProductName, ProductType, Price,
    Price * 1.04 ProposedPrice,
    Price * .04  PriceChage -- Price * (1.04 - 1)
from Product

