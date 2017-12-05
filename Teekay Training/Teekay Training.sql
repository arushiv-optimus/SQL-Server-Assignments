-- SQL Create DB

Create Database TeekayTraining;

use TeekayTraining;

---------------------------------------------
--SQL Create Table

Create Table Employee(
EmployeeId int identity (100,1),
FirstName char(50) NOT NULL,
LastName char(50)NOT NULL,
Sex char(1)NOT NULL,
Designations varchar(50) DEFAULT 'Trainee',
Salary int,
age int DEFAULT 18,
ActiveStatus  BIT  DEFAULT 0,
constraint Pk_EmpId primary key (EmployeeId)
);

drop table Employee
------------------------------------------------------------------------------------
--SQL Insert 

--without default values
Insert into Employee (FirstName,LastName,Sex,Designations,Salary,age,ActiveStatus)
Values('Arushi','Vishwakarma','F','Intern',20000,25,1);

--with default values
Insert into Employee (FirstName,LastName,Sex,Salary)
Values('Parinita','Gupta','F',40000);

Insert into Employee (FirstName,LastName,Sex,Designations,Salary,age,ActiveStatus)
Values('Akash','Kumar','M','Manager',50000,40,1);
Insert into Employee (FirstName,LastName,Sex,Designations,Salary,age,ActiveStatus)
Values('Anil','Kumar','M','Manager',50000,30,1);
Insert into Employee (FirstName,LastName,Sex,Designations,Salary,age,ActiveStatus)
Values('Smriti','Singh','F','HR',35000,27,1);
Insert into Employee (FirstName,LastName,Sex,Designations,Salary,age,ActiveStatus)
Values('Swati','Agarwal','F','Tester',30000,30,1);
Insert into Employee (FirstName,LastName,Sex,Designations,Salary,age,ActiveStatus)
Values('Harsh','Sharma','M','Devloper',45000,45,1);
Insert into Employee (FirstName,LastName,Sex,Designations,Salary,age,ActiveStatus)
Values('Tushar','Singh','M','Trainee',15000,24,1);
Insert into Employee (FirstName,LastName,Sex,Designations,Salary,age,ActiveStatus)
Values('Arushi','Saxena','F','Devloper',25000,35,1);

--------------------------------------------------------------------------------------
--SQL Update

 Update Employee set Salary=1000 Where EmployeeId=100;

 Update Employee set Designations='Trainee' Where EmployeeId=110;

--------------------------------------------------------------------------------------
--SQL Select

Select * From Employee;

Select FirstName,LastName,Designations From Employee;

---------------------------------------------------------------------------------------
--SQL Distinct

Select Distinct FirstName From Employee;

Select Distinct Designations From Employee;

---------------------------------------------------------------------------------------
--SQL Where

Select * From Employee where Salary < 20000;

---------------------------------------------------------------------------------------
--SQL And & Or

Select * From Employee where Salary >= 50000 And Age <35;

---------------------------------------------------------------------------------------
--SQL Order By

Select * From Employee Order By EmployeeId;

Select FirstName,LastName,Salary From Employee Order By Salary;

Select FirstName,LastName,Salary From Employee Order By Salary Desc;

---------------------------------------------------------------------------------------
--SQL Delete

Delete From Employee Where ActiveStatus=1 And Designations='Trainee';
---------------------------------------------------------------------------------------
--SQL top

SELECT TOP 3 Salary FROM Employee;

SELECT Distinct TOP 3 Salary FROM Employee Order By Salary Desc;
---------------------------------------------------------------------------------------
--SQL Like

SELECT Salary FROM Employee Where FirstName LIKE 'Akash';

SELECT * FROM Employee Where FirstName LIKE 'A___h%';

---------------------------------------------------------------------------------------
--SQL Wildcards

SELECT MAX(Salary) AS Largest_Salary FROM Employee;

SELECT MAX(Salary) AS Second_Largest_Salary FROM Employee
WHERE Salary < (SELECT MAX(Salary) FROM Employee);


---------------------------------------------------------------------------------------
--SQL In

SELECT FirstName,LastName,Salary
FROM Employee
WHERE Salary IN (20000,40000);

---------------------------------------------------------------------------------------
--SQL Between

SELECT FirstName,LastName,Salary
FROM Employee
WHERE Salary Between 20000 AND 40000;
