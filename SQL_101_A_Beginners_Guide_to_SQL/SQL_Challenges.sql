-- MySQL

-- ------------------------------------------------------------------------------------------------------------------
--  6. SQL Challenges
-- ------------------------------------------------------------------------------------------------------------------

-- 1. Challenge 
-- ---------------------------------------------
CREATE TABLE sales (
  sale_id int(6) NOT NULL,
  product_id int(6) NOT NULL,
  year int(4) NOT NULL,
  quantity int(6) NOT NULL,
  price int(6)  NOT NULL
);

INSERT INTO sales (sale_id, product_id, year, quantity, price) VALUES
(1, 100, 2008, 10, 5000),
(2, 100, 2009, 12, 5000),
(7, 100, 2011, 15, 9000);

CREATE TABLE  product (
  product_id int(6) NOT NULL,
  product_name varchar(200) NOT NULL
);

INSERT INTO product (product_id, product_name) VALUES
(100, "Nokia"),
(200, "Apple"),
(300, "Samsung");

-- Write an SQL query that reports all product names of the products in the Sales table along with their selling year and price.
SELECT
    p.product_name,
    s.year,
    s.price
FROM product p
INNER JOIN sales s
ON s.product_id = p.product_id;

-- 2. Challenge 
-- ---------------------------------------------
CREATE TABLE employee (
  id int(6) NOT NULL,
  name varchar(100) NOT NULL,
  salary int(6) NOT NULL,
  managerId int(6) 
);

INSERT INTO employee (id, name, salary, managerId) VALUES
(1, "Joe", 7000, 3),
(2, "Henry", 8000,4),
(3, "Sam", 6000, NULL),
(4, "Max", 9000, NULL);

-- Write an SQL query that finds employees who earn more than their managers.
SELECT e1.Name as Employee
FROM Employee e1
INNER JOIN Employee e2
ON e1.managerId = e2.id
AND e1.salary > e2.salary;
