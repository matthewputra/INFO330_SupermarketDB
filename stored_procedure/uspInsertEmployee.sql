USE INFO330_PROJ_A13
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
