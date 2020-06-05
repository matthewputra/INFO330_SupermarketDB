USE INFO330_PROJ_A13
CREATE PROCEDURE uspInsertProductPrice
@Product VARCHAR(100),
@Brand VARCHAR(30),
@Price DECIMAL(10, 2),
@Bdate DATE,
@Edate DATE
AS
    DECLARE @PID INT
    SET @PID = (SELECT P.ProductID
                FROM tblProduct AS P
                JOIN tblBrand AS B ON P.BrandID = B.BrandID
                WHERE P.ProductName = @Product AND
                      B.BrandName = @Brand)
    BEGIN TRAN insertProductPrice
        INSERT INTO tblProductPrice(ProductID, ProductPrice, ProductPriceBeginDate, ProductPriceEndDate)
        VALUES (@PID, @Price, @Bdate, @Edate)
    COMMIT TRAN insertProductPrice
GO

