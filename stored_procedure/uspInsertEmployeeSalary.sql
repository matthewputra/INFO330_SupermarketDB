USE INFO330_PROJ_A13
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