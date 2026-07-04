-- Show Customers--

SELECT *
FROM Customers;

-- Show Orders--

SELECT *
FROM Orders;

-- Electronics Products--

SELECT *
FROM Orders
WHERE Category = 'Electronics';

SELECT DISTINCT Category
FROM Orders;

SELECT *
FROM Orders
ORDER BY Price DESC;

SELECT c.CustomerName, 
       o.ProductName
FROM customers c
INNER JOIN  orders o
ON c.customerID = o.customerID;

--Revenue By City--

SELECT c.City, 
       SUM(o.Quantity * o.Price) AS Revenue
FROM customers c
JOIN  orders o
ON c.customerID = o.customerID
GROUP BY c.City
ORDER BY Revenue DESC;

--Customer Revenue--

SELECT
    c.CustomerName,
    SUM(o.Quantity * o.Price) AS TotalRevenue
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalRevenue DESC;

SELECT c.CustomerName, 
       SUM(o.Quantity * o.Price) AS Revenue
FROM customers c
JOIN  orders o
ON c.customerID = o.customerID
GROUP BY c.CustomerName
HAVING SUM(o.Quantity * o.Price) > 40000 ;

SELECT
    c.CustomerName,
    SUM(o.Quantity * o.Price) AS TotalRevenue,
    CASE
        WHEN SUM(o.Quantity * o.Price) >= 50000 THEN 'High'
        WHEN SUM(o.Quantity * o.Price) BETWEEN 20000 AND 49999 THEN 'Medium'
        ELSE 'Low'
    END AS CustomerCategory
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;

--Subquery--

SELECT c.CustomerName,
       SUM(o.Quantity * o.Price) AS TotalRevenue
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName
HAVING SUM(o.Quantity * o.Price) > (
    SELECT AVG(CustomerTotal)
    FROM (
        SELECT SUM(o2.Quantity * o2.Price) AS CustomerTotal
        FROM Orders o2
        GROUP BY o2.CustomerID
    ) AS CustomerAverages
);

-- CTE --

WITH CustomerRevenue AS
(
    SELECT c.CustomerName,
           SUM(o.Quantity * o.Price) AS TotalRevenue
    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerName
)
SELECT *
FROM CustomerRevenue;

WITH CustomerRevenue AS
(
    SELECT c.CustomerName,
           SUM(o.Quantity * o.Price) AS TotalRevenue
    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerName
)
SELECT *
FROM CustomerRevenue
WHERE TotalRevenue > 40000;

--Window Funnction--

WITH CustomerRevenue AS
(
    SELECT c.CustomerName,
           SUM(o.Quantity * o.Price) AS TotalRevenue
    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerName
)
SELECT CustomerName,
       TotalRevenue,
       RANK() OVER (ORDER BY TotalRevenue DESC) AS Rank_
FROM CustomerRevenue;


WITH CustomerRevenue AS
(
    SELECT c.CustomerName,
           SUM(o.Quantity * o.Price) AS TotalRevenue
    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerName
)
SELECT CustomerName,
       TotalRevenue,
       ROW_NUMBER() OVER (ORDER BY TotalRevenue DESC) AS RowNum
FROM CustomerRevenue;

WITH CustomerRevenue AS
(
    SELECT c.CustomerName,
           SUM(o.Quantity * o.Price) AS TotalRevenue
    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerName
)
SELECT CustomerName,
       TotalRevenue,
       RANK()       OVER (ORDER BY TotalRevenue DESC) AS Rank_,
       DENSE_RANK() OVER (ORDER BY TotalRevenue DESC) AS DenseRank_
FROM CustomerRevenue;

WITH CustomerRevenue AS
(
    SELECT c.CustomerName,
           SUM(o.Quantity * o.Price) AS TotalRevenue
    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    GROUP BY c.CustomerName
),
RankedCustomers AS
(
    SELECT CustomerName,
           TotalRevenue,
           RANK() OVER (ORDER BY TotalRevenue DESC) AS Rank_
    FROM CustomerRevenue
)
SELECT CustomerName,
       TotalRevenue,
       Rank_
FROM RankedCustomers
WHERE Rank_ <= 2;

