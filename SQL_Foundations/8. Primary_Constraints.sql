-- MySQL

-- ------------------------------------------------------------------------------------------------
-- Primary Constraints
-- ------------------------------------------------------------------------------------------------

USE DemoDB;
 
DROP TABLE Person;
 
CREATE TABLE Person (
  name    CHAR(50) UNIQUE NOT NULL,
  address CHAR(200),
  dob     DATE    NOT NULL
);
 
INSERT INTO Person VALUES('A','Addr1', '2001-03-21');
 
-- Insert will fail as name should be unique 'A' is already present.
INSERT INTO Person VALUES('A', 'Addr2', '2001-03-22');
 
-- Insert will fail as name should not be null.
INSERT INTO Person VALUES(null, 'Addr2', '2001-03-22');
 
 
SELECT * FROM Person;