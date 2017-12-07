
-- Declare the cursor.  
DECLARE emp_cursor CURSOR  
    FOR SELECT * FROM Employees

-- Open cursor.  	  
OPEN emp_cursor  

--Fetch the row immediately next to the current row in the cursor. 
FETCH NEXT FROM emp_cursor;

-- Update employee table .  
UPDATE Employees
SET age = 21 
WHERE CURRENT OF emp_cursor;


-- Close cursor.  
CLOSE emp_cursor; 

-- Remove cursor.  
DEALLOCATE emp_cursor;  

 --------------------------------

-- Declare the cursor with Scroll for Forward and backword move .  
GO  
DECLARE Employees_cursor SCROLL CURSOR FOR  
SELECT  FirstName ,LastName FROM Employee  
ORDER BY LastName, FirstName;  

-- Open cursor. 
OPEN Employees_cursor;  

-- Fetch the last row in the cursor.  
FETCH LAST FROM Employees_cursor;  

-- Fetch the row immediately prior to the current row in the cursor.  
FETCH PRIOR FROM Employees_cursor;  

-- Fetch the second row in the cursor.  
FETCH ABSOLUTE 2 FROM Employees_cursor;  

-- Fetch the row that is three rows after the current row.  
FETCH RELATIVE 3 FROM Employees_cursor;  

-- Fetch the row that is two rows prior to the current row.  
FETCH RELATIVE -2 FROM Employees_cursor;  

-- Close cursor.  
CLOSE Employees_cursor;  

-- Remove cursor.  
DEALLOCATE Employees_cursor;  

--------------------------------------------------------------------
--Trigger

SELECT * FROM Employees;
UPDATE Employees SET age=100 WHERE EmployeeID=1;


GO
CREATE TRIGGER emp_trigger
ON Employees
AFTER INSERT, UPDATE  
AS BEGIN
   UPDATE Employees
   SET age = 999
   FROM INSERTED i
   WHERE i.EmployeeID = Employees.EmployeeID 
END 
	
------------------------
GO
CREATE TRIGGER reminder1  
ON Employees  
AFTER INSERT,UPDATE, DELETE   
AS  
RAISERROR ('New Employee Is Added', 16, 10); 
GO  

SELECT * FROM Employees;
UPDATE Employees SET age=100 WHERE EmployeeID=1;
----------------------

GO
CREATE TRIGGER Customers_trigger  
ON Employees
AFTER INSERT, UPDATE, DELETE   
AS  
	EXEC CreateCustomers
	 @custName ='Grandma Kelly',
	 @contactNumber ='9865472325',
	 @address ='707 Oxford Rd.',
	 @city ='Ann Arbor',
	 @country ='Mexico';
GO  

UPDATE Employees SET age=100 WHERE EmployeeID=1;
SELECT * FROM Customers;

------------------------------------

IF OBJECT_ID ('reminder1', 'TR') IS NOT NULL  
   DROP TRIGGER reminder1; 

-------------------------------------
GO
   Drop TRIGGER Customers_trigger ;

--------------------------------------------------------------------

-- Define the CTE expression name and column list.  
WITH Employee (EmployeeID, Salary)  
AS  
-- Define the CTE query.  
(  
  SELECT Salary, AVG(Salary)  
    FROM Emp_Salary  
    WHERE Salary IS NOT NULL  
    GROUP BY Salary    
)  
-- Define the outer query referencing the CTE name.  
SELECT AVG(Salary) AS "Average Salary Per Person"  
FROM Employee;  
GO   

------------------------------------------------------------
--CUBE essentially contains every possible rollup scenario for each node 
--whereas 
--ROLLUP will keep the hierarchy

--ROLLUP

SELECT EmployeeId, SUM(Salary) as 'Total Salary'
FROM Employee
GROUP BY EmployeeId WITH ROLLUP; 

SELECT EmployeeId, SUM(Salary) as 'Total Salary'
FROM Employee
GROUP BY ROLLUP(EmployeeId);

SELECT EmployeeId, FirstName, LastName, SUM(Salary) as 'Total Salary'
FROM Employee
GROUP BY ROLLUP(EmployeeId, FirstName, LastName);


--CUBE

SELECT EmployeeId, SUM(Salary) as 'Total Salary'
FROM Employee
GROUP BY EmployeeId WITH CUBE; 

SELECT EmployeeId, SUM(Salary) as 'Total Salary' 
FROM Employee
GROUP BY CUBE(EmployeeId);


SELECT EmployeeId, FirstName, LastName, SUM(Salary) as 'Total Salary' 
FROM Employee
GROUP BY CUBE(EmployeeId, FirstName, LastName);

------------------------------------------------------------
--EXCEPT returns distinct rows from the left input query that aren’t output by the right input query.
--INTERSECT returns distinct rows that are output by both the left and right input queries operator.

--EXCEPT

SELECT EmployeeId   
FROM Employee 
EXCEPT 
SELECT EmployeeID   
FROM Employees; 


--INTERSECT

SELECT EmployeeId   
FROM Employee 
INTERSECT  
SELECT EmployeeID   
FROM Employees; 

------------------------------------------------------------
-- Exception Handling

-- Verify that the stored procedure does not already exist.
IF OBJECT_ID('GetErrorInfo','P') IS NOT NULL
	DROP PROCEDURE GetErrorInfo;
GO
  
-- Create procedure to retrieve error information. 
CREATE PROCEDURE GetErrorInfo
AS
SELECT
	ERROR_NUMBER() AS ErrorNumber,
	ERROR_SEVERITY() AS ErrorSeverity,
	ERROR_STATE() AS ErrorState ,
	ERROR_PROCEDURE() AS ErrorProcedure,
	ERROR_LINE() AS ErrorLine,
	ERROR_MESSAGE() AS ErrorMessage;  
GO  
BEGIN TRY
	-- Generate divide-by-zero error.  
    SELECT 1/0; 
END TRY
BEGIN CATCH
    -- Execute error retrieval routine.  
    EXECUTE GetErrorInfo;  
END CATCH;

----------------------------------------------------------------
--Case

WITH Data (value) AS   
(   
SELECT 0   
UNION ALL   
SELECT 1   
)   
SELECT   
   CASE   
      WHEN MIN(value) <= 0 THEN 0   
      WHEN MAX(value) > 0 THEN 1   
   END   
FROM Data ;


--Case
GO  
SELECT   EmployeeId, Salary =  
      CASE Salary  
         WHEN 1000 THEN 0 
         WHEN 50000 THEN 1  
         ELSE Salary  
      END,  
   FirstName  
FROM Employee  
ORDER BY EmployeeId,Salary;  
GO

--------------------------------------------------------  

