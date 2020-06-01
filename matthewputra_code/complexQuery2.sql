-- Complex Query 2
-- Customer who spends more or equal to 2k in Costco Washington in a single month
SELECT C.CustomerFname, C.CustomerLname, MONTH(O.OrderDate) AS month, SUM(OrderPrice) AS totalSpending
FROM tblCustomer AS C
JOIN tblOrder AS O ON C.CustomerID = O.CustomerID
JOIN tblOrderProduct AS OP ON O.OrderID = OP.OrderID
JOIN tblProduct AS P ON OP.ProductID = P.ProductID
JOIN tblStoreProduct AS SP ON P.ProductID = SP.ProductID
JOIN tblStore AS S ON SP.StoreID = S.StoreID
WHERE S.StoreName = 'Costco' AND
      S.StoreState = 'Washington WA'
GROUP BY C.CustomerID, C.CustomerFname, C.CustomerLname, MONTH(O.OrderDate)
HAVING SUM(O.OrderPrice) >= 2000;