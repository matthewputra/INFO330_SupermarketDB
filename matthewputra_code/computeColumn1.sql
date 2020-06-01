-- Compute Column 1
--Measure the total number of orders each customer completed
CREATE FUNCTION fn_totalorder3(@pk int)
RETURNS INT 
AS
    BEGIN
        DECLARE @RET INT = (SELECT COUNT(O.ORDERID)
                            FROM tblCUSTOMER C
                            JOIN tblORDER O ON C.CUSTOMERID = O.CUSTOMERID
                            WHERE C.CUSTOMERID = @pk)
        RETURN @ret
	END
GO
ALTER TABLE tblCUSTOMER
ADD NumOrders AS (dbo.fn_totalorder3(CUSTOMERID))
