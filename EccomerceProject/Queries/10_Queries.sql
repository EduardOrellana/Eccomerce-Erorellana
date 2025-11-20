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
    c.Name AS Customer,
    o.idOrders AS OrderID,
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


