use Academy

CREATE TABLE Teacher
(
    ID INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
    Name NVARCHAR(MAX) NOT NULL,
    Surname NVARCHAR(MAX) NOT NULL,
    Salary MONEY CHECK (Salary > 0) NOT NULL,
    Premium MONEY DEFAULT 0 CHECK (Premium > 0) NOT NULL,
    EmploymentDate DATE CHECK (EmploymentDate > '1990-01-01')
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
    Name NVARCHAR(100) UNIQUE NOT NULL
);



INSERT INTO Teacher (Name, Surname, Salary, Premium, EmploymentDate) VALUES (N'Magomed', N'Guluyev', 5000, 2500, '2001-06-01')

INSERT INTO Groups (Name, Rating, Year) VALUES (N'FBMS_1221', 5, 3);

INSERT INTO Departments (Name, Financing) VALUES (N'IT_Step', 200000);

INSERT INTO Faculties (Name) VALUES (N'Computer Science')