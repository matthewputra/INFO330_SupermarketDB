-- Populate tblDepartment
BEGIN TRAN populateDepartment
    INSERT INTO tblDepartment (DepartmentName) VALUES ('Sales');
    INSERT INTO tblDepartment (DepartmentName) VALUES ('Accounting');
    INSERT INTO tblDepartment (DepartmentName) VALUES ('Human Resources');
    INSERT INTO tblDepartment (DepartmentName) VALUES ('Business Development');
    INSERT INTO tblDepartment (DepartmentName) VALUES ('Human Resources');
    INSERT INTO tblDepartment (DepartmentName) VALUES ('Accounting');
    INSERT INTO tblDepartment (DepartmentName) VALUES ('Marketing');
COMMIT TRAN populateDepartment