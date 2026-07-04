CREATE DATABASE retail_sales;
USE retail_sales;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50),
    Gender VARCHAR(10),
    Age INT
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Quantity INT,
    Price INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Customers VALUES
(1,'Raj','Madurai','Male',24),
(2,'Priya','Chennai','Female',26),
(3,'Arun','Madurai','Male',30),
(4,'Kavi','Coimbatore','Female',28),
(5,'Vijay','Chennai','Male',35),
(6,'Anu','Madurai','Female',22),
(7,'Rahul','Bangalore','Male',29),
(8,'Meena','Coimbatore','Female',31);

INSERT INTO Orders VALUES
(101,1,'Laptop','Electronics',1,50000,'2024-01-10'),
(102,2,'Mobile','Electronics',2,20000,'2024-01-12'),
(103,1,'Mouse','Accessories',2,1000,'2024-01-15'),
(104,3,'Chair','Furniture',1,7000,'2024-02-01'),
(105,4,'Laptop','Electronics',1,55000,'2024-02-05'),
(106,5,'Desk','Furniture',1,12000,'2024-02-10'),
(107,6,'Keyboard','Accessories',1,2500,'2024-02-12'),
(108,7,'Monitor','Electronics',2,15000,'2024-03-01'),
(109,8,'Tablet','Electronics',1,30000,'2024-03-08'),
(110,2,'Headphones','Accessories',1,5000,'2024-03-12');
