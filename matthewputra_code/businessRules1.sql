-- Business Rules 1
-- Definition : A store can only have a maximum of 50 products that are type 'alcohol'
-- Code
CREATE FUNCTION fn_CheckAlcoholProduct()
RETURNS INT
AS
    BEGIN
        DECLARE @Ret INT = 0
        IF EXISTS(SELECT SP.StoreID
            FROM tblStoreProduct AS SP
            JOIN tblProduct AS P ON SP.ProductID = P.ProductID
            JOIN tblProductType AS PT ON P.ProductTypeID = PT.ProductTypeID
            WHERE PT.ProductTypeName = 'alcohol'
            GROUP BY SP.StoreID
            HAVING COUNT(P.ProductID) > 50)
        SET @Ret = 1
        RETURN @Ret
    END
GO
ALTER TABLE tblStoreProduct
ADD CONSTRAINT CK_NoStoreOver50AlcoholType
CHECK (dbo.fn_CheckAlcoholProduct() = 0);
