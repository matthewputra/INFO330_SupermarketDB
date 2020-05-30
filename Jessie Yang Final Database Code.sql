/* Stored Procedures */
/* Insert a new row into tblEmployeeDepartment - Assign an exsiting employee to a department */
CREATE PROCEDURE usp_INSERT_EMPLOYEE_DEPARTMENT
@FirstName varchar(30),
@LastName varchar(30),
@Gender varchar(10),
@BirthDate DATE,
@DeptName varchar(30),
@PosName varchar(30),
@StartDate DATE,
@EndDate DATE

AS

DECLARE @GendID INT, @EmpID INT, @DeptID INT, @PosID INT
SET @GendID = (select GenderID from tblGender where GenderName = @Gender)
SET @EmpID = (select EmployeeID from tblEmployee where GenderID = @GendID
												 AND EmployeeFname = @FirstName
												 AND EmployeeLname = @LastName
												 AND EmployeeBirth = @BirthDate)
SET @DeptID = (select DepartmentID from tblDepartment where DepartmentName = @DeptName)
SET @PosID = (select PositionID from tblPosition where PositionName = @PosName)

INSERT INTO tblEmployeeDepartment(EmployeeID, DepartmentID, PositionID, EmployeeDepartmentStartDate, EmployeeDepartmentEndDate)
VALUES(@EmpID, @DeptID, @PosID, @StartDate, @EndDate)

/* Insert a new row into tblIncident - Record a new incident */
CREATE PROCEDURE usp_INSERT_INCIDENT_HISTORY
@TypeName varchar(30),
@IncidName varchar(30),
@LocateName varchar(30),
@InSTDate DATE,
@InENDate DATE,
@FirstName varchar(30),
@LastName varchar(30),
@BirthDate DATE,
@Gender varchar(10),
@OdTypeName varchar(30),
@OdDate DATE,
@StatName varchar(30),
@OSBEDate DATE,
@OSENDate DATE,
@HistDescription varchar(50)

AS

DECLARE @TypeID INT, @LocateID INT, @IncidID INT, @StatID INT, @OrTypeID INT, @GendID INT, @CustID INT, @OdID INT, @OStatID INT
SET @TypeID = (select IncidentTypeID from tblIncidentType where IncidentTypeName = @TypeName)
SET @LocateID = (select LocationID from tblLocation where LocationName = @LocateName)
SET @IncidID = (select IncidentID from tblIncident where IncidentTypeID = @TypeID
												   AND IncidentName = @IncidName
												   AND LocationID = @LocateID
												   AND StartDate = @InSTDate
												   AND EndDate = @InENDate)
SET @StatID = (select StatusID from tblStatus where StatusName = @StatName)
SET @GendID = (select GenderID from tblGender where GenderName = @Gender)
SET @CustID = (select CustomerID from tblCustomer where GenderID = @GendID
												  AND CustomerFname = @FirstName
												  AND CustomerLname = @LastName
												  AND CustomerBirth = @BirthDate)
SET @OrTypeID = (select OrderTypeID from tblOrderType where OrderTypeName = @OdTypeName)
SET @OdID = (select OrderID from tblOrder where CustomerID = @CustID
										  AND OrderTypeID = @OrTypeID
										  AND OrderDate = @OdDate)
SET @OStatID = (select OrderStatusID from tblOrderStatus where OrderID = @OdID
														 AND StatusID = @StatID
														 AND BeginDate = @OSBEDate
														 AND EndDate = @OSENDate)

INSERT INTO tblIncidentHistory(OrderStatusID, IncidentID, IncidentHistoryDescription)
VALUES(@OStatID, @IncidID, @HistDescription)

/* Business Rules */
/* Customers in WA, OR and CA can only buy a maximum of 2 hand sanitizers per online order. */
CREATE FUNCTION fn_NoMoreThan2Sanitizers()
RETURNS INT
AS
BEGIN

DECLARE @Ret INT = 0
IF EXISTS (select O.OrderID
		   from tblOrder O
			   JOIN tblOrderType OT ON OT.OrderTypeID = O.OrderTypeID
			   JOIN tblCustomer C ON C.CustomerID = O.CustomerID
			   JOIN tblOrderProduct OP ON OP.OrderID = O.OrderID
			   JOIN tblProduct P ON P.ProductID = OP.ProductID
			   JOIN tblProductType PT ON PT.ProductTypeID = P.ProductTypeID
			where PT.ProductTypeName LIKE '%hand sanitizer%'
			AND OT.OrderTypeName = 'Online'
			AND (C.CustomerState LIKE '%Washington%'
			OR C.CustomerState LIKE '%Oregon%'
			OR C.CustomerState LIKE '%California%')
			GROUP BY O.OrderID
			HAVING COUNT(P.ProductID) > 2)
	BEGIN
		SET @Ret = 1
	END
RETURN @RET
END
GO

ALTER TABLE tblORDERProduct WITH NOCHECK
ADD CONSTRAINT AtMost2Sanitizers
CHECK (dbo.fn_NoMoreThan2Sanitizers() = 0)
GO

/* Each supplier can provide no more than 1,000 Magnum-(Brand) ice cream to Stores in WA where
   this product quality in the store-(StoreProductQuality) greater than 3,000 .*/
CREATE FUNCTION fn_NoMoreThan1000Magnum()
RETURNS INT
AS
BEGIN

DECLARE @Ret INT = 0
IF EXISTS (select S.SupplierID
		   from tblSupplier S
			   JOIN tblProductSupply PS ON PS.SupplierID = S.SupplierID
			   JOIN tblProduct P ON P.ProductID = PS.ProductID
			   JOIN tblBrand B ON B.BrandID = P.BrandID
			   JOIN tblProductType PT ON PT.ProductTypeID = P.ProductTypeID
			   JOIN tblStoreProduct SP ON SP.ProductID = P.ProductID
			   JOIN tblStore ST ON ST.StoreID = SP.StoreID
			where B.BrandName = 'Magnum'
			AND PT.ProductTypeName LIKE '%ice cream%'
			AND ST.StoreState LIKE '%Washington%'
			AND SP.StoreProductQuantity > 3000
			GROUP BY S.SupplierID
			HAVING COUNT(P.ProductID) > 1000)
	BEGIN
		SET @Ret = 1
	END
RETURN @RET
END
GO

ALTER TABLE tblProductSupply WITH NOCHECK
ADD CONSTRAINT AtMost1000Magnum
CHECK (dbo.fn_NoMoreThan1000Magnum() = 0)
GO

/* Computed Columns */
/* Create a computed column to calculate the number of employees who was born after January 01, 1990
   receiving a salary more than 3,000.00 in each department. */
CREATE FUNCTION fn_SumOfEmployee(@PK INT)
RETURNS INT
AS
BEGIN
	DECLARE @Ret INT = (select COUNT(E.EmployeeID)
						from tblEmployee E
							JOIN tblEmployeeSalary ES ON E.EmployeeID = ES.EmployeeID
							JOIN tblEmployeeDepartment ED ON ED.EmployeeID = E.EmployeeID
							JOIN tblDepartment D ON D.DepartmentID = ED.DepartmentID
						where D.DepartmentID = @PK
						AND E.EmployeeBirth > 'January 01, 1990'
						AND ES.EmployeeSalary > 3000.00)
	RETURN @Ret
END
GO

ALTER TABLE tblDEPARTMENT
ADD TotalEmployees AS (dbo.fn_SumOfEmployee(DepartmentID))
GO

/* Create a computed column to calculate the number of alcohols sold in each online order. */
CREATE FUNCTION fn_TotalAlcoholsOnlineOrder(@PK INT)
RETURNS INT
AS
BEGIN
	DECLARE @Ret INT = (select COUNT(P.ProductID)
						from tblProduct P
							JOIN tblProductType PT ON PT.ProductTypeID = P.ProductTypeID
							JOIN tblOrderProduct OP ON OP.ProductID = P.ProductID
							JOIN tblOrder O ON O.OrderID = OP.OrderID
							JOIN tblOrderType OT ON OT.OrderTypeID = O.OrderTypeID
					where O.OrderID = @PK
					AND OT.OrderTypeName = 'Online'
					AND PT.ProductTypeName LIKE '%Alcohol%')
	RETURN @Ret
END
GO

ALTER TABLE tblOrder
ADD TotalAlcoholsSold AS (dbo.fn_TotalAlcoholsOnlineOrder(OrderID))
GO

/* Queries */
/* Select customers who bought more than 10 alcohols online before January 01, 2020 in the stores in WA state and who also
   lost more than 2 orders-(incident) after June 06, 2019 in a location in Seattle, and this incident is resolved prior to today. */
select C.CustomerID, C.CustomerFname, C.CustomerLname, COUNT(P.ProductID) AS TotalAlcohols
from tblCustomer C
	JOIN tblOrder O ON O.CustomerID = C.CustomerID
	JOIN tblOrderType OT ON OT.OrderTypeID = O.OrderTypeID
	JOIN tblOrderProduct OP ON OP.OrderID = O.OrderID
	JOIN tblProduct P ON P.ProductID = OP.ProductID
	JOIN tblProductType PT ON PT.ProductTypeID = P.ProductTypeID
	JOIN tblStoreProduct SP ON P.ProductID = SP.ProductID
	JOIN tblStore S ON S.StoreID = SP.StoreID
	JOIN (select C.CustomerID, C.CustomerFname, C.CustomerLname, COUNT(O.OrderID) AS LostPackages
		  from tblCustomer C
			  JOIN tblOrder O ON O.CustomerID = C.CustomerID
			  JOIN tblOrderStatus OS ON OS.OrderID = O.OrderID
			  JOIN tblIncidentHistory IH ON IH.OrderStatusID = OS.OrderStatusID
			  JOIN tblIncident I ON I.IncidentID = IH.IncidentID
			  JOIN tblLocation L ON L.LocationID = I.LocationID
			  JOIN tblIncidentType IT ON IT.IncidentTypeID = I.IncidentTypeID
		  where IT.IncidentTypeName LIKE '%lost%'
		  AND I.StartDate > 'June 06, 2019'
		  AND I.EndDate < GETDATE()
		  AND L.LocationName LIKE '%Seattle%'
		  GROUP BY C.CustomerID, C.CustomerFname, C.CustomerLname
		  HAVING COUNT(O.OrderID) > 2) sub ON sub.CustomerID = C.CustomerID
where O.OrderDate < 'January 01, 2020'
AND OT.OrderTypeName = 'Online'
AND PT.ProductTypeName = 'Alcohol'
AND S.StoreState LIKE '%Washington%'
GROUP BY C.CustomerID, C.CustomerFname, C.CustomerLname, sub.LostPackages
HAVING COUNT(P.ProductID) > 10

/* Select the top 10 brands which belong to Coca Cola Company and offer products in stores in California with
   the sum of products listed DESC, whose products over 10.00 also has been supplied by supplier in Oregon state and
   the sum of store product quantity is over 1,000. */

select TOP 10 B.BrandID, B.BrandName, COUNT(P.ProductID) AS TotalProducts
from tblBrand B
	JOIN tblProduct P ON P.BrandID = B.BrandID
	JOIN tblStoreProduct SP ON SP.ProductID = P.ProductID
	JOIN tblStore S ON S.StoreID = SP.StoreID
	JOIN tblCompany C ON C.CompanyID = B.CompanyID
	JOIN (select B.BrandID, B.BrandName, SUM(PS.ProductSupplyQuantity) AS TotalQuantity
		  from tblBrand B
			  JOIN tblProduct P ON P.BrandID = B.BrandID
			  JOIN tblProductPrice PP ON PP.ProductID = P.ProductID
			  JOIN tblProductSupply PS ON PS.ProductID = P.ProductID
			  JOIN tblSupplier S ON S.SupplierID = PS.SupplierID
		  where S.SupplierState LIKE '%Oregon%'
		  AND PP.ProductPrice > 10.00
		  GROUP BY B.BrandID, B.BrandName
		  HAVING SUM(SP.StoreProductQuantity) > 1000) sub ON sub.BrandID = B.BrandID
where C.CompanyName = 'Coca Cola'
AND S.StoreState LIKE '%California%'
GROUP BY B.BrandID, B.BrandName, TotalQuantity
ORDER BY TotalProducts DESC