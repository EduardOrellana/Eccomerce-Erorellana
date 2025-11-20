UPDATE Orders o
JOIN (
	SELECT
		Orders_idOrders AS OrderID,
        SUM(SubTotal) AS Total
	FROM OrderDetails
    GROUP BY Orders_idOrders
) d ON o.idOrders = d.OrderID
SET o.TotalAmount = d.Total;
