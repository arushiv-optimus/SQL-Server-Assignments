use TeekayTraining;

create table Customers(
CustomerId int identity(1000,1),
CustomerName varchar(225),
ContactNumber varchar(50),
CustomerAddress varchar(225),
City varchar(50) ,
Country varchar(50),
Constraint Pk_CustId primary key (CustomerId)
)

create table Orders(
OrderID int identity(500,1),
CustomerID int,
EmployeeId int,
OrderDate Date,
ShipperID int ,
Country int,
Constraint Pk_OrderID primary key (OrderID)
)

create table Suppliers(
SupplierID int identity(300,1),
SupplierName varchar(225),
ContactName varchar(50),
SupplierAddress varchar(225),
City varchar(50) ,
Country varchar(50),
Constraint Pk_SupplierID primary key (SupplierID)
)

create table Products(
ProductID int identity(200,1),
ProductName varchar(225),
UnitPrice decimal,
UnitsInStock int,
UnitsOnOrder int ,
Constraint Pk_ProductID primary key (ProductID)
)

CREATE TABLE Persons (
    PersonID int identity(1,1),
    LastName varchar(255),
    FirstName varchar(255),
    PersonAddress varchar(255),
    City varchar(255) 
);

---------------------------------------------------------------
Alter table Persons
ADD Constraint Pk_PersonID primary key (PersonID)

Alter table Persons
ADD CONSTRAINT UC_Person UNIQUE (PersonID,LastName);

Alter table Orders
ADD PersonID int;

Alter table Persons
ADD Age int;

ALTER TABLE Orders
ADD CONSTRAINT FK_PersonOrder
FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);

ALTER TABLE Persons
ADD CHECK (Age>=18);

CREATE INDEX idx_lastname
ON Persons (LastName);

----------------------------------------------------------------
use [TeekayTraining]
GO
Create Procedure CreateSuppliers
 @supplierName as varchar(225),
 @contactNumber as varchar(100),
 @address as varchar(225),
 @city as varchar(100),
 @country as varchar(100)
 AS 
 Begin
 Insert into Suppliers(SupplierName,ContactName,SupplierAddress,City,Country)
 Values (@supplierName, @contactNumber, @address,@city,@country);
 End
 
 Go
 create procedure CreateCustomers
 @custName as varchar(225),
 @contactNumber as varchar(100),
 @address as varchar(225),
 @city as varchar(100),
 @country as varchar(100)
 AS 
 Begin
 Insert into Customers (CustomerName,ContactNumber,CustomerAddress,City,Country)
 Values (@custName, @contactNumber, @address,@city,@country);
 End 

 Go
 Create procedure CreatePersons
 @lastName as varchar(225),
 @firstName as varchar(225),
 @address as varchar(225),
 @city as varchar(225)
 AS 
 Begin
 Insert into Persons (LastName,FirstName,PersonAddress,City)
 Values (@lastName, @firstName, @address,@city);
 End 


  Go
 Create procedure CreateProducts
 @productName as varchar(225),
 @unitPrice decimal,
 @unitsInStock int,
 @unitsOnOrder int
 AS 
 Begin
 Insert into Products (ProductName,UnitPrice,UnitsInStock,UnitsOnOrder)
 Values (@productName, @unitPrice, @unitsInStock,@unitsOnOrder);
 End 

 
  Go
 Create procedure CreateOrders
 @customerID int,
 @employeeId int,
 @orderDate date,
 @shipperID int
 AS 
 Begin
 Insert into Orders (CustomerID,EmployeeId,OrderDate,ShipperID)
 Values (@customerID, @employeeId, @orderDate,@shipperID);
 End 

 ---------------------------------------------------------------------------
 EXEC CreateSuppliers 
 @supplierName = 'New Orleans',
 @contactNumber ='8865472329',
 @address ='P.O. Box 78934',
 @city ='New Orleans',
 @country ='USA';

 Select * from Suppliers;


 EXEC CreateCustomers
 @custName ='Grandma Kelly',
 @contactNumber ='9865472325',
 @address ='707 Oxford Rd.',
 @city ='Ann Arbor',
 @country ='Mexico';

 Select * from Customers;

 EXEC CreatePersons
 @lastName ='Pettersen',
 @firstName ='Kari',
 @address ='Storgt 20',
 @city ='Stavanger';

 Select * from Persons;

 EXEC CreateProducts
 @productName ='Gorgonzola',
 @unitPrice = 15.67,
 @unitsInStock =9,
 @unitsOnOrder =20;

 Select * from Products;

 EXEC CreateOrders
 @customerID =,
 @employeeId =,
 @orderDate =,
 @shipperID =;

 --------------------------------------------------------------------

Select ProductName, UnitPrice * (UnitsInStock + UnitsOnOrder)
From Products;

Select ProductName,UnitPrice *(UnitsInStock + COALESCE(UnitsOnOrder,0))
From Products;

Select ProductName,UnitPrice *(UnitsInStock + ISNULL(UnitsOnOrder,0))
From Products;

-------------------------------------------------------------------------

Select 9.5 AS Original, 
	CAST(9.5 AS int) AS int, 
	CAST(9.5 AS decimal(6,4)) AS decimal;

Select 9.5 AS Original, 
	CONVERT(int, 9.5) AS int, 
    CONVERT(decimal(6,2), 9.5) AS decimal;

--------------------------------------------------------------------------

SELECT SalaryID,Salary ,RANK() 
OVER (PARTITION BY SalaryID ORDER BY Salary) AS Rank 
FROM Emp_Salary ORDER BY SalaryID; 


SELECT SalaryID,Salary ,RANK() 
OVER (ORDER BY Salary) AS Rank 
FROM Emp_Salary ORDER BY SalaryID; 

-----------------------------------------------------------------------------
