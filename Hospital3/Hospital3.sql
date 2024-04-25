use Hospital;

CREATE TABLE Doctors
(
    ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
    [Name] NVARCHAR(MAX) CHECK ([Name] != ' ') NOT NULL,
    [Surname] NVARCHAR(MAX) CHECK ([Surname] != ' ') NOT NULL,
    [Salary] MONEY CHECK (Salary > 0) NOT NULL
);

CREATE TABLE Professors
(
 ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
 [DoctorID] INT FOREIGN KEY REFERENCES Doctors(ID)
);

CREATE TABLE Interns
(
 ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
 [DoctorID] INT FOREIGN KEY REFERENCES Doctors(ID)
);

CREATE TABLE Diseases
(
     ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
     [Name] NVARCHAR(100) CHECK (Len([Name]) > 1) UNIQUE NOT NULL
);

CREATE TABLE Examinations
(
     ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
     [Name] NVARCHAR(100) CHECK (Len([Name]) > 1) UNIQUE NOT NULL
);

CREATE TABLE Departments
(
     ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
     [Name] NVARCHAR(100) CHECK (Len([Name]) > 1) UNIQUE NOT NULL,
     [Building] INT CHECK ([Building] BETWEEN 1 AND 5) NOT NULL,
     [Financing] MONEY DEFAULT 0 CHECK ([Financing] > 0) NOT NULL
);

CREATE TABLE Wards
(
     ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
     [Name] NVARCHAR(20) CHECK (Len([Name]) > 1) UNIQUE NOT NULL,
     [Places] INT CHECK ([Places] >= 1) NOT NULL,
     [DepartmentId] INT FOREIGN KEY REFERENCES Departments(ID) NOT NULL,
);

CREATE TABLE DoctorsExaminations
(
    ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
    [Date] DATE CHECK ([Date] < GETDATE()),
    [DiseasID] INT FOREIGN KEY REFERENCES Diseases(ID),
    [DoctorID] INT FOREIGN KEY REFERENCES Doctors(ID),
    [ExaminationID] INT FOREIGN KEY REFERENCES Examinations(ID),
    [WardID] INT FOREIGN KEY REFERENCES Wards(ID)
);

INSERT INTO Doctors ([Name], [Surname], [Salary]) VALUES ('Pen', 'Quadrio', 3108);
INSERT INTO Doctors ([Name], [Surname], [Salary]) VALUES ('Cosetta', 'Pennock', 6210);
INSERT INTO Doctors ([Name], [Surname], [Salary]) VALUES ('Cordy', 'Gavan', 2012);
INSERT INTO Doctors ([Name], [Surname], [Salary]) VALUES ('Urbain', 'Leming', 6814);
INSERT INTO Doctors ([Name], [Surname], [Salary]) VALUES ('Weylin', 'Mosen', 1415);

INSERT INTO Professors ([DoctorID]) VALUES (1);
INSERT INTO Professors ([DoctorID]) VALUES (2);

INSERT INTO Interns ([DoctorID]) VALUES (3);
INSERT INTO Interns ([DoctorID]) VALUES (4);

INSERT INTO Diseases ([Name]) VALUES ('Botulism');
INSERT INTO Diseases ([Name]) VALUES ('Cholera');
INSERT INTO Diseases ([Name]) VALUES ('Ebola');
INSERT INTO Diseases ([Name]) VALUES ('Influenza');
INSERT INTO Diseases ([Name]) VALUES ('Lice');

INSERT INTO Examinations ([Name]) VALUES ('Swaniawski');
INSERT INTO Examinations ([Name]) VALUES ('Swift');
INSERT INTO Examinations ([Name]) VALUES ('Goodwin');
INSERT INTO Examinations ([Name]) VALUES ('Considine');
INSERT INTO Examinations ([Name]) VALUES ('Lueilwitz');

INSERT INTO Departments ([Name], [Building], [Financing]) VALUES ('Hottentot', 2, 18668);
INSERT INTO Departments ([Name], [Building], [Financing]) VALUES ('Skink', 5, 10100);
INSERT INTO Departments ([Name], [Building], [Financing]) VALUES ('Lorikeet', 4, 19667);
INSERT INTO Departments ([Name], [Building], [Financing]) VALUES ('Monkey', 3, 9960);
INSERT INTO Departments ([Name], [Building], [Financing]) VALUES ('Emu', 2, 16453);

INSERT INTO Wards ([Name], [Places], [DepartmentId]) VALUES ('Cockatoo, sulfur-crested', 4, 1);
INSERT INTO Wards ([Name], [Places], [DepartmentId]) VALUES ('Cape starling', 4, 2);
INSERT INTO Wards ([Name], [Places], [DepartmentId]) VALUES ('Pie, rufous tree', 5, 3);
INSERT INTO Wards ([Name], [Places], [DepartmentId]) VALUES ('Vulture, bengal', 3, 4);
INSERT INTO Wards ([Name], [Places], [DepartmentId]) VALUES ('Otter, canadian river', 1, 5);

INSERT INTO DoctorsExaminations ([Date], [DiseasID], [DoctorID], [ExaminationID], [WardID]) VALUES ('05/20/2022', 1, 1, 1, 1);
INSERT INTO DoctorsExaminations ([Date], [DiseasID], [DoctorID], [ExaminationID], [WardID]) VALUES ('02/04/2023', 2, 2, 2, 2);
INSERT INTO DoctorsExaminations ([Date], [DiseasID], [DoctorID], [ExaminationID], [WardID]) VALUES ('07/05/2022', 3, 3, 3, 3);
INSERT INTO DoctorsExaminations ([Date], [DiseasID], [DoctorID], [ExaminationID], [WardID]) VALUES ('12/03/2022', 4, 4, 4, 4);
INSERT INTO DoctorsExaminations ([Date], [DiseasID], [DoctorID], [ExaminationID], [WardID]) VALUES ('06/07/2022', 5, 5, 5, 5);



--1
SELECT Wards.[Name], Wards.[Places] FROM Wards
INNER JOIN Departments ON Wards.DepartmentId = Departments.ID
WHERE (Departments.[Building] = 5 AND Wards.[Places] >= 5 AND Wards.[Places] > 15);

--2
SELECT DISTINCT Departments.[Name] FROM Departments
INNER JOIN Wards ON Departments.ID = Wards.DepartmentId
INNER JOIN DoctorsExaminations ON Wards.ID = DoctorsExaminations.WardID
WHERE DoctorsExaminations.[Date] >= DATEADD(week, -1, GETDATE());

--3
SELECT [Name] FROM Diseases WHERE (ID NOT IN (SELECT [DiseasID] FROM DoctorsExaminations));

--4
SELECT [Name] + ' ' + [Surname] AS 'Full name' FROM Doctors WHERE (ID NOT IN (SELECT [DoctorID] FROM DoctorsExaminations));

--5
SELECT [Name] FROM Departments WHERE (ID NOT IN (SELECT DISTINCT Wards.[DepartmentId] FROM Wards
    INNER JOIN DoctorsExaminations ON Wards.ID = DoctorsExaminations.WardID));
