use TeekayTraining;

create table Employees(
EmployeeID int identity (1,1),
FirstName char(50) NOT NULL,
LastName char(50)NOT NULL,
Sex char(1)NOT NULL,
age int DEFAULT 18,
DepartmentID int,
SalaryID int,
constraint Pk_EmployeeID primary key (EmployeeID)
);

create table Emp_Salary(
SalaryID int identity (1000,1),
Salary int Default 0,
constraint Pk_SalaryID primary key (SalaryID)
);

create table Department(
DepartmentID int identity (100,1),
Department varchar(100) Default 'Trainee',
constraint Pk_DepartmentID primary key (DepartmentID)
);
--------------------------------------------------------------

select * from Employee;
Select * From Department;
Select * From Emp_Salary;
Select * From Employees;

-----------------------------------------------------------------
INSERT INTO Emp_Salary (Salary)
SELECT DISTINCT Salary
FROM Employee;

Select * From Emp_Salary;

INSERT INTO Department (Department)
SELECT DISTINCT Designations
FROM Employee;

Select * From Department;

INSERT INTO Employees (FirstName,LastName,Sex,age)
SELECT FirstName,LastName ,Sex,age
FROM Employee;

Select * From Employees;
---------------------------------------------------------------------

UPDATE Employees SET DepartmentID=102,SalaryID=1000 
WHERE EmployeeID=1 ;

UPDATE Employees SET DepartmentID=103,SalaryID=1005 
WHERE EmployeeID=2 ;
UPDATE Employees SET DepartmentID=103,SalaryID=1005 
WHERE EmployeeID=3 ;
UPDATE Employees SET DepartmentID=101,SalaryID=1002
WHERE EmployeeID=4 ;
UPDATE Employees SET DepartmentID=104,SalaryID=1001 
WHERE EmployeeID=5 ;
UPDATE Employees SET DepartmentID=100,SalaryID=1004 
WHERE EmployeeID=6 ;
UPDATE Employees SET DepartmentID=105,SalaryID=1003 
WHERE EmployeeID=7 ;

------------------------------------------------------------------------
