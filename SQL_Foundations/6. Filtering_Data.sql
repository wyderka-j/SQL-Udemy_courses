-- MySQL

-- ------------------------------------------------------------------------------------------------
-- Filtering Data
-- ------------------------------------------------------------------------------------------------

USE DemoDB;

DROP TABLE Person;

CREATE TABLE Person (
   name  CHAR(50),
   address CHAR(200),
   dob DATE,
   ownAHouse BIT DEFAULT 0
);

INSERT INTO Person VALUES('A','Addr1','2001-01-21', 1);
INSERT INTO Person VALUES('B','Addr2','2001-02-21', 0);
INSERT INTO Person VALUES('AB','Addr1','2001-03-21', 1);
INSERT INTO Person VALUES('AC','Addr3','2001-04-21', 0);
INSERT INTO Person(name, address) VALUES('D','Addr2');

-- Retrieve all records
SELECT * FROM Person;

-- Retrieve all records whose name field or attribute value exactly matches with 'A'
SELECT * FROM Person
WHERE name = 'A';

-- Retrieve all records whose name field or attribute value starts with 'A'
SELECT * FROM Person
WHERE name LIKE 'A%';

-- Retrieve all records whose name field or attribute value starts with 'A' and followed by exactly one character
SELECT * FROM Person
WHERE name LIKE 'A_';

-- Retrieve all records whose name field or attribute value contains second letter as B
SELECT * FROM Person
WHERE name LIKE '_B%';

-- Retrieve all records whose address is either Addr1 or Addr3
SELECT * FROM Person
WHERE address = 'Addr1' OR address = 'Addr3';

SELECT * FROM Person
WHERE address IN ('Addr1', 'Addr3');

-- Retrieve all records whose address is not either Addr1 or Addr3
SELECT * FROM Person
WHERE address NOT IN ('Addr1', 'Addr3');

-- Retrieve all records whose date of birth is between '2001-01-21' and '2001-03-21'
SELECT * FROM Person
WHERE dob BETWEEN '2001-01-21' AND '2001-03-21';

-- Retrieve those records whose ownAHouse field value is 1 and the month part of the dob field matches with 3 i.e. March.
SELECT * FROM  Person
WHERE ownAHouse = 1 AND MONTH(dob) = 3;
