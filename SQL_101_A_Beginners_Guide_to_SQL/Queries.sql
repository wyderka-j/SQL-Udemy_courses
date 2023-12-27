-- MySQL

-- ------------------------------------------------------------------------------------------------------------------
-- Tasks
-- ------------------------------------------------------------------------------------------------------------------

CREATE DATABASE SQL_101_Beginners_Guide;

USE SQL_101_Beginners_Guide;

-- 1. Introduction To SQL
-- ---------------------------------------------

-- We are going to create a table in sql. copy/paste the code
CREATE TABLE IF NOT EXISTS `docs` (
  `id` int(6) unsigned NOT NULL,
  `rev` int(3) unsigned NOT NULL,
  `content` varchar(200) NOT NULL,
  PRIMARY KEY (`id`,`rev`)
) DEFAULT CHARSET=utf8;
INSERT INTO `docs` (`id`, `rev`, `content`) VALUES
  ('1', '1', 'The earth is flat'),
  ('2', '1', 'One hundred angels can dance on the head of a pin'),
  ('1', '2', 'The earth is flat and rests on a bull\'s horn'),
  ('1', '3', 'The earth is like a ball.');
  
-- Question: How many records were returned when you ran the query?
SELECT * from docs;

DROP TABLE docs;

-- 2. Basic Queries
-- ---------------------------------------------

CREATE TABLE products (
  id int(6)  NOT NULL,
  brand varchar(200) NOT NULL,
  name varchar(200) NOT NULL,
  price decimal(10,2) NOT NULL,
  class_id int(6)  NOT NULL
);

INSERT INTO products (id, brand, name, price, class_id) VALUES
(1, "Pepsi", "Cola", .99, 1),
(2, "Pepsi", "Diet Cola", .99, 2),
(3, "Pepsi", "MtDew", .99, 2),
(4, "CocaCola", "Coke", 4.99,1),
(5, "CocaCola", "Diet Coke", 4.99,2),
(6, "CocaCola", "Sprite", 4.99,3),
(7, "Natural", " BestCola", 4.99,1),
(8, "Natural", "Diet Cola", 4.99,2),
(9, "Natural", "Mr Pepper", 4.99,3),
(10, "Natural", "Morning Dew", 4.99,3),
(11, "Natural", "Sparkle Water", 4.99,3),
(12, "Natural", "Water", 4.99,2);

-- Questions:

-- From the products table, how would you list all of the brands, without any duplicates?
SELECT DISTINCT brand
FROM products;

-- From the products table, write a query that shows the id column (but rename the column to product_id) and the name column (but rename the name column
--  to product_name)
SELECT id AS product_id, name AS product_name
FROM products;

-- From the products table, select the brand name of all brands that have at least one product priced < 3.00. Be sure to avoid duplicate brand names.
SELECT DISTINCT brand
FROM products
WHERE price < 3.00;

-- From the products table, select all product names from the brand Pepsi and name the column product_name
SELECT name AS product_name
FROM products
WHERE brand = 'Pepsi';

-- drop
DROP TABLE products;

-- 3. Aggregates Queries
-- ---------------------------------------------

CREATE TABLE products (
  product_id int(6)  NOT NULL,
  brand_id int(6) NOT NULL,
  name varchar(200) NOT NULL,
  price decimal(10,2) NOT NULL,
  class_id int(6)  NOT NULL
);

INSERT INTO products (product_id, brand_id, name, price, class_id) VALUES
(1, 1, "Cola", .99, 1),
(2, 1, "Diet Cola", .99, 2),
(3, 1, "MtDew", .99, 2),
(4, 2, "Coke", 4.99,1),
(5, 2, "Diet Coke", 4.99,2),
(6, 2, "Sprite", 4.99,3),
(7, 3, " BestCola", 4.99,1),
(8, 3, "Diet Cola", 4.99,2),
(9, 3, "Mr Pepper", 4.99,3),
(10, 3, "Morning Dew", 4.99,3),
(11, 3, "Sparkle Water", 4.99,3),
(12, 3, "Water", 4.99,2);

CREATE TABLE brands (
  brand_id int(6) NOT NULL,
  brand_name varchar(200) NOT NULL
);

INSERT INTO brands (brand_id, brand_name) VALUES
(1, "Pepsi"),
(2, "CocaCla"),
(4, "DrSoda");

-- Questions:

-- From the products table, what is the average price for all products?
SELECT AVG(price) 
FROM products;

-- From the products table, what is the max and min price per brand?
SELECT MAX(price), MIN(price), brand_id
FROM products
GROUP BY brand_id;

-- From the product table, which brands have an average price > 1
SELECT brand_id
FROM products
GROUP BY brand_id
HAVING AVG(price) > 1;

-- drop 
DROP TABLE products;
DROP TABLE brands;

-- 4. Intro to Joins
-- ---------------------------------------------

-- Questions:

-- Write a query to join the Products and Brands table showing all product names and brand_names, only where both are present.
SELECT p.name, b.brand_name
FROM products p
INNER JOIN brands b
ON p.brand_id = b.brand_id;

-- Write a query to show all brand names without products. Hint you will need to use  WHERE p.brand_id IS NULL after the join.
SELECT b.brand_name
FROM brands b
LEFT JOIN products p
ON p.brand_id = b.brand_id
WHERE p.brand_id IS NULL;

-- Write a query to show all the product name and brand name for all products under the Pepsi brand where class_id is 2.
SELECT p.name, b.brand_name
FROM products p
INNER JOIN brands b
ON p.brand_id = b.brand_id
WHERE b.brand_name = "Pepsi"
AND p.class_id = 2;


-- drop 
DROP TABLE products;
DROP TABLE brands;

-- 5. Additional SQL Operators
-- ---------------------------------------------
CREATE TABLE products (
  product_id int(6)  NOT NULL,
  brand_id int(6) NOT NULL,
  name varchar(200) NOT NULL,
  price decimal(10,2) NOT NULL,
  class_id int(6)  NOT NULL
);

INSERT INTO products (product_id, brand_id, name, price, class_id) VALUES
(1, 1, "Cola", .99, 1),
(2, 1, "Diet Cola", .99, 2),
(3, 1, "MtDew", .99, 2),
(4, 2, "Coke", 4.99,1),
(5, 2, "Diet Coke", 4.99,2),
(6, 2, "Sprite", 4.99,3),
(7, 3, " BestCola", 4.99,1),
(8, 3, "Diet Cola", 4.99,2),
(9, 3, "Mr Pepper", 4.99,3),
(10, 3, "Morning Dew", 4.99,3),
(11, 3, "Sparkle Water", 4.99,3),
(12, 3, "Water", 4.99,2);

CREATE TABLE brands (
  brand_id int(6) NOT NULL,
  brand_name varchar(200) NOT NULL
);

INSERT INTO brands (brand_id, brand_name) VALUES
(1, "Pepsi"),
(2, "CocaCla"),
(4, "DrSoda");

-- Questions:

-- From the products table select the product name and a new column called freePrice. Use a case statement to populate the freePrice column with 0.0 if 
-- the class_id is 2, otherwise populate free price with the normal price.
SELECT
  name,
  CASE WHEN class_id = 2 THEN 0.0 ELSE price END AS freePrice
FROM products;

-- From the products table, write a query that returns product names that start with D. Write the query so that there are no duplicates.
SELECT DISTINCT name
FROM products
WHERE name like "D%";

-- From the products table select the product name and product price. Order the results by descending price. If multiple products have the same price, 
-- order next by ascending name. Limit your query to 2 results.
SELECT name, price
FROM products
ORDER BY price DESC, name
LIMIT 2;

-- From the products table, write a query to select the product name and a new column is_cola. If the product name has Cola in the name, is_cola should 
-- be 'true' otherwise is_cola should be 'false'.
SELECT
  name,
  CASE WHEN name LIKE "%Cola%" THEN "true" ELSE "false" END AS is_cola
FROM products
ORDER BY price DESC, class_id DESC
LIMIT 5;
