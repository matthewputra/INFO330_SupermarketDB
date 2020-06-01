-- Business Rules 1
-- Definition : no customer under the age of 21 can purchase any tobacco products.
CREATE FUNCTION fn_tobaccolaw()
RETURNS INT 
AS
BEGIN 
	DECLARE @RET INT = 0
	IF EXISTS
	(SELECT *
	FROM tblCUSTOMER C
	JOIN tblORDER O ON C.CUSTOMERID = O.CUSTOMERID 
	JOIN tblORDERPRODUCT OP ON O.ORDERID = OP.ORDERID
	JOIN tblPRODUCT P ON OP.PRODUCTID = P.PRODUCTID 
	JOIN tblProductType PT ON P.ProductTypeID = PT.ProductTypeID

	WHERE C.CustomerBirth > DATEADD(year, -21, getdate())
	AND PT.ProductTypeName = 'tobacco'
	)
	SET @RET = 1
	RETURN @RET 
	END 
	GO

	ALTER TABLE tblORDERPRODUCT WITH NOCHECK
	ADD CONSTRAINT ck_tobaccolaw
	CHECK (dbo.fn_tobaccolaw() = 0)
