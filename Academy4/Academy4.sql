use Academy;

CREATE TABLE Curators
(
    ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [Name] NVARCHAR(MAX) NOT NULL,
    [Surname] NVARCHAR(MAX) NOT NULL
);

CREATE TABLE Faculties
(
    ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [Name] NVARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Teachers
(
    ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [Name] NVARCHAR(MAX) NOT NULL,
    [Surname] NVARCHAR(MAX) NOT NULL,
    [IsProfessor] BIT DEFAULT 0 NOT NULL,
    [Salary] MONEY CHECK ([Salary] > 0) NOT NULL
);

CREATE TABLE Departments
(
    ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [Building] INT CHECK ([Building] BETWEEN 1 AND 5) NOT NULL,
    [Name] NVARCHAR(100) UNIQUE NOT NULL,
    [FacultyID] INT FOREIGN KEY REFERENCES Faculties(ID),
    [Financing] INT DEFAULT 0 CHECK ([Financing] > 0) NOT NULL
);

CREATE TABLE Groups
(
    ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
    [Name] NVARCHAR(10) UNIQUE NOT NULL,
    [Year] INT CHECK ([Year] BETWEEN 1 AND 5) NOT NULL,
    [DepartmentID] INT FOREIGN KEY REFERENCES Departments(ID)
);

CREATE TABLE GroupsCurators
(
    ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
    [CuratorID] INT FOREIGN KEY REFERENCES Curators(ID),
    [GroupID] INT FOREIGN KEY REFERENCES Groups(ID)
);

CREATE TABLE Subjects
(
    ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [Name] NVARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Lectures
(
    ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [Date] DATE CHECK ([Date] <= GETDATE()),
    [SubjectID] INT FOREIGN KEY REFERENCES Subjects(ID),
    [TeacherID] INT FOREIGN KEY REFERENCES Teachers(ID)
);

CREATE TABLE GroupsLectures
(
    ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
    [GroupID] INT FOREIGN KEY REFERENCES Groups(ID),
    [LectureID] INT FOREIGN KEY REFERENCES Lectures(ID)
);

CREATE TABLE Students
(
    ID INT IDENTITY(1, 1) PRIMARY KEY NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [Surname] NVARCHAR(100) NOT NULL,
    [Rating] INT CHECK ([Rating] BETWEEN 0 AND 4)
);

CREATE TABLE GroupsStudents
(
    ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
    [GroupID] INT FOREIGN KEY REFERENCES Groups(ID),
    [StudentID] INT FOREIGN KEY REFERENCES Students(ID)
);

INSERT INTO Curators ([Name], [Surname]) VALUES ('Berky', 'Northcliffe');
INSERT INTO Curators ([Name], [Surname]) VALUES ('Jacobo', 'Heers');
INSERT INTO Curators ([Name], [Surname]) VALUES ('Lynea', 'LegON');
INSERT INTO Curators ([Name], [Surname]) VALUES ('Felicity', 'Hulstrom');

INSERT INTO Faculties (Name) VALUES (N'Computer Science');
INSERT INTO Faculties (Name) VALUES (N'Game Engine');
INSERT INTO Faculties (Name) VALUES (N'3D');
INSERT INTO Faculties (Name) VALUES (N'Sound Engine');

INSERT INTO Departments ([Building], [Name], [FacultyID], [Financing]) VALUES (5, 'Software  Development', 1, 18858);
INSERT INTO Departments ([Building], [Name], [FacultyID], [Financing]) VALUES (4, 'Hardware  Development', 2, 22300);
INSERT INTO Departments ([Building], [Name], [FacultyID], [Financing]) VALUES (3, 'EcONomy', 3, 90542);
INSERT INTO Departments ([Building], [Name], [FacultyID], [Financing]) VALUES (5, 'Robotics', 4, 56834);

INSERT INTO Teachers (Name, Surname, Salary, IsProfessor) VALUES (N'Magomed', N'Guluyev', 5000, 1);
INSERT INTO Teachers (Name, Surname, Salary, IsProfessor) VALUES (N'Kirill', N'Gorikov', 4500, 1);
INSERT INTO Teachers (Name, Surname, Salary, IsProfessor) VALUES (N'Sara', N'Omarova', 3000, 0);
INSERT INTO Teachers (Name, Surname, Salary, IsProfessor) VALUES (N'Vusal', N'Guluyev', 7000, 1);

INSERT INTO Groups ([Name], [Year], [DepartmentID]) VALUES ('F505', 4, 1);
INSERT INTO Groups ([Name], [Year], [DepartmentID]) VALUES ('E404', 2, 2);
INSERT INTO Groups ([Name], [Year], [DepartmentID]) VALUES ('C303', 3, 3);
INSERT INTO Groups ([Name], [Year], [DepartmentID]) VALUES ('D202', 5, 4);

INSERT INTO GroupsCurators ([CuratorID], [GroupID]) VALUES (1, 1);
INSERT INTO GroupsCurators ([CuratorID], [GroupID]) VALUES (2, 2);
INSERT INTO GroupsCurators ([CuratorID], [GroupID]) VALUES (3, 3);
INSERT INTO GroupsCurators ([CuratorID], [GroupID]) VALUES (4, 4);

INSERT INTO Subjects ([Name]) VALUES (N'C++');
INSERT INTO Subjects ([Name]) VALUES (N'Blender');
INSERT INTO Subjects ([Name]) VALUES (N'Adobe AuditiON');
INSERT INTO Subjects ([Name]) VALUES (N'IT');

INSERT INTO Lectures ([Date], [SubjectID], [TeacherID]) VALUES ('09/08/2022', 1, 1);
INSERT INTO Lectures ([Date], [SubjectID], [TeacherID]) VALUES ('06/08/2022', 2, 2);
INSERT INTO Lectures ([Date], [SubjectID], [TeacherID]) VALUES ('04/04/2023', 3, 3);
INSERT INTO Lectures ([Date], [SubjectID], [TeacherID]) VALUES ('05/21/2022', 4, 4);

INSERT INTO GroupsLectures ([GroupID], [LectureID]) VALUES (1, 1);
INSERT INTO GroupsLectures ([GroupID], [LectureID]) VALUES (2, 2);
INSERT INTO GroupsLectures ([GroupID], [LectureID]) VALUES (3, 3);
INSERT INTO GroupsLectures ([GroupID], [LectureID]) VALUES (4, 4);

INSERT INTO Students ([Name], [Surname], [Rating]) VALUES ('Aymer', 'Broschek', 0);
INSERT INTO Students ([Name], [Surname], [Rating]) VALUES ('Kordula', 'Trouel', 1);
INSERT INTO Students ([Name], [Surname], [Rating]) VALUES ('Alejandro', 'Keepence', 2);
INSERT INTO Students ([Name], [Surname], [Rating]) VALUES ('Rhody', 'Coulthurst', 3);

INSERT INTO GroupsStudents ([GroupID], [StudentID]) VALUES (1, 1);
INSERT INTO GroupsStudents ([GroupID], [StudentID]) VALUES (2, 2);
INSERT INTO GroupsStudents ([GroupID], [StudentID]) VALUES (3, 3);
INSERT INTO GroupsStudents ([GroupID], [StudentID]) VALUES (4, 4);



--1
SELECT [Building], [Name] FROM Departments WHERE ([Financing] > 10000);


--2
SELECT Groups.[Name] FROM Groups
INNER JOIN Departments ON Departments.ID = Groups.ID
INNER JOIN GroupsCurators ON Groups.ID = GroupsCurators.ID
WHERE (Groups.[Name] = N'Software  Development' AND Groups.[Year] > 4)


--3
SELECT Groups.[Name] FROM Groups
INNER JOIN GroupsStudents ON Groups.ID = GroupsStudents.[GroupID]
INNER JOIN Students ON Students.ID = GroupsStudents.[StudentID]
WHERE ([Rating] > (SELECT AVG([Rating]) FROM Students WHERE (Groups.[Name] != 'E404')))


--4
SELECT [Surname], [Name] FROM Teachers WHERE ([Salary] > (SELECT AVG([Salary]) FROM Teachers WHERE ([IsProfessor] = 1)) AND ([IsProfessor] = 0))


--5
SELECT Groups.[Name], COUNT(*) AS 'Curators COUNT' FROM Groups
INNER JOIN GroupsCurators ON Groups.ID = GroupsCurators.[GroupID]
INNER JOIN Curators ON GroupsCurators.CuratorID = Curators.ID
GROUP BY Groups.[Name]
HAVING (COUNT(*) > 1);


--6
SELECT Groups.[Name] FROM Groups
INNER JOIN GroupsStudents ON Groups.ID = GroupsStudents.GroupID
INNER JOIN Students ON GroupsStudents.StudentID = Students.ID
WHERE ((SELECT AVG([Rating]) FROM Students) < (SELECT MIN([Rating]) FROM Students WHERE (Groups.[Year] = 4)))


--7
SELECT Faculties.[Name] FROM Faculties
INNER JOIN Departments  ON Faculties.ID = Departments.[FacultyID]
WHERE ((SELECT SUM(Departments.[Financing]) FROM Departments) > (SELECT SUM(Departments.[Financing]) FROM Departments INNER JOIN Faculties ON Faculties.ID = Departments.[FacultyID] WHERE Faculties.[Name] = 'Computer Science'))


-- 8
SELECT (Teachers.[Name] + ' ' + Teachers.[Surname]) AS 'Full Name', Subjects.[Name] AS 'Subject', COUNT(*) AS 'Subject Count' FROM Lectures
INNER JOIN Subjects ON Subjects.ID = Lectures.[SubjectID]
INNER JOIN Teachers ON Teachers.ID = Lectures.[TeacherID]
GROUP BY Teachers.[Name], Teachers.[Surname], Subjects.[Name]