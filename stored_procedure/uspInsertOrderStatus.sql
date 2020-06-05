USE INFO330_PROJ_A13
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

