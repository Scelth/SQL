use Barber;

CREATE TABLE Barbers
(
  ID INT IDENTITY (1,1) PRIMARY KEY,
  [FullName] NVARCHAR(MAX) NOT NULL,
  [Gender] BIT NOT NULL,
  [ContactPhone] NVARCHAR(20) NOT NULL,
  [Email] NVARCHAR(100) NOT NULL,
  [BirthDate] DATE CHECK ([BirthDate] < GETDATE()) NOT NULL,
  [EmploymentDate] DATE NOT NULL,
  [Position] NVARCHAR(20) NOT NULL
);

CREATE TABLE Services
(
  ID INT IDENTITY (1,1) PRIMARY KEY,
  [BarberID] INT FOREIGN KEY REFERENCES Barbers(ID),
  [ServiceName] NVARCHAR(100) NOT NULL,
  [Price] DECIMAL(10, 2) NOT NULL,
  [DurationMinutes] INT NOT NULL
);

CREATE TABLE Feedbacks
(
  ID INT IDENTITY (1,1) PRIMARY KEY,
  [BarberID] INT FOREIGN KEY REFERENCES Barbers([ID]),
  [CustomerName] NVARCHAR(100) NOT NULL,
  [Feedback] NVARCHAR(MAX) NOT NULL
);

CREATE TABLE Ratings
(
  ID INT IDENTITY (1,1) PRIMARY KEY,
  [BarberID] INT FOREIGN KEY REFERENCES Barbers(ID),
  [CustomerName] NVARCHAR(100) NOT NULL,
  [Rating] NVARCHAR(20) NOT NULL
);

CREATE TABLE Clients
(
  ID INT IDENTITY (1,1) PRIMARY KEY,
  [FullName] NVARCHAR(MAX) NOT NULL,
  [ContactPhone] NVARCHAR(20) NOT NULL,
  [Email] NVARCHAR(100) NOT NULL
);

CREATE TABLE ClientFeedbacks
(
  ID INT IDENTITY (1,1) PRIMARY KEY,
  [ClientID] INT FOREIGN KEY REFERENCES Clients(ID),
  [BarberID] INT FOREIGN KEY REFERENCES Barbers(ID),
  [Feedback] NVARCHAR(MAX) NOT NULL
);

CREATE TABLE ClientRatings
(
  ID INT IDENTITY (1,1) PRIMARY KEY,
  [ClientID] INT FOREIGN KEY REFERENCES Clients(ID),
  [BarberID] INT FOREIGN KEY REFERENCES Barbers(ID),
  [Rating] NVARCHAR(20) NOT NULL
);

CREATE TABLE Visits
(
  ID INT PRIMARY KEY,
  [ClientID] INT FOREIGN KEY REFERENCES Clients(ID),
  [BarberID] INT FOREIGN KEY REFERENCES Barbers(ID),
  [ServiceID] INT FOREIGN KEY REFERENCES Services(ID),
  [VisitDate] DATE CHECK (VisitDate < GETDATE()) NOT NULL,
  [TotalCost] DECIMAL(10, 2) NOT NULL,
  [Rating] NVARCHAR(20) NOT NULL,
  [Feedback] NVARCHAR(MAX) NOT NULL
);

--Part 1
--1
CREATE FUNCTION LongestWorking()
RETURNS TABLE
AS
RETURN
    SELECT TOP 1 * FROM Barbers
    ORDER BY [EmploymentDate];

--2
CREATE FUNCTION BarberWithMostClients(@StartDate DATE, @EndDate DATE)
RETURNS TABLE
AS
RETURN
    SELECT TOP 1 Barbers.* FROM Barbers
    INNER JOIN Visits ON Barbers.ID = Visits.BarberID
    WHERE (Visits.[VisitDate] BETWEEN @StartDate AND @EndDate)
    GROUP BY Barbers.ID, Barbers.[FullName], Barbers.[Gender], Barbers.[ContactPhone], Barbers.[Email], Barbers.[BirthDate], Barbers.[EmploymentDate], Barbers.[Position]
    ORDER BY COUNT(Visits.ID);

--3
CREATE FUNCTION ClientWithMostVisits()
RETURNS TABLE
AS
RETURN
    SELECT TOP 1 Clients.* FROM Clients
    INNER JOIN Visits ON Clients.ID = Visits.[ClientID]
    GROUP BY Clients.ID, Clients.[FullName], Clients.[ContactPhone], Clients.[Email]
    ORDER BY COUNT(Visits.ID);

--4
CREATE FUNCTION ClientWithMaxSpending()
RETURNS TABLE
AS
RETURN
    SELECT TOP 1 Clients.* FROM Clients
    INNER JOIN Visits ON Clients.ID = Visits.[ClientID]
    GROUP BY Clients.ID, Clients.[FullName], Clients.[ContactPhone], Clients.[Email]
    ORDER BY SUM(Visits.[TotalCost]);

--5
CREATE FUNCTION LongestDurationService()
RETURNS TABLE
AS
RETURN
    SELECT TOP 1 * FROM Services
    ORDER BY [DurationMinutes];

--Part2
--1
CREATE FUNCTION MostPopularBarber()
RETURNS TABLE
AS
RETURN
    SELECT TOP 1 Barbers.* FROM Barbers
    INNER JOIN Visits ON Barbers.ID = Visits.[BarberID]
    GROUP BY Barbers.ID, Barbers.[FullName], Barbers.[Gender], Barbers.[ContactPhone], Barbers.[Email], Barbers.[BirthDate], Barbers.[EmploymentDate], Barbers.[Position]
    ORDER BY COUNT(Visits.ID);

--2
CREATE PROCEDURE TopBarbersByRevenue(@Month INT, @Year INT)
AS
BEGIN
    SELECT TOP 3 Barbers.* FROM Barbers
    INNER JOIN Visits ON Barbers.ID = Visits.[BarberID]
    WHERE (MONTH(Visits.[VisitDate]) = @Month AND YEAR(Visits.[VisitDate]) = @Year)
    GROUP BY Barbers.ID, Barbers.[FullName], Barbers.[Gender], Barbers.[ContactPhone], Barbers.[Email], Barbers.[BirthDate], Barbers.[EmploymentDate], Barbers.[Position]
    ORDER BY SUM(Visits.[TotalCost]);
END;

--3
CREATE PROCEDURE TopBarbersByRating
AS
BEGIN
    SELECT TOP 3 Barbers.* FROM Barbers
    INNER JOIN Ratings ON Barbers.ID = Ratings.[BarberID]
    INNER JOIN Visits ON Barbers.ID = Visits.[BarberID]
    GROUP BY Barbers.ID, Barbers.[FullName], Barbers.[Gender], Barbers.[ContactPhone], Barbers.[Email], Barbers.[BirthDate], Barbers.[EmploymentDate], Barbers.[Position]
    HAVING (COUNT(Visits.ID) >= 30)
    ORDER BY AVG(CONVERT(DECIMAL(5,2), Ratings.[Rating])) DESC;
END;

--8
CREATE TRIGGER PreventJuniorBarberOverflow
ON Barbers
AFTER INSERT
AS
BEGIN
    IF (SELECT COUNT(*) FROM Barbers WHERE ([Position] = 'Junior Barber') > 5)
    BEGIN
        RAISERROR('This is the max limit', 16, 1);
        ROLLBACK;
    END;
END;

--9
CREATE FUNCTION ClientsWithoutFeedback()
RETURNS TABLE
AS
RETURN
    SELECT Clients.* FROM Clients
    LEFT JOIN ClientFeedbacks ON Clients.ID = ClientFeedbacks.[ClientID]
    LEFT JOIN ClientRatings ON Clients.ID = ClientRatings.[ClientID]
    WHERE (ClientFeedbacks.ID IS NULL AND ClientRatings.ID IS NULL);

--10
CREATE FUNCTION InactiveClients()
RETURNS TABLE
AS
RETURN
    SELECT Clients.* FROM Clients
    LEFT JOIN Visits ON Clients.ID = Visits.[ClientID]
    WHERE ((Visits.ID IS NULL) OR (Visits.[VisitDate] < DATEADD(YEAR, -1, GETDATE())));