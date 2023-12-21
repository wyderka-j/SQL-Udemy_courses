-- MySQL

-- ------------------------------------------------------------------------------------------------
--  Aggregate Functions
-- ------------------------------------------------------------------------------------------------
 
 USE DemoDB;
  
-- Create  
 
CREATE TABLE Student (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    Name      VARCHAR(50),
    Course    VARCHAR(10),
    Score     NUMERIC(5,2)
); 
 
-- Insert Sample Records 
 
INSERT INTO Student(Name, Course, Score) VALUES('A', 'CS', 80);
INSERT INTO Student(Name, Course, Score) VALUES('B', 'CS', 60);
INSERT INTO Student(Name, Course, Score) VALUES('C', 'IT', 70);
INSERT INTO Student(Name, Course, Score) VALUES('D', 'IT', 85);
INSERT INTO Student(Name, Course, Score) VALUES('E', 'ECE', 88);
 
 
-- Retrieve all records
 
SELECT * FROM Student;
 
-- Retrieves the total score and displays the resultant column as Total which is called as an alias name.
 
SELECT SUM(Score) AS Total FROM Student;
	
-- Display the minimum score
    
SELECT MIN(Score) AS Minimum FROM Student;
	
-- Display the maximum score
    
SELECT MAX(Score) AS Maximum FROM Student;
	
-- Display the average score
    
SELECT AVG(Score) AS Average FROM Student;
	
-- Count(*) returns the record count
    
SELECT COUNT(*) AS TotalStudents FROM Student;
 
-- Retrieves the record count for which the Score is greater than 80.
 
SELECT COUNT(*) AS TopScorers FROM Student
WHERE Score > 80;

-- Drop 

	DROP TABLE Student;