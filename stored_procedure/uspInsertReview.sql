USE INFO330_PROJ_A13
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
