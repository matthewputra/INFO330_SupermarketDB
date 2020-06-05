USE INFO330_PROJ_A13
CREATE PROCEDURE uspInsertProduct
@Product VARCHAR(100),
@Brand VARCHAR(30),
@Type VARCHAR(50)
AS
    DECLARE @BID INT, @PTID INT
    SET @BID = (SELECT BrandID FROM tblBrand WHERE BrandName = @Brand)
    SET @PTID = (SELECT ProductTypeID FROM tblProductType WHERE ProductTypeName = @Type)
    BEGIN TRAN insertProduct
        INSERT INTO tblProduct(ProductName, BrandID, ProductTypeID)
        VALUES (@Product, @BID, @PTID)
    COMMIT TRAN insertProduct
GO