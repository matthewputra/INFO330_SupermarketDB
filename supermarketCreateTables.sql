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
    CustoemrPhone INT
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
    EmployeeZipcode INT NOT NULL,
    EmployeeEmail VARCHAR(50) NOT NULL,
    EmployeePhone INT NOT NULL
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