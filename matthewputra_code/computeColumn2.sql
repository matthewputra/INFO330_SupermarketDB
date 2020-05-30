-- Compute Column 2
-- Give the product that each supplier supplies the most
CREATE FUNCTION fn_GetMostProductSupplied(@SupplierID INT)
RETURNS VARCHAR(100)
AS
    BEGIN
        DECLARE @Quantity INT, @Ret VARCHAR(100)
            SET @Quantity = (SELECT MAX(PS.ProductSupplyQuantity)
                                FROM tblProductSupply AS PS
                                WHERE PS.SupplierID = @SupplierID)
            SET @Ret = (SELECT TOP 1 P.ProductName
                            FROM tblProductSupply AS PS
                            JOIN tblProduct AS P ON PS.ProductID = P.ProductID
                            WHERE PS.SupplierID = @SupplierID AND
                                  PS.ProductSupplyQuantity = @Quantity)
        RETURN @Ret
    END
GO
ALTER TABLE dbo.tblSupplier
ADD highestQuantityProduct AS (dbo.fn_GetMostProductSupplied(SupplierID));
