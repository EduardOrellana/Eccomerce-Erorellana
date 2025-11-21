-- List of the 10 Queires to Analyze this Database.

-- 1) Top Customers with more Purchases

SELECT
	c.Name as 'Customer',
    SUM(o.TotalAmount) 'Total'
FROM Customers c
JOIN Orders o ON c.idCustomers = o.Customers_idCustomers
GROUP BY c.Name
ORDER BY Total DESC
LIMIT 10;

-- 2) Orders with more than 9 Different Products in the Details include their Customers and Quantity

SELECT
    o.idOrders AS OrderID,
    c.Name AS Customer,
    p.Name AS Product,
    SUM(od.Quantity) AS Quantity
FROM Customers c
JOIN Orders o ON o.Customers_idCustomers = c.idCustomers
JOIN OrderDetails od ON od.Orders_idOrders = o.idOrders
JOIN Products p ON p.idProducts = od.Products_idProducts
WHERE o.idOrders IN (
    SELECT Orders_idOrders
    FROM OrderDetails
    GROUP BY Orders_idOrders
    HAVING COUNT(DISTINCT Products_idProducts) > 9
)
GROUP BY c.Name, o.idOrders, p.Name
ORDER BY o.idOrders, p.Name;


-- 3) Clients with no sales

SELECT 
    c.Name
FROM Customers c
LEFT JOIN Orders o ON o.Customers_idCustomers = c.idCustomers
GROUP BY c.Name
HAVING SUM(TotalAmount) is NULL;

-- 4) Top 10 Dates with more total amount

SELECT
	OrderDate,
    SUM(TotalAmount) AS 'Total Amount',
    COUNT(idOrders) AS 'Total Orders'
FROM Orders
GROUP BY OrderDate
ORDER BY 'Total Amount' DESC
LIMIT 10;


-- 5) Top Customers 10 with less Purchase

SELECT
	c.Name as 'Customer',
    SUM(o.TotalAmount) 'Total'
FROM Customers c
JOIN Orders o ON c.idCustomers = o.Customers_idCustomers
GROUP BY c.Name
ORDER BY Total ASC
LIMIT 10;


-- 6) Orders with less than 5 Different Products in the Details include their Customers and Quantity

SELECT
    o.idOrders AS OrderID,
    c.Name AS Customer,
    p.Name AS Product,
    SUM(od.Quantity) AS Quantity
FROM Customers c
JOIN Orders o ON o.Customers_idCustomers = c.idCustomers
JOIN OrderDetails od ON od.Orders_idOrders = o.idOrders
JOIN Products p ON p.idProducts = od.Products_idProducts
WHERE o.idOrders IN (
    SELECT Orders_idOrders
    FROM OrderDetails
    GROUP BY Orders_idOrders
    HAVING COUNT(DISTINCT Products_idProducts) < 5
)
GROUP BY c.Name, o.idOrders, p.Name
ORDER BY o.idOrders, p.Name;


-- 7) The most popular Category

SELECT
	c.idCategory,
	c.Name as 'Category',
    SUM(od.Quantity) 'Quantity'
FROM Category c
JOIN Products p ON p.Category_idCategory = c.idCategory
JOIN OrderDetails od ON od.Products_idProducts = p.idProducts
GROUP BY c.idCategory, c.Name
ORDER BY Quantity DESC;


-- 8) The highest Order and their Customer

SELECT 
    o.idOrders,
    o.TotalAmount,
    c.Name AS Customer
FROM Orders o
JOIN Customers c ON c.idCustomers = o.Customers_idCustomers
ORDER BY o.TotalAmount DESC
LIMIT 1;


-- 9) The lowest Order and their Cusomter

SELECT 
    o.idOrders,
    o.TotalAmount,
    c.Name AS Customer
FROM Orders o
JOIN Customers c ON c.idCustomers = o.Customers_idCustomers
ORDER BY o.TotalAmount ASC
LIMIT 1;


-- 10) The Orders with no Details

SELECT
	o.idOrders,
    c.Name as 'Customer'
FROM Orders o
LEFT JOIN OrderDetails od
	ON od.Orders_idOrders = o.idOrders
JOIN Customers c
	ON c.idCustomers = o.Customers_idCustomers
WHERE od.Orders_idOrders is NULL;

-- 11) Full Table to Export to Tableu
SELECT
	*
FROM Category;

SELECT
	*
FROM Customers;

SELECT
	*
FROM OrderDetails;

SELECT
	*
FROM Orders;

SELECT
	*
FROM Products
