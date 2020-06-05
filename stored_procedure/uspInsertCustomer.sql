USE INFO330_PROJ_A13
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


