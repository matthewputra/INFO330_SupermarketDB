-- Stored Procedure 2
-- Insert into tblProductSupply
CREATE PROCEDURE uspInsertProductSupply
@ProductName VARCHAR(100),
@Brand VARCHAR(30),
@Supplier VARCHAR(50),
@SupplierAddress VARCHAR(100),
@Quantity INT
AS
    DECLARE @PID INT, @SID INT
        SET @PID = (SELECT P.ProductID
                    FROM tblProduct AS P
                    JOIN tblBrand AS B ON P.BrandID = B.BrandID
                    WHERE B.BrandName = @Brand AND
                          P.ProductName = @ProductName)
        SET @SID = (SELECT S.SupplierID
                    FROM tblSupplier AS S
                    WHERE S.SupplierName = @Supplier AND
                          S.SupplierAddress = @SupplierAddress)
    BEGIN TRAN newProductSupply
        INSERT INTO tblProductSupply(SupplierID, ProductID, ProductSupplyQuantity)
        VALUES (@SID, @PID, @Quantity)
    COMMIT TRAN newProductSupply
GO
