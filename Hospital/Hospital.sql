use Hospital;

CREATE TABLE Departments
(
     ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
     [Name] NVARCHAR(100) CHECK ([Name] != ' ') UNIQUE NOT NULL,
     [Building] INT CHECK ([Building] BETWEEN 1 AND 5) NOT NULL,
     [Financing] MONEY DEFAULT 0 CHECK ([Financing] > 0) NOT NULL,
     [Floor] INT CHECK ([Floor] >= 1) NOT NULL
);

CREATE TABLE Diseases
(
     ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
     [Name] NVARCHAR(100) CHECK ([Name] != ' ') UNIQUE NOT NULL,
     [Severity] INT DEFAULT 1 CHECK ([Severity] >= 1) NOT NULL
);

CREATE TABLE Doctors
(
    ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
    [Name] NVARCHAR(MAX) CHECK ([Name] != ' ') NOT NULL,
    [Surname] NVARCHAR(MAX) CHECK ([Surname] != ' ') NOT NULL,
    [Phone] CHAR(10) NOT NULL,
    [Salary] MONEY CHECK (Salary > 0) NOT NULL,
    [Premium] MONEY DEFAULT 0 CHECK (Premium > 0) NOT NULL
);

CREATE TABLE Examinations
(
     ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
     [Name] NVARCHAR(100) CHECK ([Name] != ' ') UNIQUE NOT NULL,
     [DayOfWeek] INT CHECK ([DayOfWeek] BETWEEN 1 AND 7),
     [StartTime] TIME CHECK ([StartTime] BETWEEN '08:00' AND '18:00') NOT NULL,
     [EndTime] TIME NOT NULL,
     CONSTRAINT CHK_EndTime CHECK ([EndTime] > [StartTime])
);

CREATE TABLE Wards
(
     ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
     [Name] NVARCHAR(20) CHECK ([Name] != ' ') UNIQUE NOT NULL,
     [Building] INT CHECK ([Building] BETWEEN 1 AND 5) NOT NULL,
     [Floor] INT CHECK ([Floor] >= 1) NOT NULL,
);





SELECT [Name] AS [Department Name], [Building] AS [Department Building], [Financing] AS [Department Financing], [Floor] AS [Department Floor] FROM Departments;

INSERT INTO Departments ([Name], [Building], [Financing], [Floor]) VALUES (N'First Department', 5, 20000, 4);
INSERT INTO Departments ([Name], [Building], [Financing], [Floor]) VALUES (N'Second Department', 3, 13500, 4);
INSERT INTO Departments ([Name], [Building], [Financing], [Floor]) VALUES (N'Third Department', 6, 20000, 4);

SELECT [Name], [Financing] FROM Departments WHERE ([Building] = 5 AND [Financing] < 30000);
SELECT [Name], [Financing] FROM Departments WHERE ([Building] = 3 AND ([Financing] BETWEEN 12000 AND 15000));
SELECT [Name], [Building], [Financing] FROM Departments WHERE (([Building] IN (3, 6) AND ([Financing] >= 11000 AND [Financing] <= 25000)));
SELECT [Name], [Building] FROM Departments WHERE ([Building] IN (1, 3, 8, 10));
SELECT [Name] FROM Departments WHERE ([Building] NOT IN (1, 3));
SELECT [Name] FROM Departments WHERE ([Building] IN (1, 3));





INSERT INTO Diseases ([Name], [Severity]) VALUES (N'First Disease', 4);
INSERT INTO Diseases ([Name], [Severity]) VALUES (N'Second Disease', 2);

SELECT [Name] AS [Name of Disease], [Severity] AS [Severity of Disease] FROM Diseases;
SELECT [Name] FROM Diseases WHERE ([Severity] > 2);





INSERT INTO Doctors ([Name], [Surname], [Phone], [Salary], [Premium]) VALUES (N'First Doc Name', N'First Doc Surname', N'558527496', 2300, 120);
INSERT INTO Doctors ([Name], [Surname], [Phone], [Salary], [Premium]) VALUES (N'Second Doc Name', N'Nig...Second Doc Surname', N'558527496', 2300, 120);

SELECT [Surname], [Phone] FROM Doctors;
SELECT [Surname] FROM Doctors WHERE (([Salary] + [Premium]) > 1500);
SELECT [Surname] FROM Doctors WHERE (([Salary] / 2) > ([Premium] * 3));
SELECT [Surname] FROM Doctors WHERE ([Surname] LIKE 'N%');





INSERT INTO Examinations ([Name], [DayOfWeek], [StartTime], [EndTime]) VALUES (N'First Examination', 2, '13:00', '15:00');

SELECT DISTINCT [Name] FROM Examinations WHERE (([DayOfWeek] <= 3) AND ([StartTime] >= '12:00' AND [EndTime] <= '15:00'));





INSERT INTO Wards ([Name], [Building], [Floor]) VALUES (N'First Ward', 5, 1);
INSERT INTO Wards ([Name], [Building], [Floor]) VALUES (N'Second Ward', 2, 4);
INSERT INTO Wards ([Name], [Building], [Floor]) VALUES (N'Third Ward', 2, 3);
INSERT INTO Wards ([Name], [Building], [Floor]) VALUES (N'Fourth Ward', 4, 1);

SELECT * FROM Wards;
SELECT DISTINCT [Floor] FROM Wards;
SELECT [Name] FROM Wards WHERE (([Building] IN (4, 5) AND [Floor] = 1));