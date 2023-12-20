-- MySQL

-- ------------------------------------------------------------------------------------------------
--  Identity Column
-- ------------------------------------------------------------------------------------------------

use DemoDB;

CREATE TABLE Course (
	id  INT  UNIQUE AUTO_INCREMENT,
	name VARCHAR(100)
);

INSERT INTO Course(name) VALUES('A');

INSERT INTO Course(name) VALUES('B');

SELECT * FROM Course;

-- Adjusting the auto_increment to the desired value
ALTER TABLE Course AUTO_INCREMENT = 100;