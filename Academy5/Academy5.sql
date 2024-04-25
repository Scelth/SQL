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
INSERT INTO Curators ([Name], [Surname]) VALUES ('Felicita', 'Tatatata');

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
INSERT INTO GroupsCurators ([CuratorID], [GroupID]) VALUES (5, 2);

INSERT INTO Subjects ([Name]) VALUES (N'Unreal Engine');
INSERT INTO Subjects ([Name]) VALUES (N'Blender');
INSERT INTO Subjects ([Name]) VALUES (N'Adobe Audition');
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



----Functions
--1
CREATE FUNCTION SubjectIDByName(@SubjectName NVARCHAR(100))
RETURNS INT
AS
BEGIN
    DECLARE @SubjectID INT

    SELECT @SubjectID = ID FROM Subjects WHERE ([Name] = @SubjectName)

    RETURN @SubjectID
END

DECLARE @SubjectID INT;
SET @SubjectID = dbo.SubjectIDByName(N'Blender');
SELECT @SubjectID AS 'Subject ID';

--2
CREATE FUNCTION TeacherByLecture(@SubjectName NVARCHAR(100))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @TeacherName NVARCHAR(MAX);

    SELECT @TeacherName = (Teachers.[Name] + ' ' + Teachers.[Surname]) FROM Lectures
    INNER JOIN Subjects ON Subjects.ID = Lectures.[SubjectID]
    INNER JOIN Teachers ON Teachers.ID = Lectures.[TeacherID]
    WHERE Subjects.[Name] = @SubjectName;

    RETURN @TeacherName;
END

DECLARE @SubjectName NVARCHAR(100);
SET @SubjectName = dbo.TeacherByLecture(N'Unreal Engine');
SELECT @SubjectName AS 'Full Name';

--3
CREATE FUNCTION GroupNameByRating(@AnotherGroupName NVARCHAR(10))
RETURNS NVARCHAR(10)
AS
BEGIN
    DECLARE @GroupName NVARCHAR(10);


    SELECT @GroupName = Groups.[Name] FROM Groups
    INNER JOIN GroupsStudents ON Groups.ID = GroupsStudents.[GroupID]
    INNER JOIN Students ON Students.ID = GroupsStudents.[StudentID]
    WHERE ([Rating] > (SELECT AVG([Rating]) FROM Students WHERE (Groups.[Name] != @AnotherGroupName)));

    RETURN @GroupName;
END

DECLARE @AnotherGroupName NVARCHAR(10);
SET @AnotherGroupName = dbo.GroupNameByRating(N'E404');
SELECT @AnotherGroupName AS 'This group has a higher rating than the one you indicated';

--4
CREATE FUNCTION GroupNameByCuratorsCount(@MoreThan INT)
RETURNS NVARCHAR(10)
AS
BEGIN
    DECLARE @Count NVARCHAR(10);

    SELECT @Count = Groups.[Name] FROM Groups
    INNER JOIN GroupsCurators ON Groups.ID = GroupsCurators.[GroupID]
    INNER JOIN Curators ON GroupsCurators.CuratorID = Curators.ID
    GROUP BY Groups.[Name]
    HAVING (COUNT(*) > @MoreThan);

    RETURN @Count;
END

DECLARE @Count NVARCHAR(10);
SET @Count = dbo.GroupNameByCuratorsCount(1);
SELECT @Count AS 'This group has more curators than the number you specified';

--5
CREATE FUNCTION GetStudentsByGroupName (@GroupName NVARCHAR(10))
RETURNS TABLE
AS
RETURN
(
    SELECT Students.* FROM Students
    JOIN GroupsStudents ON GroupsStudents.StudentID = Students.ID
    JOIN Groups ON Groups.ID = GroupsStudents.GroupID
    WHERE Groups.Name = @GroupName
);

SELECT * FROM dbo.GetStudentsByGroupName('E404');



----Procedures
--1
CREATE PROCEDURE InsertSubject(@SubjectName NVARCHAR(100))
AS
BEGIN
    INSERT INTO Subjects ([Name]) VALUES (@SubjectName)
END

EXEC InsertSubject N'С++';

--2
CREATE PROCEDURE InsertCurator(@Name NVARCHAR(MAX), @Surname NVARCHAR(MAX))
AS
BEGIN
    INSERT INTO Curators ([Name], [Surname]) VALUES (@Name, @Surname);
END;

EXEC InsertCurator 'John', 'Doe';

--3
CREATE PROCEDURE InsertFaculty(@Name NVARCHAR(100))
AS
BEGIN
    INSERT INTO Faculties ([Name]) VALUES (@Name);
END;

EXEC InsertFaculty 'Cyber Security';

--4
CREATE PROCEDURE InsertTeacher(@Name NVARCHAR(MAX),@Surname NVARCHAR(MAX),@IsProfessor BIT,@Salary MONEY)
AS
BEGIN
    INSERT INTO Teachers ([Name], [Surname], [IsProfessor], [Salary]) VALUES (@Name, @Surname, @IsProfessor, @Salary);
END;

EXEC InsertTeacher 'Jane', 'Smith', 1, 5000;

--5
CREATE PROCEDURE InsertDepartment(@Building INT, @Name NVARCHAR(100), @FacultyID INT, @Financing INT)
AS
BEGIN
    INSERT INTO Departments ([Building], [Name], [FacultyID], [Financing]) VALUES (@Building, @Name, @FacultyID, @Financing);
END;

EXEC InsertDepartment 3, 'Information Technology', 1, 100000;