USE MASTER 

CREATE DATABASE KORRUPTELANDE

USE KORRUPTELANDE

CREATE TABLE Top5MindstKorruptelande(
Id INT IDENTITY (1,1),
Score INT,
Land NVARCHAR(20)

)

INSERT INTO Top5MindstKorruptelande (Score, Land) VALUES (90, 'Denmark')
INSERT INTO Top5MindstKorruptelande (Score, Land) VALUES (87, 'Finland')
INSERT INTO Top5MindstKorruptelande (Score, Land) VALUES (87, 'New Zealand')
INSERT INTO Top5MindstKorruptelande (Score, Land) VALUES (84, 'Norge')
INSERT INTO Top5MindstKorruptelande (Score, Land) VALUES (83, 'Singapore')

SELECT * FROM Top5MindstKorruptelande

CREATE TABLE Top5Korruptelande(
Id INT IDENTITY (1,1),
Score INT,
Land NVARCHAR(20)
)

INSERT INTO Top5Korruptelande (Score, Land) VALUES (12, 'Somalia')
INSERT INTO Top5Korruptelande (Score, Land) VALUES (13, 'Syrien')
INSERT INTO Top5Korruptelande (Score, Land) VALUES (13, 'Sydsudan')
INSERT INTO Top5Korruptelande (Score, Land) VALUES (14, 'Venezuela')
INSERT INTO Top5Korruptelande (Score, Land) VALUES (16, 'Yemen')

SELECT * FROM Top5Korruptelande

