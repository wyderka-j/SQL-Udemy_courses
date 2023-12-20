-- MySQL

-- ------------------------------------------------------------------------------------------------
--  Identity Column
-- ------------------------------------------------------------------------------------------------

USE DemoDB;

CREATE TABLE UserProfile(
   userProfileID INT PRIMARY KEY AUTO_INCREMENT,
   firstName  VARCHAR(50) NOT NULL,
   lastName   VARCHAR(50) NOT NULL,
   middleName VARCHAR(50), 
   userName   VARCHAR(20) UNIQUE NOT NULL,
   password   VARCHAR(20),
   email      VARCHAR(50) UNIQUE NOT NULL,
   isActive   BIT NOT NULL DEFAULT 1,
   isLocked   BIT NOT NULL DEFAULT 0,
   createdDTTM DATETIME NOT NULL DEFAULT NOW(), 
   lastModifiedDTTM DATETIME
);

-- Keys
--   userProfileID - Primary Key (unique + not null) - only one primary key per table.
--   userName
--   email


DESC UserProfile;