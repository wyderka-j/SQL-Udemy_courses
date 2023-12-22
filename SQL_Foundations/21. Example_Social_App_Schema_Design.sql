-- MySQL

-- ------------------------------------------------------------------------------------------------
--  Example Social App Schema Design
-- ------------------------------------------------------------------------------------------------

CREATE SCHEMA SocialDB DEFAULT CHARACTER SET 'utf8';
 
USE SocialDB;
 
-- USER
 
CREATE TABLE UserProfile (
    UserProfileID  INTEGER PRIMARY KEY AUTO_INCREMENT,
    UserName	   VARCHAR(20) UNIQUE NOT NULL,
    Password	   VARCHAR(20) NOT NULL,
    Email          VARCHAR(40) UNIQUE NOT NULL,
    FirstName	   VARCHAR(20) NOT NULL,
    MiddleName	   VARCHAR(20),
    LastName	   VARCHAR(20) NOT NULL,
    CreatedDTTM    DATETIME	NOT NULL DEFAULT NOW(),
    UpdatedDTTM	   DATETIME,
    IsDeleted	   BIT NOT NULL DEFAULT 0
);
 
INSERT INTO UserProfile(UserName, Password, Email, FirstName, LastName)
VALUES('a','a','a@test.com','a','a');
 
INSERT INTO UserProfile(UserName, Password, Email, FirstName, LastName)
VALUES('b','b','b@test.com','b','b');
 
INSERT INTO UserProfile(UserName, Password, Email, FirstName, LastName)
VALUES('c','c','c@test.com','c','c');
 
INSERT INTO UserProfile(UserName, Password, Email, FirstName, LastName)
VALUES('d','d','d@test.com','d','d');
 
SELECT * FROM UserProfile;
 
-- UserProfileExt <-- 1-1 --> UserProfile
-- tinytext - 255, text - 64k, mediumtext - 16mb, longtext - 4gb
 
CREATE TABLE UserProfileExt (
    UserProfileExtID  INTEGER PRIMARY KEY AUTO_INCREMENT,
    UserProfileID     INTEGER UNIQUE NOT NULL,
    ProfileImage      VARCHAR(100),
    Phone 	     	  VARCHAR(12),
    Website	      	  VARCHAR(100),
    HeadLine	      VARCHAR(256),
    Country	       	  VARCHAR(50),
    Summary 	      TEXT,
    CONSTRAINT fk_userprofileid  FOREIGN KEY (UserProfileID) REFERENCES UserProfile(UserProfileID)
);
 
INSERT INTO UserProfileExt(UserProfileID, ProfileImage, Phone)
VALUES(1, '/storage/1/image.png', '1234');
 
SELECT * FROM UserProfileExt;
 
-- Display the user info along with profile extensions.
 
SELECT * FROM UserProfile;
 
SELECT * FROM UserProfile AS u
LEFT OUTER JOIN UserProfileExt AS upe ON (u.UserProfileID = upe.UserProfileID);
 
-- User Connections
-- Many users can get connected with many users.
-- Many users can follow many users.
 
CREATE TABLE UserConnection (
    UserOne  INTEGER NOT NULL,
    UserTwo  INTEGER NOT NULL,
    IsConnection BIT NOT NULL,
    IsFollower BIT NOT NULL,
    ConnectedDTTM DATETIME NOT NULL DEFAULT NOW(),
    CONSTRAINT fk_userone_userprofileid FOREIGN KEY(UserOne) REFERENCES UserProfile(UserProfileID),
    CONSTRAINT fk_usertwo_userprofileid FOREIGN KEY(UserTwo) REFERENCES UserProfile(UserProfileID)
);
 
-- a connected with b
-- (a, b) and (b, a)
 
INSERT INTO UserConnection VALUES(1, 2, 1, 0, NOW());
INSERT INTO UserConnection VALUES(2, 1, 1, 0, NOW());
 
 
-- (a, c) and (c, a)
 
INSERT INTO UserConnection VALUES(1, 3, 1, 0, NOW());
INSERT INTO UserConnection VALUES(3, 1, 1, 0, NOW());
 
-- (a, d) d follows a 
 
INSERT INTO UserConnection VALUES(1, 4, 0, 1, NOW());
 
SELECT * FROM UserConnection;
 
-- Get the connections of a.
 
-- Solved using subqueries.
 
SELECT UserName FROM UserProfile
WHERE UserProfileID IN (
    SELECT UserTwo FROM UserConnection
    WHERE UserOne = (SELECT UserProfileID FROM UserProfile WHERE UserName = 'a')
    AND IsConnection = 1
);
 
-- using joins
 
SELECT UserName FROM UserProfile AS u
INNER JOIN UserConnection AS uc 
ON (u.UserProfileID = uc.UserTwo 
    AND uc.UserOne = (SELECT UserProfileID FROM UserProfile WHERE UserName = 'a')
    AND uc.IsConnection = 1);
 
 
-- Problem-1 : Write a query to retreive all the followers of 'a'
--             Note:- followers includes connections + only followers.
 
SELECT UserName FROM UserProfile
WHERE UserProfileID IN ( 
	SELECT UserTwo FROM UserConnection
	WHERE UserOne = 1 
);
 
 
-- User Posts
-- One user can post many posts.
 
CREATE TABLE Post (
    PostID   INTEGER PRIMARY KEY AUTO_INCREMENT,
    Title    VARCHAR(200) NOT NULL,
    Content  TEXT NOT NULL,
    PostedBy INTEGER NOT NULL,
    PostedDTTM DATETIME NOT NULL DEFAULT NOW(),
    CONSTRAINT fk_postedby FOREIGN KEY(PostedBy) REFERENCES UserProfile(UserProfileID)
);
 
INSERT INTO Post(Title, Content, PostedBy)
VALUES('SamplePost','Sample Post Content', 1);
 
SELECT * FROM Post;
 
-- Post likes
 
CREATE TABLE PostLike (
    PostLikeID INTEGER PRIMARY KEY AUTO_INCREMENT,
    PostID     INTEGER NOT NULL,
    LikedBy    INTEGER NOT NULL,
    ActionDTTM DATETIME NOT NULL DEFAULT NOW(),
    CONSTRAINT fk_postid FOREIGN KEY(PostID) REFERENCES Post(PostID),
    CONSTRAINT fk_likedby FOREIGN KEY(LikedBy) REFERENCES UserProfile(UserProfileID),
    CONSTRAINT unq_postid_likedby UNIQUE(PostID, LikedBy)
);
 
INSERT INTO PostLike(PostID, LikedBy)
VALUES(1, 2);
 
INSERT INTO PostLike(PostID, LikedBy)
VALUES(1, 3);
 
SELECT * FROM PostLike;
 
 
-- Post Comment
 
CREATE TABLE PostComment (
    PostCommentID INTEGER PRIMARY KEY AUTO_INCREMENT,
    PostID        INTEGER NOT NULL,
    CommentForCommentID  INTEGER,
    CommentText   TEXT NOT NULL,
    CommentedBy   INTEGER NOT NULL,
    CommentedDTTM DATETIME NOT NULL DEFAULT NOW(),
    CONSTRAINT fk_postid_postcomment FOREIGN KEY(PostID) REFERENCES Post(PostID),
    CONSTRAINT fk_commentedby FOREIGN KEY(CommentedBy) REFERENCES UserProfile(UserProfileID),
    CONSTRAINT fk_comment_for_comment FOREIGN KEY(CommentForCommentID) REFERENCES PostComment(PostCommentID) 
);
 
INSERT INTO PostComment(PostID, CommentText, CommentedBy)
VALUES(1, 'good post', 2);
 
INSERT INTO PostComment(PostID, CommentForCommentID, CommentText, CommentedBy)
VALUES(1, 1, 'well said', 3);
 
SELECT * FROM PostComment;
 
-- retrieve the posts posted by 'a'
 
SELECT * FROM Post
WHERE PostedBy = (SELECT UserProfileID FROM UserProfile WHERE username = 'a');
 
-- retrieve the no of likes for postID - 1
 
SELECT COUNT(*) FROM PostLike 
WHERE PostID = 1;
 
 
-- Problem - 2
 
-- Design tables for User Experience, Publications, Skills, Endorsements.
 
-- Experience(UserProfileID, CompanyName, StartDate, EndDate, JobTitle, JD )
-- Publication(UserProfileID, Url, PublishedDate, Title, Description)
-- Skill(UserProfileID, SkillName)
-- SkillEndorsement(SkilID, EndorsedBy)

CREATE TABLE Experience(
   ExperienceID INTEGER PRIMARY KEY AUTO_INCREMENT,
   UserProfileID INTEGER NOT NULL,
   CompanyName VARCHAR(100) NOT NULL, 
   StartDate DATETIME NOT NULL, 
   EndDate DATETIME, 
   JobTitle VARCHAR(100), 
   JD TEXT,
   CONSTRAINT fk_userprofileid_exp FOREIGN KEY(UserProfileID) REFERENCES UserProfile(UserProfileID)
);
 
 CREATE TABLE Publication(
   PublicationID INTEGER PRIMARY KEY AUTO_INCREMENT,
   UserProfileID INTEGER NOT NULL,
   Url VARCHAR(100), 
   PublishedDate DATE, 
   Title VARCHAR(100) NOT NULL, 
   Description TEXT,
   CONSTRAINT fk_userprofileid_publication FOREIGN KEY(UserProfileID) REFERENCES UserProfile(UserProfileID)
); 
 
 CREATE TABLE Skill(
  SkillID INTEGER PRIMARY KEY AUTO_INCREMENT,
  UserProfileID INTEGER NOT NULL,
  SkillName VARCHAR(50) NOT NULL,
  CONSTRAINT fk_userprofileid_skill FOREIGN KEY(UserProfileID) REFERENCES UserProfile(UserProfileID),
  CONSTRAINT unq_userprofileid_skill UNIQUE(UserProfileID, SkillName)
);

CREATE TABLE SkillEndorsement(
    SkillEndorsementID INTEGER PRIMARY KEY AUTO_INCREMENT,
    SkillID INTEGER NOT NULL, 
    EndorsedBy INTEGER NOT NULL,
    CONSTRAINT fk_skill_id_endorsement FOREIGN KEY(SkillID) REFERENCES Skill(SkillID),
    CONSTRAINT fk_endorsedby_endorsement FOREIGN KEY(EndorsedBy) REFERENCES UserProfile(UserProfileID),
    CONSTRAINT unq_skill_endorsment UNIQUE(SkillID, EndorsedBy)
);
