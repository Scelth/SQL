use Academy

CREATE TABLE Teacher
(
    ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
    Name NVARCHAR(MAX) NOT NULL,
    Surname NVARCHAR(MAX) NOT NULL,
    Salary MONEY CHECK (Salary > 0) NOT NULL,
    Premium MONEY DEFAULT 0 CHECK (Premium > 0) NOT NULL,
    EmploymentDate DATE CHECK (EmploymentDate > '1990-01-01'),
    IsAssistant BIT DEFAULT 0 NOT NULL,
    IsProfessor BIT DEFAULT 0 NOT NULL,
    Position NVARCHAR(MAX) NOT NULL
);


CREATE TABLE Groups
(
    ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
    Name NVARCHAR(10) UNIQUE NOT NULL,
    Rating INT CHECK (Rating BETWEEN 0 AND 5) NOT NULL,
    Year INT CHECK (Year BETWEEN 1 AND 5) NOT NULL
);


CREATE TABLE Departments
(
    ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
    Name NVARCHAR(100) UNIQUE NOT NULL,
    Financing MONEY DEFAULT 0 CHECK (Financing > 0) NOT NULL
);


CREATE TABLE Faculties
(
    ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
    Name NVARCHAR(100) UNIQUE NOT NULL,
    Dean NVARCHAR(MAX) NOT NULL
);



INSERT INTO Teacher (Name, Surname, Salary, Premium, EmploymentDate, IsAssistant, IsProfessor, Position) VALUES (N'Magomed', N'Guluyev', 5000, 2500, '2001-06-01', 0, 1, N'Game Engine');
INSERT INTO Teacher (Name, Surname, Salary, Premium, EmploymentDate, IsAssistant, IsProfessor, Position) VALUES (N'Kirill', N'Gorikov', 4500, 3000, '2002-05-07', 0, 0, N'3D Artist');
INSERT INTO Teacher (Name, Surname, Salary, Premium, EmploymentDate, IsAssistant, IsProfessor, Position) VALUES (N'Sara', N'Omarova', 3000, 300, '2001-10-26', 1, 0, N'Sound Engine');
INSERT INTO Teacher (Name, Surname, Salary, Premium, EmploymentDate, IsAssistant, IsProfessor, Position) VALUES (N'Vusal', N'Guluyev', 7000, 3000, '1992-06-28', 0, 1, N'Director');
INSERT INTO Teacher (Name, Surname, Salary, Premium, EmploymentDate, IsAssistant, IsProfessor, Position) VALUES (N'Kto-to', N'Kto-toyev', 300, 200, '2012-08-04', 1, 0, N'Cleaner');

SELECT Surname, Salary, Premium FROM Teacher;
SELECT Surname FROM Teacher WHERE (IsProfessor = 1 AND (Salary + Premium > 1050));
SELECT Surname FROM Teacher WHERE (IsProfessor = 0);
SELECT Surname, Salary, Premium FROM Teacher WHERE (IsAssistant = 1 AND (Premium > 160 AND Premium <550));
SELECT Surname, Salary FROM Teacher WHERE (IsAssistant = 1);
SELECT Surname, Position FROM Teacher WHERE (EmploymentDate < '2000-01-01');
SELECT Surname FROM Teacher WHERE (IsAssistant = 1 AND (Salary + Premium) <= 1200);
SELECT Surname FROM Teacher WHERE (Salary < 550 OR Premium < 200);




INSERT INTO Groups (Name, Rating, Year) VALUES (N'FBMS_1221', 5, 3);
INSERT INTO Groups (Name, Rating, Year) VALUES (N'FBM_3201', 3, 5);

SELECT Name AS [Group Name], Rating AS [Group Rating] FROM Groups;
SELECT Name FROM Groups WHERE (Year = 5 AND (Rating > 2 AND Rating < 4));




INSERT INTO Departments (Name, Financing) VALUES (N'Hardware Development', 30000);
INSERT INTO Departments (Name, Financing) VALUES (N'Software Development', 24000);

SELECT * FROM Departments ORDER BY Name, Financing DESC;
SELECT Name FROM Departments WHERE (Financing > 11000 AND Financing < 25000);
SELECT Name AS [Name of Department] FROM Departments WHERE (Name < 'Software Development');




INSERT INTO Faculties (Name, Dean) VALUES (N'Computer Science', N'Vusal');
INSERT INTO Faculties (Name, Dean) VALUES (N'Game Engine', N'Magomed');
INSERT INTO Faculties (Name, Dean) VALUES (N'3D', N'Kirill');
INSERT INTO Faculties (Name, Dean) VALUES (N'Sound Engine', N'Sara');

SELECT 'The dean of the fakulty '  + [Name] + ' is ' + [Dean] FROM Faculties;
SELECT Name FROM Faculties WHERE (Name != 'Computer Science');