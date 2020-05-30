-- Business Rules 2
-- Definition : A store can only have a maximum total quantity of 500 products under the type 'tobacco'
CREATE FUNCTION fn_CheckTobaccoQuantity()
RETURNS INT
AS
    BEGIN
        DECLARE @Ret INT = 0
        IF EXISTS(SELECT SP.StoreID
            FROM tblStoreProduct AS SP
            JOIN tblProduct AS P ON SP.ProductID = P.ProductID
            JOIN tblProductType AS PT ON P.ProductTypeID = PT.ProductTypeID
            WHERE PT.ProductTypeName = 'tobacco'
            GROUP BY SP.StoreID
            HAVING SUM(SP.StoreProductQuantity) > 500)
        SET @Ret = 1
        RETURN @Ret
    END
GO
ALTER TABLE tblStoreProduct
ADD CONSTRAINT CK_NoStoreOver500Tobacco
CHECK (dbo.fn_CheckTobaccoQuantity() = 0);
