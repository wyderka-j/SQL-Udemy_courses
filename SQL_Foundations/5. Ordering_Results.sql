-- MySQL

-- ------------------------------------------------------------------------------------------------
-- Arranging the data before display
-- ------------------------------------------------------------------------------------------------

USE DemoDB;

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
INSERT INTO Person (name, address) VALUES('D','Addr2');

SELECT * FROM Person;

SELECT * FROM Person
ORDER BY dob DESC;

SELECT * FROM Person
ORDER BY dob;

SELECT * FROM Person
ORDER BY ownAHouse, dob;

SELECT * FROM Person
ORDER BY ownAHouse DESC, dob;

SELECT * FROM Person
ORDER BY 4;

