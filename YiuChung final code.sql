--BUSINESS RULES

--ALCOHOL LAW: no customer under the age of 21 can purchase alcohol.
USE INFO330_PROJ_A13
GO 
CREATE FUNCTION fn_alcohollaw()
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
	AND PT.ProductTypeName = 'alcohol'
	)
	SET @RET = 1
	RETURN @RET 
	END 
	GO

	ALTER TABLE tblORDERPRODUCT WITH NOCHECK
	ADD CONSTRAINT ck_alcohollaw
	CHECK (dbo.fn_alcohollaw() = 0)


	
-- RULE: A store can only have a maximum of 50 products that are type 'alcohol'
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

--COMPUTED COLUMNS
--create a computed column to measure the total amount each customer have spent at the grocery store
GO
CREATE FUNCTION fn_totalspent1(@pk int)
RETURNS NUMERIC 
AS
BEGIN 
	DECLARE @RET NUMERIC =
	(SELECT SUM(O.OrderPrice)
	FROM tblCUSTOMER C 
	JOIN tblORDER O ON C.CUSTOMERID = O.CUSTOMERID 
	WHERE C.CUSTOMERID = @pk 
	)
	return @ret 
	end 
	go

ALTER TABLE tblCUSTOMER
ADD TotalSpent AS (dbo.fn_totalspent1(CUSTOMERID))

-- create a computed column to give the product that has the highest quantity in each store
GO
CREATE FUNCTION fn_GetMostProduct(@StoreID INT)
RETURNS VARCHAR(100)
AS
    BEGIN
        DECLARE @Quantity INT, @Product VARCHAR(100), @Ret VARCHAR(100)
        SET @Quantity = (SELECT MAX(SP.StoreProductQuantity)
                                    FROM tblStoreProduct AS SP
                                    WHERE SP.StoreID = @StoreID)
        SET @Product = (SELECT TOP 1 P.ProductName
                                    FROM tblStoreProduct AS SP
                                    JOIN tblProduct AS P ON SP.ProductID = P.ProductID
                                    WHERE SP.StoreID = @StoreID AND
                                          SP.StoreProductQuantity = @Quantity)
        SET @Ret = CONCAT(@Product, '-', @Quantity)
        RETURN @Ret
    END
GO
ALTER TABLE dbo.tblStore
ADD highestQuantityProduct AS (dbo.fn_GetMostProduct(StoreID));

-- Stored Procedures 
-- creates a stored procedure to insert new product orders in tblOrderProduct
GO 
CREATE PROCEDURE uspOrderProduct
@companyname varchar(20),
@brandname varchar(20),
@producttypename varchar(20),
@productname varchar(20),
@cFname varchar(20),
@CLname varchar(20),
@Cbday DATE,
@Cstate varchar(20),
@ordertypename varchar (20),
@quantity INTEGER

AS DECLARE @p_id INT, @o_id INT

SET @p_id = (SELECT productid
				FROM tblProduct P 
				JOIN tblBrand B ON P.BrandID = B.BrandID
				JOIN tblProductType PT ON P.ProductTypeID = PT.ProductTypeID
				JOIN tblCompany C on B.CompanyID = C.CompanyID
				WHERE P.ProductName = @productname
				AND B.BrandName = @brandname
				AND C.CompanyName = @companyname
				AND PT.ProductTypeName = @producttypename
				)

SET @o_id = (SELECT orderiD		
				FROM tblOrder O 
				JOIN tblCustomer C on O.CustomerID = C.CustomerID
				JOIN tblOrderType OT on O.OrderTypeID = OT.OrderTypeID
				WHERE C.CustomerFname = @cFname 
				AND C.CustomerLname = @CLname
				AND C.CustomerBirth = @Cbday
				AND C.CustomerState = @Cstate
				AND OT.OrderTypeName =  @ordertypename
)

begin tran newOrderProduct 
	INSERT INTO tblOrderProduct(ProductID, OrderID, Quantity)

	values(@p_id, @o_id, @quantity)

commit tran newOrderProduct


-- creates a stored procedure to insert new orders in tblOrder
GO
CREATE PROCEDURE uspOrder
@cFname varchar(20),
@CLname varchar(20),
@Cbday DATE,
@Cstate varchar(20),
@ordertypename varchar(20),
@orderDate DATE 


AS DECLARE @C_id INT, @OT_id INT

SET @C_id = (SELECT CustomerID
				FROM tblCustomer C
				WHERE C.CustomerFname = @cFname 
				AND C.CustomerLname = @CLname
				AND C.CustomerBirth = @Cbday
				AND C.CustomerState = @Cstate
				)

SET @OT_id = (SELECT OrderTypeID
				FROM tblOrderType OT
				WHERE OT.OrderTypeName = @ordertypename
				)

begin tran newOrder
	INSERT INTO tblOrder(CustomerID, OrderTypeID, OrderDate)
	values(@C_id, @OT_id, @orderDate)
commit tran newOrder


--COMPLEX QUERIES
-- Sorts out the top 5 companies that has the most pharmecutical brands
USE INFO330_PROJ_A13
SELECT C.CompanyName, COUNT(*) AS NumberOfPharmBrands, NumOfProductsSold
from tblBrand B 
join tblCompany C on B.CompanyID = C.CompanyID
JOIN tblProduct P on B.BrandID = P.BrandID 
JOIN tblProductType PT on P.ProductTypeID = PT.ProductTypeID
JOIN (SELECT C.CompanyID, C.CompanyName, SUM(StoreProductQuantity) AS NumOfProductsSold
FROM tblCompany C
JOIN tblBrand B ON C.CompanyID = B.CompanyID
JOIN tblProduct P ON B.BrandID = P.BrandID
JOIN tblStoreProduct SP ON P.ProductID = SP.ProductID
JOIN tblStore S ON SP.StoreID = S.StoreID
WHERE S.StoreName = 'COSTCO'
GROUP BY C.CompanyID, C.CompanyName
HAVING SUM(StoreProductQuantity) > 2000
) as subq1 on C.CompanyID = subq1.CompanyID
WHERE PT.ProductTypeName = 'pharmacy'
GROUP BY C.CompanyName, C.CompanyID, NumOfProductsSold
HAVING COUNT(*) > 1
ORDER BY NumberOfPharmBrands DESC

-- Finds male customers that spent over $3000 since 5/31/2019
SELECT  S.StoreName, C.CustomerID, C.CustomerFname, C.CustomerLname, SUM(O.OrderPrice) AS total
FROM tblCustomer C
JOIN tblOrder O on C.CustomerID = O.CustomerID 
JOIN tblGender G on C.GenderID = G.GenderID
JOIN tblOrderProduct OP ON O.OrderID = OP.OrderID
JOIN tblProduct P ON OP.ProductID = P.ProductID 
JOIN tblStoreProduct SP ON P.ProductID = SP.ProductID
JOIN tblStore S ON SP.StoreID = S.StoreID
WHERE G.GenderName = 'Male'
AND O.OrderDate > '1/1/2020'
AND S.StoreName = 'COSTCO'
GROUP BY S.StoreName, C.CustomerID, C.CustomerFname, C.CustomerLname
Having SUM(O.OrderPrice) > 30
ORDER BY total DESC



