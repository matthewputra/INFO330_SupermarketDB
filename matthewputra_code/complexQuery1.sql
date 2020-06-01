-- Complex Query 1
-- Customer who are in the age range of 30-40 who ordered product type of 'baby' group by the gender in Costco Washington where
-- the order status has been completed
SELECT G.GenderName, COUNT(OS.OrderStatusID) AS totalOrder
FROM tblCustomer AS C
JOIN tblGender AS G ON C.GenderID = G.GenderID
JOIN tblOrder AS O ON C.CustomerID = O.CustomerID
JOIN tblOrderStatus AS OS ON O.OrderID = OS.OrderID
JOIN tblStatus AS ST ON OS.StatusID = ST.StatusID
JOIN tblOrderProduct AS OP ON O.OrderID = OP.OrderID
JOIN tblProduct AS P ON OP.ProductID = P.ProductID
JOIN tblProductType AS PT ON P.ProductTypeID = PT.ProductTypeID
JOIN tblStoreProduct AS SP ON P.ProductID = SP.ProductID
JOIN tblStore AS S ON SP.StoreID = S.StoreID
WHERE CustomerBirth BETWEEN DATEADD(year, -40, GETDATE()) AND DATEADD(year, -30, GETDATE()) AND
      PT.ProductTypeName = 'baby' AND
      S.StoreName = 'Costco' AND
      S.StoreState = 'Washington WA' AND
      ST.StatusName = 'completed'
GROUP BY G.GenderID, G.GenderName
ORDER BY COUNT(OS.OrderStatusID);