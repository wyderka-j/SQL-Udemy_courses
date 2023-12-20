-- MySQL

-- ------------------------------------------------------------------------------------------------
-- Updating and Delete
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

SELECT * FROM Person;

SET SQL_SAFE_UPDATES = 0;

-- Updates all the records and sets the ownAHouse field value to 1
UPDATE Person SET ownAHouse = 1;

-- Updates only those records whose name is 'A' and sets the address field value to Addr99
UPDATE Person SET address = 'Addr99'
WHERE name = 'A';

-- Updates the dob field value to the given value where the field value is null
UPDATE Person SET dob = '2001-05-21'
WHERE dob IS NULL;

-- DELETE

-- deletes those records whose name is AB
DELETE FROM Person
WHERE name = 'AB';

-- truncate the entire table Person
TRUNCATE TABLE Person;
