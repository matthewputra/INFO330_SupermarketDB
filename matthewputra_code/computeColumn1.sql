-- Compute Column 1
-- Give the product that has the highest quantity in each store
CREATE FUNCTION fn_GetMostProduct(@StoreID INT)
RETURNS VARCHAR(100)
AS
    BEGIN
        DECLARE @Quantity INT, @Ret VARCHAR(100)
        SET @Quantity = (SELECT MAX(SP.StoreProductQuantity)
                                    FROM tblStoreProduct AS SP
                                    WHERE SP.StoreID = @StoreID)
        SET @Ret = (SELECT TOP 1 P.ProductName
                                    FROM tblStoreProduct AS SP
                                    JOIN tblProduct AS P ON SP.ProductID = P.ProductID
                                    WHERE SP.StoreID = @StoreID AND
                                          SP.StoreProductQuantity = @Quantity)
        RETURN @Ret
    END
GO
ALTER TABLE dbo.tblStore
ADD highestQuantityProduct AS (dbo.fn_GetMostProduct(StoreID));
