CREATE TABLE Products (
    [ProductID] INT PRIMARY KEY,
    [ProductName] NVARCHAR(100) NOT NULL
);

CREATE TABLE Categories (
    [CategoryID] int PRIMARY KEY,
    [CategoryName] NVARCHAR(100) NOT NULL
);

CREATE TABLE ProductCategories (
    [ProductID] INT FOREIGN KEY REFERENCES Products(ProductID),
    [CategoryID] INT FOREIGN KEY REFERENCES Categories(CategoryID)
);


SELECT P.ProductName, C.CategoryName
FROM Products P
LEFT JOIN ProductCategories PC ON P.ProductID = PC.ProductID
LEFT JOIN Categories C ON PC.CategoryID = C.CategoryID