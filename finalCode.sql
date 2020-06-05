-- Code to Create Tables
--
--
-- tblOrderProduct
CREATE TABLE tblOrderProduct(
    OrderProductID INT IDENTITY(1, 1) PRIMARY KEY,
    ProductID INT NOT NULL REFERENCES tblProduct,
    OrderID INT NOT NULL REFERENCES tblOrder,
    Quantity INT NOT NULL
)

-- tblOrder
CREATE TABLE tblOrder(
    OrderID INT IDENTITY(1, 1) PRIMARY KEY,
    CustomerID INT NOT NULL REFERENCES tblCustomer,
    OrderTypeID INT NOT NULL REFERENCES tblOrderType,
    OrderDate DATE NOT NULL,
    OrderPrice DECIMAL(10, 2) NOT NULL,
    OrderPaymentMethod VARCHAR(20) NOT NULL
)

--tblOrderType
CREATE TABLE tblOrderType(
    OrderTypeID INT IDENTITY(1, 1) PRIMARY KEY,
    OrderTypeName VARCHAR(20) NOT NULL
)

--tblCustomer
CREATE TABLE tblCustomer(
    CustomerID INT IDENTITY(1, 1) PRIMARY KEY,
    CustomerFname VARCHAR(30) NOT NULL,
    CustomerLname VARCHAR(30),
    GenderID INT NOT NULL REFERENCES tblGender,
    CustomerBirth DATE NOT NULL,
    CustomerAddress VARCHAR(100) NOT NULL,
    CustomerCity VARCHAR(20) NOT NULL,
    CustomerState VARCHAR(20) NOT NULL,
    CustomerZipcode INT NOT NULL,
    CustomerEmail VARCHAR(50) NOT NULL,
    CustomerPhone VARCHAR(15)
)

--tblGender
CREATE TABLE tblGender(
    GenderID INT IDENTITY(1, 1) PRIMARY KEY,
    GenderName VARCHAR(20) NOT NULL
)

--tblOrderStatus
CREATE TABLE tblOrderStatus(
    OrderStatusID INT IDENTITY(1, 1) PRIMARY KEY,
    OrderID INT NOT NULL REFERENCES tblOrder,
    StatusID INT NOT NULL REFERENCES tblStatus,
    BeginDate DATE NOT NULL,
    EndDate DATE
)

--tblStatus
CREATE TABLE tblStatus(
    StatusID INT IDENTITY(1, 1) PRIMARY KEY,
    StatusName VARCHAR(20) NOT NULL
)

--tblReview
CREATE TABLE tblReview(
    ReviewID INT IDENTITY(1, 1) PRIMARY KEY,
    RatingID INT REFERENCES tblRating,
    OrderStatusID INT NOT NULL REFERENCES tblOrderStatus,
    ReviewDescription VARCHAR(100),
    ReviewDate DATE NOT NULL
)

--tblRating
CREATE TABLE tblRating(
    RatingID INT IDENTITY(1, 1) PRIMARY KEY,
    OverallRating NUMERIC NOT NULL,
    RatingName VARCHAR(20) NOT NULL
)

--tblIncident
CREATE TABLE tblIncident(
    IncidentID INT IDENTITY(1, 1) PRIMARY KEY,
    IncidentTypeID INT NOT NULL REFERENCES tblIncidentType,
    IncidentName VARCHAR(30) NOT NULL,
    LocationID INT NOT NULL REFERENCES tblLocation,
    StartDate DATE NOT NULL,
    EndDate DATE
)

CREATE TABLE tblIncidentType(
    IncidentTypeID INT IDENTITY(1, 1) PRIMARY KEY,
    IncidentTypeName VARCHAR(30) NOT NULL
)

--tblLocation
CREATE TABLE tblLocation(
    LocationID INT IDENTITY(1, 1) PRIMARY KEY,
    LocationName VARCHAR(30) NOT NULL
)

--tblIncidentHistory
CREATE TABLE tblIncidentHistory(
    IncidentHistoryID INT IDENTITY(1, 1) PRIMARY KEY,
    OrderStatusID INT NOT NULL REFERENCES tblOrderStatus,
    IncidentID INT NOT NULL REFERENCES tblIncident,
    IncidentHistoryDescription VARCHAR(100) NOT NULL
)

--tblEmployeeSalary
CREATE TABLE tblEmployeeSalary(
    EmployeeSalaryID INT IDENTITY(1, 1) PRIMARY KEY,
    EmployeeID INT NOT NULL REFERENCES tblEmployee,
    EmployeeSalary DECIMAL(10, 2) NOT NULL,
    EmployeeSalaryBeginDate DATE NOT NULL,
    EmployeeSalaryEndDate DATE
)

--tblEmployee
CREATE TABLE tblEmployee(
    EmployeeID INT IDENTITY(1, 1) PRIMARY KEY,
    EmployeeFname VARCHAR(30) NOT NULL,
    EmployeeLname VARCHAR(30),
    GenderID INT NOT NULL REFERENCES tblGender,
    EmployeeStartDate DATE NOT NULL,
    EmployeeEndDate DATE,
    EmployeeBirth DATE NOT NULL,
    EmployeeAddress VARCHAR(100) NOT NULL,
    EmployeeCity VARCHAR(20) NOT NULL,
    EmployeeState VARCHAR(20) NOT NULL,
    EmployeeZipcode VALUE (12) NOT NULL,
    EmployeeEmail VARCHAR(50) NOT NULL,
    EmployeePhone VARCHAR(10) NOT NULL
)

--tblEmployeeDepartment
CREATE TABLE tblEmployeeDepartment(
    EmployeeDepartmentID INT IDENTITY(1, 1) PRIMARY KEY,
    EmployeeID INT NOT NULL REFERENCES tblEmployee,
    DepartmentID INT NOT NULL REFERENCES tblDepartment,
    PositionID INT NOT NULL REFERENCES tblPosition,
    EmployeeDepartmentStartDate DATE NOT NULL,
    EmployeeDepartmentEndDate DATE
)

--tblDepartment
CREATE TABLE tblDepartment(
    DepartmentID INT IDENTITY(1, 1) PRIMARY KEY,
    DepartmentName VARCHAR(30) NOT NULL
)

--tblPosition
CREATE TABLE tblPosition(
    PositionID INT IDENTITY(1, 1) PRIMARY KEY,
    PositionName VARCHAR(30) NOT NULL
)

--tblProduct
CREATE TABLE tblProduct(
    ProductID INT IDENTITY(1, 1) PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    BrandID INT NOT NULL REFERENCES tblBrand,
    ProductTypeID INT NOT NULL REFERENCES tblProductType
)

--tblProductPrice
CREATE TABLE tblProductPrice(
    ProductPriceID INT IDENTITY(1, 1) PRIMARY KEY,
    ProductID INT NOT NULL REFERENCES tblProduct,
    ProductPrice DECIMAL(10, 2) NOT NULL,
    ProductPriceBeginDate DATE NOT NULL,
    ProductPriceEndDate DATE
)

--tblProductType
CREATE TABLE tblProductType(
    ProductTypeID INT IDENTITY(1, 1) PRIMARY KEY,
    ProductTypeName VARCHAR(50) NOT NULL,
    ProductTypeDescription VARCHAR(100) NOT NULL
)

--tblBrand
CREATE TABLE tblBrand(
    BrandID INT IDENTITY(1, 1) PRIMARY KEY,
    BrandName VARCHAR(30) NOT NULL,
    CompanyID INT NOT NULL REFERENCES tblCompany
)

--tblCompany
CREATE TABLE tblCompany(
    CompanyID INT IDENTITY(1, 1) PRIMARY KEY,
    CompanyName VARCHAR(100) NOT NULL
)

--tblStoreProduct
CREATE TABLE tblStoreProduct(
    StoreProductID INT IDENTITY(1, 1) PRIMARY KEY,
    ProductID INT NOT NULL REFERENCES tblProduct,
    StoreID INT NOT NULL REFERENCES tblStore,
    StoreProductQuantity INT NOT NULL
)

--tblStore
CREATE TABLE tblStore(
    StoreID INT IDENTITY(1, 1) PRIMARY KEY,
    StoreName VARCHAR(30) NOT NULL,
    StoreAddress VARCHAR(100) NOT NULL,
    StoreCity VARCHAR(20) NOT NULL,
    StoreState VARCHAR(20) NOT NULL,
    StoreZipcode INT NOT NULL,
    StoreSize INT NOT NULL --in square feet
)

--tblProductSupply
CREATE TABLE tblProductSupply(
    ProductSupplyID INT IDENTITY(1, 1) PRIMARY KEY,
    SupplierID INT NOT NULL REFERENCES tblSupplier,
    ProductID INT NOT NULL REFERENCES tblProduct,
    ProductSupplyQuantity INT NOT NULL
)

--tblSupplier
CREATE TABLE tblSupplier(
    SupplierID INT IDENTITY(1, 1) PRIMARY KEY,
    SupplierName VARCHAR(50) NOT NULL,
    SupplierAddress VARCHAR(100) NOT NULL,
    SupplierState VARCHAR(20) NOT NULL,
    SupplierCity VARCHAR(20) NOT NULL,
    SupplierZipcode VARCHAR(12) NOT NULL,
    SupplierPhone VARCHAR(10) NOT NULL
)
-- End of create tables code
--
--

-- Code for stored procedure
--
--

-- Insert new brand
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

-- Insert new customer
CREATE PROCEDURE uspInsertCustomer
@Fname VARCHAR(30),
@Lname VARCHAR(30),
@Gender VARCHAR(20),
@BOD DATE,
@Address VARCHAR(100),
@City VARCHAR(20),
@State VARCHAR(20),
@Zipcode INT,
@Email VARCHAR(50),
@Phone VARCHAR(20)
AS
    DECLARE @GID INT
    SET @GID = (SELECT GenderID FROM tblGender WHERE GenderName = @Gender)
    BEGIN TRAN insertCustomer
        INSERT INTO tblCustomer(CustomerFname, CustomerLname, GenderID, CustomerBirth, CustomerAddress, CustomerCity, CustomerState, CustomerZipcode, CustomerEmail, CustomerPhone)
        VALUES (@Fname, @Lname, @GID, @BOD, @Address, @City, @State, @Zipcode, @Email, @Phone)
    COMMIT TRAN insertCustomer
GO

-- Insert new employee
CREATE PROCEDURE uspInsertEmployee
@Fname VARCHAR(30),
@Lname VARCHAR(30),
@Gender VARCHAR(20),
@StartDate DATE,
@EndDate DATE,
@BOD DATE,
@Address VARCHAR(100),
@City VARCHAR(20),
@State VARCHAR(20),
@Zipcode VARCHAR(12),
@Email VARCHAR(50),
@Phone VARCHAR(10)
AS
    DECLARE @GID INT
    SET @GID = (SELECT GenderID FROM tblGender WHERE GenderName = @Gender)
    BEGIN TRAN insertEmployee
        INSERT INTO tblEmployee(EmployeeFname, EmployeeLname, GenderID, EmployeeStartDate, EmployeeEndDate, EmployeeBirth, EmployeeAddress, EmployeeCity, EmployeeState, EmployeeZipcode, EmployeeEmail, EmployeePhone)
        VALUES (@Fname, @Lname, @GID, @StartDate, @EndDate, @BOD, @Address, @City, @State, @Zipcode, @Email, @Phone)
    COMMIT TRAN insertEmployee
GO

-- Insert new employee salary
CREATE PROCEDURE uspInsertEmployeeSalary
@Fname VARCHAR(30),
@Lname VARCHAR(30),
@BOD DATE,
@Salary DECIMAL(10, 2),
@Bdate DATE,
@Edate DATE
AS
    DECLARE @EID INT
    SET @EID = (SELECT EmployeeID
                FROM tblEmployee
                WHERE EmployeeFname = @Fname AND
                      EmployeeLname = @Lname AND
                      EmployeeBirth = @BOD)
    BEGIN TRAN insertEmployeeSalary
        INSERT INTO tblEmployeeSalary(EmployeeID, EmployeeSalary, EmployeeSalaryBeginDate, EmployeeSalaryEndDate)
        VALUES (@EID, @Salary, @Bdate, @Edate)
    COMMIT TRAN insertEmployeeSalary
GO

-- Insert new incident
CREATE PROCEDURE uspInsertIncident
@Type VARCHAR(30),
@Incident VARCHAR(30),
@Location VARCHAR(30),
@SDate DATE,
@EDate DATE
AS
    DECLARE @ITID INT, @LID INT
    SET @ITID = (SELECT IncidentTypeID FROM tblIncidentType WHERE IncidentTypeName = @Type)
    SET @LID = (SELECT LocationID FROM tblLocation WHERE LocationName = @Location)
    BEGIN TRAN insertIncident
        INSERT INTO tblIncident(IncidentTypeID, IncidentName, LocationID, StartDate, EndDate)
        VALUES (@ITID, @Incident, @LID, @SDate, @EDate)
    COMMIT TRAN insertIncident
GO

-- Insert new order status
CREATE PROCEDURE uspInsertOrderStatus
@Fname VARCHAR(30),
@Lname VARCHAR(30),
@BOD DATE,
@OrderDate DATE,
@Status VARCHAR(20),
@Bdate DATE,
@Edate DATE
AS
    DECLARE @OID INT, @SID INT
    SET @OID = (SELECT O.OrderID
                FROM tblCustomer AS C
                JOIN tblOrder AS O ON C.CustomerID = O.CustomerID
                WHERE C.CustomerFname = @Fname AND
                      C.CustomerLname = @Lname AND
                      C.CustomerBirth = @BOD AND
                      O.OrderDate = @OrderDate)
    SET @SID = (SELECT StatusID FROM tblStatus WHERE StatusName = @Status)
    BEGIN TRAN insertOrderStatus
        INSERT INTO tblOrderStatus(OrderID, StatusID, BeginDate, EndDate)
        VALUES (@OID, @SID, @Bdate, @Edate)
    COMMIT TRAN insertOrderStatus
GO

-- Insert new product
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

-- Insert new product price
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

-- Insert new review
CREATE PROCEDURE uspInsertReview
@Rating NUMERIC(18),
@Fname VARCHAR(30),
@Lname VARCHAR(30),
@BOD DATE,
@OrderDate DATE,
@Status VARCHAR(20),
@Description VARCHAR(100),
@Date DATE
AS
    DECLARE @RID INT, @OSID INT
    SET @RID = (SELECT RatingID FROM tblRating WHERE OverallRating = @Rating)
    SET @OSID = (SELECT OS.OrderStatusID
                FROM tblCustomer AS C
                JOIN tblOrder AS O ON C.CustomerID = O.CustomerID
                JOIN tblOrderStatus AS OS ON O.OrderID = OS.OrderID
                JOIN tblStatus AS S ON OS.StatusID = S.StatusID
                WHERE C.CustomerFname = @Fname AND
                      C.CustomerLname = @Lname AND
                      C.CustomerBirth = @BOD AND
                      O.OrderDate = @OrderDate AND
                      S.StatusName = @Status)
    BEGIN TRAN insertReview
        INSERT INTO tblReview(RatingID, OrderStatusID, ReviewDescription, ReviewDate)
        VALUES (@RID, @OSID, @Description, @Date)
    COMMIT TRAN insertReview
GO

-- End of stored procedure code
--
--

-- Matthew Putra code
--
--

-- Business Rules 1
-- Definition : no customer under the age of 21 can purchase any tobacco products.
CREATE FUNCTION fn_tobaccolaw()
RETURNS INT
AS
    BEGIN
        DECLARE @RET INT = 0
            IF EXISTS (SELECT *
                        FROM tblCUSTOMER C
                        JOIN tblORDER O ON C.CUSTOMERID = O.CUSTOMERID
                        JOIN tblORDERPRODUCT OP ON O.ORDERID = OP.ORDERID
                        JOIN tblPRODUCT P ON OP.PRODUCTID = P.PRODUCTID
                        JOIN tblProductType PT ON P.ProductTypeID = PT.ProductTypeID
                            WHERE C.CustomerBirth > DATEADD(year, -21, getdate()) AND
                                  PT.ProductTypeName = 'tobacco')
            SET @RET = 1
        RETURN @RET
    END
GO
ALTER TABLE tblORDERPRODUCT WITH NOCHECK
ADD CONSTRAINT ck_tobaccolaw
CHECK (dbo.fn_tobaccolaw() = 0)

-- Try to insert this to test
INSERT INTO tblOrderProduct(ProductID, OrderID, Quantity)
VALUES (210, 8, 10)

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

-- Test code
INSERT INTO tblStoreProduct(ProductID, StoreID, StoreProductQuantity)
VALUES (210, 12, 501)

-- Complex Query 1
-- Customer who are in the age range of 40-50 who ordered product type of 'pharmacy' group by the gender in Costco Washington where
-- the order status has not been completed
SELECT G.GenderName, COUNT(OS.OrderStatusID) AS totalOrder
FROM tblCustomer AS C
JOIN tblGender AS G ON C.GenderID = G.GenderID
JOIN tblOrder AS O ON C.CustomerID = O.CustomerID
JOIN tblOrderStatus AS OS ON O.OrderID = OS.OrderID
JOIN tblStatus AS ST ON OS.StatusID = ST.StatusID
JOIN tblOrderProduct AS OP ON O.OrderID = OP.OrderID
JOIN tblProduct AS P ON OP.ProductID = P.ProductID
JOIN tblProductType AS PT ON P.ProductTypeID = PT.ProductTypeID
JOIN tblStoreProduct AS SP ON P.ProductID = SP.ProductID
JOIN tblStore AS S ON SP.StoreID = S.StoreID
WHERE  CustomerBirth BETWEEN DATEADD(year, -50, GETDATE()) AND DATEADD(year, -40, GETDATE()) AND
      PT.ProductTypeName = 'pharmacy' AND
      S.StoreName = 'Costco' AND
      S.StoreState = 'Washington WA' AND
      ST.StatusName <> 'complete'
GROUP BY G.GenderID, G.GenderName
ORDER BY COUNT(OS.OrderStatusID);

-- Complex Query 2
-- Customer who spends more or equal to 6000 in Costco Washington in a single month
SELECT C.CustomerFname, C.CustomerLname, MONTH(O.OrderDate) AS month, SUM(OrderPrice) AS totalSpending
FROM tblCustomer AS C
JOIN tblOrder AS O ON C.CustomerID = O.CustomerID
JOIN tblOrderProduct AS OP ON O.OrderID = OP.OrderID
JOIN tblProduct AS P ON OP.ProductID = P.ProductID
JOIN tblStoreProduct AS SP ON P.ProductID = SP.ProductID
JOIN tblStore AS S ON SP.StoreID = S.StoreID
WHERE S.StoreName = 'Costco' AND
      S.StoreState = 'Washington WA'
GROUP BY C.CustomerID, C.CustomerFname, C.CustomerLname, MONTH(O.OrderDate)
HAVING SUM(O.OrderPrice) >= 6000;

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

-- Compute Column 2
-- Give the product that each supplier supplies the most
CREATE FUNCTION fn_GetMostProductSupplied(@SupplierID INT)
RETURNS VARCHAR(100)
AS
    BEGIN
        DECLARE @Quantity INT, @Product VARCHAR(100), @Ret VARCHAR(100)
            SET @Quantity = (SELECT MAX(PS.ProductSupplyQuantity)
                                FROM tblProductSupply AS PS
                                WHERE PS.SupplierID = @SupplierID)
            SET @Product = (SELECT TOP 1 P.ProductName
                            FROM tblProductSupply AS PS
                            JOIN tblProduct AS P ON PS.ProductID = P.ProductID
                            WHERE PS.SupplierID = @SupplierID AND
                                  PS.ProductSupplyQuantity = @Quantity)
            SET @Ret = CONCAT(@Product, '-', @Quantity)
        RETURN @Ret
    END
GO
ALTER TABLE dbo.tblSupplier
ADD highestQuantityProduct AS (dbo.fn_GetMostProductSupplied(SupplierID));

-- Stored Procedure 1
-- Insert into tblStoreProduct
CREATE PROCEDURE uspInsertStoreProduct
@ProductName VARCHAR(100),
@Brand VARCHAR(30),
@StoreName VARCHAR(30),
@StoreAddress VARCHAR(100),
@Quantity INT
AS
    DECLARE @PID INT, @SID INT
        SET @PID = (SELECT P.ProductID
                    FROM tblProduct AS P
                    JOIN tblBrand AS B ON P.BrandID = B.BrandID
                    WHERE B.BrandName = @Brand AND
                          P.ProductName = @ProductName)
        SET @SID = (SELECT S.StoreID
                    FROM tblStore AS S
                    WHERE S.StoreName = @StoreName AND
                          S.StoreAddress = @StoreAddress)
    BEGIN TRAN newStoreProduct
        INSERT INTO tblStoreProduct(ProductID, StoreID, StoreProductQuantity)
        VALUES (@PID, @SID, @Quantity)
    COMMIT TRAN newStoreProduct
GO

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

-- End of Matthew Putra code
--
--

-- Jessie Yang code
--
--

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

ALTER TABLE tblOrderProduct WITH NOCHECK
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

ALTER TABLE tblDepartment
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
   the sum of product supply quantity is over 1,000. */

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
		  HAVING SUM(PS.ProductSupplyQuantity) > 1000) sub ON sub.BrandID = B.BrandID
where C.CompanyName = 'Coca Cola'
AND S.StoreState LIKE '%California%'
GROUP BY B.BrandID, B.BrandName, TotalQuantity
ORDER BY TotalProducts DESC

-- End of Jessie Yang code
--
--

-- Yiu Chung Cheung code
--
--

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

-- End of Yiu Chung Cheung code
--
--

