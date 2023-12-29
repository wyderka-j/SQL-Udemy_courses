select * from employee

--lets say we want to add an employee to the employee table.
--how would we do that?  Well we can use the INSERT statement.

--here is an example of us adding Brian Todor to the table.
insert into Employee (EmployeeID, FirstName, LastName) values (10, 'Brian', 'Todor')

--now let's check our work:
select * from employee

--here is how to add two employeed
insert into employee (EmployeeID, FirstName, LastName) values 
    (11, 'Mary', 'Quinn'),
    (12, 'Janet', 'Limno')

--
select * from employee

--What happens if we need to Change Janet Limno to Janet Lumno?
select *
from Employee
where EmployeeID = 12

--We can use update.
update Employee
set LastName = 'Lumno'
where EmployeeID = 12  --<WHERE clause is super important.

--
select * from employee

--so how can we remove the rows we just added?
select *
from Employee
where EmployeeID >= 10

--we can use delete
delete from Employee
where EmployeeID >= 10

--
select * from employee

