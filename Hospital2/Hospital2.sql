use Hospital;

CREATE TABLE Departments
(
     ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
     [Name] NVARCHAR(100) CHECK ([Name] != ' ') UNIQUE NOT NULL,
     [Building] INT CHECK ([Building] BETWEEN 1 AND 5) NOT NULL
);


CREATE TABLE Doctors
(
    ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
    [Name] NVARCHAR(MAX) CHECK ([Name] != ' ') NOT NULL,
    [Surname] NVARCHAR(MAX) CHECK ([Surname] != ' ') NOT NULL,
    [Salary] MONEY CHECK (Salary > 0) NOT NULL,
    [Premium] MONEY DEFAULT 0 CHECK (Premium > 0) NOT NULL
);

CREATE TABLE Examinations
(
     ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
     [Name] NVARCHAR(100) CHECK ([Name] != ' ') UNIQUE NOT NULL
);

CREATE TABLE DoctorsExaminations
(
     ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
     [Name] NVARCHAR(100) CHECK ([Name] != ' ') UNIQUE NOT NULL,
     [StartTime] TIME CHECK ([StartTime] BETWEEN '08:00' AND '18:00') NOT NULL,
     [EndTime] TIME NOT NULL,
     CONSTRAINT CHK_EndTime CHECK ([EndTime] > [StartTime]),
     [DoctorID] INT FOREIGN KEY REFERENCES Doctors(ID) NOT NULL,
     [ExaminationID] INT FOREIGN KEY REFERENCES Examinations([ID]) NOT NULL,
     [WardID] INT FOREIGN KEY REFERENCES Wards(ID) NOT NULL
);

CREATE TABLE Wards
(
     ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
     [Name] NVARCHAR(20) CHECK ([Name] != ' ') UNIQUE NOT NULL,
     [Places] INT CHECK ([Places] >= 1) NOT NULL,
     [DepartmentId] INT FOREIGN KEY REFERENCES Departments(ID) NOT NULL,
);

INSERT INTO Departments ([Name], [Building]) VALUES (N'First Department', 5);

SELECT Departments.ID, COUNT(Wards.ID) AS 'Number of wards' FROM Departments
JOIN Wards ON Departments.ID = Wards.DepartmentId
GROUP BY Departments.ID;

SELECT Departments.Name, COUNT(Wards.ID) AS 'Number of wards' FROM Departments
JOIN Wards ON Departments.ID = Wards.DepartmentId
GROUP BY Departments.Name;

SELECT Departments.Name, SUM(Doctors.Premium) AS 'Total allowance' FROM Departments
JOIN Wards ON Departments.ID = Wards.DepartmentId
JOIN DoctorsExaminations ON Wards.ID = DoctorsExaminations.WardID
JOIN Doctors ON DoctorsExaminations.DoctorID = Doctors.ID
GROUP BY Departments.Name;

SELECT Departments.Name FROM Departments
JOIN Wards ON Departments.ID = Wards.DepartmentId
JOIN DoctorsExaminations ON Wards.ID = DoctorsExaminations.WardID
GROUP BY Departments.Name
HAVING COUNT(DISTINCT DoctorsExaminations.DoctorID) >= 5;

SELECT Departments.Building, SUM(Wards.Places) AS 'Total Places' FROM Wards
JOIN Departments ON Wards.DepartmentId = Departments.ID
WHERE (Departments.Building IN (1, 6, 7, 8) AND Wards.Places > 10)
GROUP BY Departments.Building
HAVING SUM(Wards.Places) > 100;





INSERT INTO Doctors ([Name], [Surname], [Salary], [Premium]) VALUES (N'First Doc name', N'First Doc surname', 1200, 300);
INSERT INTO Doctors ([Name], [Surname], [Salary], [Premium]) VALUES (N'Second Doc name', N'Second Doc surname', 1000, 250);
SELECT COUNT(ID) AS 'Number of doctors', SUM(Salary + Premium) AS 'Total salary' FROM Doctors;
SELECT AVG(Salary + Premium) AS 'Average salary' FROM Doctors;





INSERT INTO Examinations (Name) VALUES (N'Firsn Examination');





INSERT INTO DoctorsExaminations ([Name], [StartTime], [EndTime], [DoctorID], [ExaminationID], [WardID]) VALUES (N'First DocExamination', '12:00', '15:00', 1, 1, 1);




INSERT INTO Wards ([Name], [Places], [DepartmentId]) VALUES (N'First Ward', 12, 1);
INSERT INTO Wards ([Name], [Places], [DepartmentId]) VALUES (N'Second Ward', 9, 1);

SELECT COUNT(*) FROM Wards WHERE ([Places] > 10);
SELECT Wards.Name FROM Wards WHERE (Wards.Places = (SELECT MIN(Places) FROM Wards));