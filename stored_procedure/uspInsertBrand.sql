USE INFO330_PROJ_A13
CREATE PROCEDURE uspInsertBrand
@Brand VARCHAR(30),
@Company VARCHAR(100)
AS
    DECLARE @CID INT
    SET @CID = (SELECT CompanyID FROM tblCompany WHERE CompanyName = @Company)
    BEGIN TRAN insertBrand
        INSERT INTO tblBrand(BrandName, CompanyID)
        VALUES (@Brand, @CID)
    COMMIT TRAN insertBrand
GO


