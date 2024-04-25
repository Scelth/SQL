use Academy;

CREATE TABLE  Teacher
(
     [ID] INT IDENTITY (1, 1) PRIMARY KEY,
     [Name] NVARCHAR(100) CHECK (len(Name)>1) NOT NULL,
     [Surname] NVARCHAR(100) CHECK (len(Surname)>1) NOT NULL
);

CREATE TABLE  Assistants
(
    [ID] INT IDENTITY (1, 1) PRIMARY KEY,
    [TeacherID] INT FOREIGN KEY REFERENCES Teacher(ID)
);

CREATE TABLE Curators
(
    [ID] INT IDENTITY (1, 1) PRIMARY KEY,
    [TeacherID] INT FOREIGN KEY REFERENCES Teacher(ID)
);

CREATE TABLE Deans
(
    [ID] INT IDENTITY (1, 1) PRIMARY KEY,
    [TeacherID] INT FOREIGN KEY REFERENCES Teacher(ID)
);

CREATE TABLE Faculties
(
    [ID] INT IDENTITY (1, 1) PRIMARY KEY,
    [Name] NVARCHAR(100) NOT NULL UNIQUE,
    [Building] INT CHECK(Building > 0 AND Building < 5) NOT NULL,
    [DeanID] INT FOREIGN KEY REFERENCES Deans(ID)
);

CREATE TABLE Heads
(
     [ID] INT IDENTITY (1, 1) PRIMARY KEY,
     [TeacherID] INT FOREIGN KEY REFERENCES Teacher(ID)
);

CREATE TABLE Departments
(
    [ID] INT IDENTITY (1, 1) PRIMARY KEY,
    [Name] NVARCHAR(100) NOT NULL UNIQUE,
    [FacultyID] INT FOREIGN KEY REFERENCES Faculties(ID),
    [HeadsID]  INT FOREIGN KEY REFERENCES Heads(ID),
    [Building] INT CHECK(Building > 0 AND Building < 5) NOT NULL
);

CREATE TABLE Group
(
    [ID] INT IDENTITY (1, 1) PRIMARY KEY,
    [Name] NVARCHAR(100) UNIQUE NOT NULL,
    [Year] INT CHECK(Year>= 0 AND Year <=5) NOT NULL,
    [DepartmentsID] INT FOREIGN KEY REFERENCES Departments(ID),
    [FacultyID] INT FOREIGN KEY REFERENCES Faculties(ID)
)


CREATE TABLE GroupsCurators
(
    [ID] INT IDENTITY (1, 1) PRIMARY KEY,
    [GroupID] INT FOREIGN KEY REFERENCES [Group](ID),
    [CuratorID] INT FOREIGN KEY REFERENCES Curators(ID)
);


CREATE TABLE Subjects
(
    [ID] INT IDENTITY (1, 1) PRIMARY KEY,
    [Name] NVARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Lectures
(
    [ID] INT IDENTITY (1, 1) PRIMARY KEY,
    [SubjectID] INT FOREIGN KEY REFERENCES Subjects(ID),
    [TeacherID] INT FOREIGN KEY REFERENCES Teacher(ID)
);

CREATE TABLE LectureRooms
(
    [ID] INT IDENTITY (1, 1) PRIMARY KEY,
    [Building] INT CHECK(Building > 0 AND Building < 5) NOT NULL,
    [Name] NVARCHAR(100) UNIQUE NOT NULL
);


CREATE TABLE GroupsLectures
(
    [ID] INT IDENTITY (1, 1) PRIMARY KEY,
    [GroupID] INT FOREIGN KEY REFERENCES [Group](ID),
    [LectureID] INT FOREIGN KEY REFERENCES Lectures(ID)
)

CREATE TABLE [Schedules]
(
    [ID] INT IDENTITY (1, 1) PRIMARY KEY,
    [Class] INT CHECK(Class BETWEEN 1 AND 6) NOT NULL,
    [DayOfWeek] INT CHECK(DayOfWeek BETWEEN 1 AND 7) NOT NULL,
    [Week] INT CHECK(Week BETWEEN 1 AND 52) NOT NULL,
    [LectureID] INT FOREIGN KEY REFERENCES Lectures(ID),
    [LectureRoomID] INT FOREIGN KEY REFERENCES LectureRooms(ID)
);

INSERT INTO Teacher(Name, Surname) VALUES (N'CassANDra', N'Bowman');
INSERT INTO Teacher(Name, Surname) VALUES (N'Edward', N'Hopper”');
INSERT INTO Teacher(Name, Surname) VALUES (N'Faye ', N'King');
INSERT INTO Teacher(Name, Surname) VALUES (N'Neal ', N'FerON');
INSERT INTO Teacher(Name, Surname) VALUES (N'Alex ', N'Carmack');
INSERT INTO Teacher(Name, Surname) VALUES (N'Melanie  ', N'Curtis');
INSERT INTO Teacher(Name, Surname) VALUES (N'Angel', N'Grimes');
INSERT INTO Teacher(Name, Surname) VALUES (N'Lewis', N'Shaw');


INSERT INTO Assistants(TeacherID) VALUES (1);
INSERT INTO Assistants(TeacherID) VALUES (2);
INSERT INTO Assistants(TeacherID) VALUES (3);
INSERT INTO Assistants(TeacherID) VALUES (7);
INSERT INTO Assistants(TeacherID) VALUES (8);


INSERT INTO Curators(TeacherID) VALUES (1);
INSERT INTO Curators(TeacherID) VALUES (4);
INSERT INTO Curators(TeacherID) VALUES (2);
INSERT INTO Curators(TeacherID) VALUES (5);


INSERT INTO Deans(TeacherID) VALUES (2);
INSERT INTO Deans(TeacherID) VALUES (3);
INSERT INTO Deans(TeacherID) VALUES (5);


INSERT INTO Faculties(Name, Building, DeanID) VALUES (N'Computer Science', 2, 2);
INSERT INTO Faculties(Name, Building, DeanID) VALUES (N'Software Development', 1, 3);
INSERT INTO Faculties(Name, Building, DeanID) VALUES (N'Engineering', 2, 3);


INSERT INTO Heads(TeacherID) VALUES (1);
INSERT INTO Heads(TeacherID) VALUES (4);
INSERT INTO Heads(TeacherID) VALUES (5);


INSERT INTO Departments(Name, FacultyID, HeadsID, Building) VALUES ('First', 1, 2, 3);
INSERT INTO Departments(Name, FacultyID, HeadsID, Building) VALUES ('Second', 2, 1, 2);
INSERT INTO Departments(Name, FacultyID, HeadsID, Building) VALUES ('Third', 3, 3, 3);


INSERT INTO [Group](Name, Year, DepartmentsID, FacultyID) VALUES (N'F505', 2, 2, 1);
INSERT INTO [Group](Name, Year, DepartmentsID, FacultyID) VALUES (N'A311', 4, 3, 2);
INSERT INTO [Group](Name, Year, DepartmentsID, FacultyID) VALUES (N'A104', 1, 1, 2);
INSERT INTO [Group](Name, Year, DepartmentsID, FacultyID) VALUES (N'T412', 5, 3, 1);


INSERT INTO GroupsCurators(GroupID, CuratorID) VALUES (2, 1);
INSERT INTO GroupsCurators(GroupID, CuratorID) VALUES (1, 4);
INSERT INTO GroupsCurators(GroupID, CuratorID) VALUES (1, 6);
INSERT INTO GroupsCurators(GroupID, CuratorID) VALUES (3, 7);


INSERT INTO Subjects(Name) VALUES (N'Python');
INSERT INTO Subjects(Name) VALUES (N'IT');
INSERT INTO Subjects(Name) VALUES (N'C#');
INSERT INTO Subjects(Name) VALUES (N'SQL');


INSERT INTO Lectures(SubjectID, TeacherID) VALUES (2, 3);
INSERT INTO Lectures(SubjectID, TeacherID) VALUES (1, 4);
INSERT INTO Lectures(SubjectID, TeacherID) VALUES (3, 2);
INSERT INTO Lectures(SubjectID, TeacherID) VALUES (1, 2);
INSERT INTO Lectures(SubjectID, TeacherID) VALUES (4, 2);
INSERT INTO Lectures(SubjectID, TeacherID) VALUES (3, 5);
INSERT INTO Lectures(SubjectID, TeacherID) VALUES (2, 5);
INSERT INTO Lectures(SubjectID, TeacherID) VALUES (2, 7);


INSERT INTO LectureRooms(Building, Name) VALUES (1, N'A3145');
INSERT INTO LectureRooms(Building, Name) VALUES (3, N'B2351');
INSERT INTO LectureRooms(Building, Name) VALUES (2, N'F2141');
INSERT INTO LectureRooms(Building, Name) VALUES (4, N'A311');
INSERT INTO LectureRooms(Building, Name) VALUES (4, N'A104');

INSERT INTO GroupsLectures(GroupID, LectureID) VALUES (2, 2);
INSERT INTO GroupsLectures(GroupID, LectureID) VALUES (3, 3);
INSERT INTO GroupsLectures(GroupID, LectureID) VALUES (4, 3);
INSERT INTO GroupsLectures(GroupID, LectureID) VALUES (4, 5);
INSERT INTO GroupsLectures(GroupID, LectureID) VALUES (5, 5);
INSERT INTO GroupsLectures(GroupID, LectureID) VALUES (2, 4);


INSERT INTO Schedules(Class, DayOfWeek, Week, LectureID, LectureroomID) VALUES (1, 3, 4, 2, 1);
INSERT INTO Schedules(Class, DayOfWeek, Week, LectureID, LectureroomID) VALUES (2, 5, 3, 3, 2);
INSERT INTO Schedules(Class, DayOfWeek, Week, LectureID, LectureroomID) VALUES (2, 2, 5, 9, 3);
INSERT INTO Schedules(Class, DayOfWeek, Week, LectureID, LectureroomID) VALUES (3, 4, 6, 3, 2);
INSERT INTO Schedules(Class, DayOfWeek, Week, LectureID, LectureroomID) VALUES (4, 2, 2, 4, 2);


--1 - Output the names of the classrooms where the teacher “Edward Hopper“ lectures
SELECT LectureRooms.Name FROM Schedules
JOIN LectureRooms ON LectureRooms.ID = Schedules.LectureRoomID
JOIN Lectures ON Lectures.ID = Schedules.LectureID
JOIN Teacher ON Teacher.ID = Lectures.TeacherID
WHERE (Teacher.Name = 'Edward' AND Teacher.Surname = 'Hopper');


--2 - Output the names of the assistants who give lectures in the group “F505".
SELECT Surname FROM Teacher
JOIN Assistants ON Teacher.ID = Assistants.TeacherID
JOIN Lectures ON Lectures.TeacherID = Assistants.TeacherID
JOIN GroupsLectures ON GroupsLectures.LectureID = Lectures.ID
JOIN [Group] ON GroupsLectures.GroupID = [Group].ID
WHERE ([Group].Name = 'F505');


--3 - Output the disciplines taught by the teacher “Alex Carmack” for the 5th year groups.
SELECT Subjects.Name FROM Lectures
JOIN Teacher  ON Teacher.ID = Lectures.TeacherID
JOIN Subjects ON Subjects.ID = Lectures.SubjectID
JOIN GroupsLectures  ON Lectures.ID = GroupsLectures.LectureID
JOIN [Group] ON [Group].ID = GroupsLectures.GroupID
WHERE (Teacher.Name = 'Alex' AND Teacher.Surname = 'Carmack' AND [Group].Year = 5);


--4 - Output the names of teachers who do not give lectures on Mondays.
SELECT Surname FROM Teacher
JOIN Group ON Teacher.Name = Group.Name
JOIN GroupsLectures ON Group.ID = GroupsLectures.GroupID
JOIN Schedules ON GroupsLectures.LectureID = Schedules.LectureID
WHERE (Schedules.DayOfWeek != 1);


--5 - Output the names of the classrooms, indicating their buildings, in which there are no lectures on Wednesday of the second week on the third pair.
SELECT DISTINCT LectureRooms.Name FROM Schedules
JOIN LectureRooms ON LectureRooms.ID = Schedules.LectureRoomID
JOIN Lectures ON Lectures.ID = Schedules.LectureID
JOIN Teacher ON Teacher.ID = Lectures.TeacherID
WHERE (Schedules.DayOfWeek !=3 AND Schedules.Week !=2 AND Schedules.Class != 3);


--6 - Output the full names of the teachers of the faculty of “Computer Science” who do not supervise the groups of the department of “Software Development".
SELECT Teacher.Name, Surname, Faculties.Name FROM Teacher
JOIN Curators ON Teacher.ID = Curators.TeacherID
JOIN Deans  ON Teacher.ID = Deans.TeacherID
JOIN Faculties ON Deans.ID = Faculties.DeanID
JOIN [Group]  ON Faculties.ID = [Group].FacultyID
WHERE (Faculties.Name != 'Computer Science');


--7. Output a list of the numbers of all buildings that are available in the tables of faculties, departments and classrooms.
SELECT Faculties.Building FROM Faculties
JOIN LectureRooms ON Faculties.Building  = LectureRooms.Building
JOIN Departments ON Faculties.Building = Departments.Building;


--8 - Output the full names of teachers in the following order: deans of faculties, heads of departments, teachers, curators, assistants.
SELECT Surname,Name FROM Teacher
JOIN Deans  ON Teacher.ID = Deans.TeacherID
UNION ALL
SELECT Surname,Name FROM Teacher
JOIN Heads  ON Teacher.ID = Heads.TeacherID
UNION ALL
SELECT Surname,Name FROM Teacher
UNION ALL
SELECT Surname,Name FROM Teacher
JOIN Curators  ON Teacher.ID = Curators.TeacherID
UNION ALL
SELECT Surname,Name FROM Teacher
JOIN Assistants  ON Teacher.ID = Assistants.TeacherID;


--9 - Output the days of the week (without repetitions) on which there are classes in the classrooms “A311” and “A104” of building 6.
SELECT DayOfWeek FROM Schedules
JOIN LectureRooms ON LectureRooms.ID = Schedules.LectureRoomID
JOIN Lectures  ON Lectures.ID = Schedules.LectureID
WHERE (LectureRooms.Building = 4 AND LectureRooms.Name = 'A3145' or LectureRooms.Name = 'B2351');