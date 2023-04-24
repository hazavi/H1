USE MASTER
IF DB_ID('BBB_LAUNDRY') IS NOT NULL
BEGIN
	ALTER DATABASE BBB_LAUNDRY SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE BBB_LAUNDRY
END

CREATE DATABASE BBB_LAUNDRY

USE BBB_LAUNDRY

CREATE TABLE Laundry (
ID INT  IDENTITY(1,1) PRIMARY KEY,
[Name] NVARCHAR(20) NOT NULL,
[Open] TIME NOT NULL, --åben/luk
[Close] TIME NOT NULL,
)

CREATE TABLE Customer (
ID INT  IDENTITY(1,1) PRIMARY KEY,
[Name] NVARCHAR(50) NOT NULL,
Email NVARCHAR(50) UNIQUE,
[Password] NVARCHAR(MAX) NOT NULL CHECK (LEN([Password]) >= 5),
Account DECIMAL NOT NULL,
LaundryID INT FOREIGN KEY REFERENCES Laundry(ID),
AccountCreated DATE NOT NULL
)

CREATE TABLE Machine (
ID INT  IDENTITY(1,1) PRIMARY KEY,
[Name] NVARCHAR(50) NOT NULL,
Price DECIMAL NOT NULL,
WashTime INT NOT NULL, --HVOR MANGE MINUTTER DEN TAGER
LaundryID INT FOREIGN KEY REFERENCES Laundry(ID)
)

CREATE TABLE Bookings (
ID INT  IDENTITY(1,1) PRIMARY KEY,
DateAndTime DATETIME NOT NULL,
CustomerID INT FOREIGN KEY REFERENCES Customer(ID),
MachineID INT FOREIGN KEY REFERENCES Machine(ID)
)

--- INSERT Laundry
INSERT INTO Laundry([Name], [Open], [Close]) VALUES ('Whitewash Inc.', '08:00', '20:00')
INSERT INTO Laundry([Name], [Open], [Close]) VALUES ('Double Bubble', '02:00', '22:00')
INSERT INTO Laundry([Name], [Open], [Close]) VALUES ('Wash & Coffee', '12:00', '20:00')

--- INSERT Customer
INSERT INTO Customer([Name], [Email], [Password], [Account], [LaundryID],AccountCreated) 
VALUES ('John', 'john_doe66@gmail.com', 'password', 100.00, 2, '2021-02-15' )

INSERT INTO Customer([Name], [Email], [Password], [Account], [LaundryID],AccountCreated) 
VALUES ('Neil Armstrong', 'firstman@nasa.gov', 'eagleLander69', 1000.00, 1, '2021-02-10' )

INSERT INTO Customer([Name], [Email], [Password], [Account], [LaundryID],AccountCreated) 
VALUES ('Batman', 'noreply@thecave.com', 'Rob1n', 500.00, 3, '2020-03-10' )

INSERT INTO Customer([Name], [Email], [Password], [Account], [LaundryID],AccountCreated) 
VALUES ('Goldman Sachs', 'moneylaundering@gs.com', 'NotRecognized', 100000.00, 1, '2021-01-01' )

INSERT INTO Customer([Name], [Email], [Password], [Account], [LaundryID],AccountCreated) 
VALUES ('50 Cent', '50cent@gmail.com', 'ItsMyBirthday', 0.50, 3, '2020-07-06' )

--- INSERT MACHINE
INSERT INTO Machine([Name], [Price], [WashTime], [LaundryID]) VALUES ('Mielle 911 Turbo', 5.00 , 60, 2 )
INSERT INTO Machine([Name], [Price], [WashTime], [LaundryID]) VALUES ('Siemons IClean', 10000.00, 30 , 1 )
INSERT INTO Machine([Name], [Price], [WashTime], [LaundryID]) VALUES ('Electrolax FX-2', 15.00, 45 , 2 )
INSERT INTO Machine([Name], [Price], [WashTime], [LaundryID]) VALUES ('NASA Spacewasher 8000', 500.00, 5 , 1 )
INSERT INTO Machine([Name], [Price], [WashTime], [LaundryID]) VALUES ('The Lost Sock', 3.50, 90 , 3 )
INSERT INTO Machine([Name], [Price], [WashTime], [LaundryID]) VALUES ('Yo Mama', 0.50, 120 , 3 )

--- INSERT BOOKINGS
INSERT INTO Bookings([DateAndTime], CustomerID, MachineID) VALUES ('2021-02-26 12:00:00', 1, 1)
INSERT INTO Bookings([DateAndTime], CustomerID, MachineID) VALUES ('2021-02-26 16:00:00', 1, 3)
INSERT INTO Bookings([DateAndTime], CustomerID, MachineID) VALUES ('2021-02-26 08:00:00', 2, 4)
INSERT INTO Bookings([DateAndTime], CustomerID, MachineID) VALUES ('2021-02-26 15:00:00', 3, 5)
INSERT INTO Bookings([DateAndTime], CustomerID, MachineID) VALUES ('2021-02-26 20:00:00', 4, 2)
INSERT INTO Bookings([DateAndTime], CustomerID, MachineID) VALUES ('2021-02-26 19:00:00', 4, 2)
INSERT INTO Bookings([DateAndTime], CustomerID, MachineID) VALUES ('2021-02-26 10:00:00', 4, 2)
INSERT INTO Bookings([DateAndTime], CustomerID, MachineID) VALUES ('2021-02-26 16:00:00', 5, 6)

GO
BEGIN TRANSACTION 
INSERT INTO BookingS (DateAndTime, CustomerID, MachineID) VALUES (
'2023-02-03 12:00:00', 
(SELECT TOP 1 Id FROM Customer WHERE [Name] like 'Goldman Sachs'),
(SELECT TOP 1 Id FROM Machine WHERE [Name] like 'Siemens IClean')
)
COMMIT TRANSACTION
GO

CREATE VIEW BookingView AS
SELECT FORMAT(Bookings.DateAndTime, 'dddd dd. MMMM yyyy HH:mm') AS [Time], Customer.[Name] AS Customer, 
Machine.[Name] AS Machine, Machine.Price
FROM Bookings
JOIN Customer ON Bookings.CustomerID = Customer.ID
JOIN Machine ON Bookings.MachineID = Machine.ID
GO

SELECT * FROM BookingView

SELECT * FROM Customer WHERE Email like '%@gmail.com'

SELECT * FROM Machine, Laundry WHERE Machine.LaundryID = Laundry.ID

SELECT Count(Bookings.MachineID) AS 'N of B', Machine.[Name] 
FROM Bookings, Machine WHERE Bookings.MachineID = Machine.Id
GROUP BY Machine.[Name] 

DELETE FROM Bookings WHERE CAST(Bookings.DateAndTime AS TIME) BETWEEN '12:00' AND '13:00'

UPDATE Customer SET [Password] = 'SelenaKyle' WHERE [Name] = 'Batman'
