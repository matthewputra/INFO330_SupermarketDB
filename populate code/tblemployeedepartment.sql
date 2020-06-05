USE INFO330_PROJ_A13
-- POPULATE
EXECUTE dbo.usp_INSERT_EMPLOYEE_DEPARTMENT
'Hillier',
    'MacCaull',
    'gender neutral',
    '1984-01-23',
    'Human Resources',
    'President',
    '12/15/2000',
    '2/1/2020'
EXEC uspInsertEmployeeDept'Hillier', 'MacCaull', '1984-01-23', 'Human Resources', 'President', '12/15/2000', '2/1/2020'
insert into tblemployeedepartment (EmployeeID, DepartmentID, PositionID, EmployeeDepartmentStartDate, EmployeeDepartmentEndDate) values (1, 3.09, 6, '12/15/2000', '2/1/2020');
insert into tblemployeedepartment (EmployeeID, DepartmentID, PositionID, EmployeeDepartmentStartDate, EmployeeDepartmentEndDate) values (2, 6.73, 3, '7/18/2000', '4/25/2020');
insert into tblemployeedepartment (EmployeeID, DepartmentID, PositionID, EmployeeDepartmentStartDate, EmployeeDepartmentEndDate) values (3, 6.26, 6, '5/30/2001', '4/8/2020');
insert into tblemployeedepartment (EmployeeID, DepartmentID, PositionID, EmployeeDepartmentStartDate, EmployeeDepartmentEndDate) values (4, 3.72, 3, '6/14/2000', '2/18/2020');
insert into tblemployeedepartment (EmployeeID, DepartmentID, PositionID, EmployeeDepartmentStartDate, EmployeeDepartmentEndDate) values (5, 1.32, 6, '6/21/2000', '7/21/2019');