-- Stored Procedure 1
-- Insert into tblStoreProduct
CREATE PROCEDURE uspInsertStoreProduct
@ProductName VARCHAR(100),
@Brand VARCHAR(30),
@StoreName VARCHAR(30),
@StoreAddress VARCHAR(100),
@Quantity INT
AS
    DECLARE @PID INT, @SID INT
        SET @PID = (SELECT P.ProductID
                    FROM tblProduct AS P
                    JOIN tblBrand AS B ON P.BrandID = B.BrandID
                    WHERE B.BrandName = @Brand AND
                          P.ProductName = @ProductName)
        SET @SID = (SELECT S.StoreID
                    FROM tblStore AS S
                    WHERE S.StoreName = @StoreName AND
                          S.StoreAddress = @StoreAddress)
    BEGIN TRAN newStoreProduct
        INSERT INTO tblStoreProduct(ProductID, StoreID, StoreProductQuantity)
        VALUES (@PID, @SID, @Quantity)
    COMMIT TRAN newStoreProduct
GO
