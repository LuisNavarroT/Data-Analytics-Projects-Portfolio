--------SQL BASICS--------

------CREATE TABLES------
--Create Table EmployeeDemographics 
--(EmployeeID int, 
--FirstName varchar(50), 
--LastName varchar(50), 
--Age int, 
--Gender varchar(50)
--)

--Create Table EmployeeSalary 
--(EmployeeID int, 
--JobTitle varchar(50), 
--Salary int
--)

------FILL TABLES------
--Insert into EmployeeDemographics VALUES
--(1001, 'Jim', 'Halpert', 30, 'Male'),
--(1002, 'Pam', 'Beasley', 30, 'Female'),
--(1003, 'Dwight', 'Schrute', 29, 'Male'),
--(1004, 'Angela', 'Martin', 31, 'Female'),
--(1005, 'Toby', 'Flenderson', 32, 'Male'),
--(1006, 'Michael', 'Scott', 35, 'Male'),
--(1007, 'Meredith', 'Palmer', 32, 'Female'),
--(1008, 'Stanley', 'Hudson', 38, 'Male'),
--(1009, 'Kevin', 'Malone', 31, 'Male')

--Insert Into EmployeeSalary VALUES
--(1001, 'Salesman', 45000),
--(1002, 'Receptionist', 36000),
--(1003, 'Salesman', 63000),
--(1004, 'Accountant', 47000),
--(1005, 'HR', 50000),
--(1006, 'Regional Manager', 65000),
--(1007, 'Supplier Relations', 41000),
--(1008, 'Salesman', 48000),
--(1009, 'Accountant', 42000)

------BASIC COMANDS------
--SELECT * FROM EmployeeDemographics
--SELECT Age FROM EmployeeDemographics
--SELECT TOP 5 * FROM EmployeeDemographics
--SELECT DISTINCT (Gender) FROM EmployeeDemographics
--SELECT COUNT(LastName) AS LastNameCount FROM EmployeeDemographics
--SELECT MAX(Salary) FROM EmployeeSalary
--SELECT AVG(Salary) FROM EmployeeSalary

--Select se puede usar especificando Data Base, Table, what 
--SELECT * FROM SQLEmployeeExample.dbo.EmployeeSalary

--SELECT * FROM EmployeeDemographics WHERE FirstName = 'Jim'
--SELECT * FROM EmployeeDemographics WHERE FirstName <> 'Jim'

--SELECT * FROM EmployeeDemographics WHERE Age > 30
--SELECT * FROM EmployeeDemographics WHERE Age >= 30

--SELECT * FROM EmployeeDemographics WHERE Age <= 32 AND Gender = 'Male'
--SELECT * FROM EmployeeDemographics WHERE Age <= 32 OR Gender = 'Male'

------USE OF %------
-- % significa cualquier cosa
--Starts with S
--SELECT * FROM EmployeeDemographics WHERE LastName LIKE 'S%'

--Has an S
--SELECT * FROM EmployeeDemographics WHERE LastName LIKE '%S%'

--Starts with S
--SELECT * FROM EmployeeDemographics WHERE LastName LIKE 'S%'

--Starts with S and has an o somewhere
--SELECT * FROM EmployeeDemographics WHERE LastName LIKE 'S%o%'

------NULL & IN------

--SELECT * FROM EmployeeDemographics WHERE FirstName is NOT NULL

--SELECT * FROM EmployeeDemographics WHERE FirstName IN ('Jim', 'Michael')

------GROUP BY & ORDER BY------

--SELECT Gender, COUNT (Gender) AS Amount FROM EmployeeDemographics GROUP BY Gender
--SELECT Gender, Age, COUNT (Gender) AS Amount FROM EmployeeDemographics GROUP BY Gender, Age
--SELECT Gender, COUNT (Gender) AS Amount FROM EmployeeDemographics WHERE Age > 31 GROUP BY Gender
--SELECT Gender, COUNT (Gender) AS Amount FROM EmployeeDemographics WHERE Age > 31 GROUP BY Gender ORDER BY Amount
--SELECT Gender, COUNT (Gender) AS Amount FROM EmployeeDemographics WHERE Age > 31 GROUP BY Gender ORDER BY Amount DESC
--SELECT Gender, COUNT (Gender) AS Amount FROM EmployeeDemographics WHERE Age > 31 GROUP BY Gender ORDER BY Gender
--SELECT Gender, COUNT (Gender) AS Amount FROM EmployeeDemographics WHERE Age > 31 GROUP BY Gender ORDER BY Gender DESC

--SELECT * FROM EmployeeDemographics ORDER BY Age
--SELECT * FROM EmployeeDemographics ORDER BY Age, Gender
--SELECT * FROM EmployeeDemographics ORDER BY Age, Gender DESC

--SELECT * FROM EmployeeDemographics ORDER BY 1,2,3,4,5
--SELECT * FROM EmployeeDemographics ORDER BY 4 DESC, 5 DESC

------SQL INTERMEDIATE--------

--Insert into EmployeeDemographics VALUES
--(1011, 'Ryan', 'Howard', 26, 'Male'),
--(NULL, 'Holly', 'Flax', NULL, NULL ),
--(1013, 'Darryl', 'Philbin', NULL, 'Male')

--INSERT into EmployeeSalary VALUES
--(1010, NULL, 47000),
--(NULL, 'Salesman', 43000)

--SELECT * FROM EmployeeDemographics
--SELECT * FROM EmployeeSalary

------INNER JOINS------

--ONLY WHAT IS IN BOTH--
--SELECT * FROM EmployeeDemographics JOIN EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--EVERITHING FROM BOTH--
--SELECT * FROM EmployeeDemographics FULL OUTER JOIN EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--LEFT TABLE AND OVERLAPING--
--SELECT * FROM EmployeeDemographics LEFT OUTER JOIN EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--RIGHT TABLE AND OVERLAPING--
--SELECT * FROM EmployeeDemographics RIGHT OUTER JOIN EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

--SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary FROM EmployeeDemographics JOIN EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--SELECT EmployeeSalary.EmployeeID, FirstName, LastName, JobTitle, Salary FROM EmployeeDemographics Right Outer JOIN EmployeeSalary ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


----IMAGINE YOU WANT THE WORKER WITH THE HIGHEST SALARY THAT IS NOT THE MANNAGER MICHAEL----
--SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, Salary 
--FROM EmployeeDemographics 
--JOIN EmployeeSalary -- or INNER JOIN --
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--WHERE FirstName <> 'Michael'
--ORDER BY Salary DESC

----IMAGINE YOU WANT THE AVERAGE SALARY FOR SALESMAN ONLY----
--SELECT Jobtitle, Salary
--FROM EmployeeDemographics 
--JOIN EmployeeSalary 
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--WHERE JobTitle = 'Salesman'

--SELECT Jobtitle, AVG(Salary) AS 'Average'
--FROM EmployeeDemographics 
--JOIN EmployeeSalary 
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--WHERE JobTitle = 'Salesman'
--GROUP BY JobTitle


----ADDING MORE DATA----
--Create Table WareHouseEmployeeDemographics 
--(EmployeeID int, 
--FirstName varchar(50), 
--LastName varchar(50), 
--Age int, 
--Gender varchar(50)
--)

--Insert into WareHouseEmployeeDemographics VALUES
--(1013, 'Darryl', 'Philbin', NULL, 'Male'),
--(1050, 'Roy', 'Anderson', 31, 'Male'),
--(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
--(1052, 'Val', 'Johnson', 31, 'Female')

------UNIONS------
--SELECT *
--FROM EmployeeDemographics
--FULL OUTER JOIN WareHouseEmployeeDemographics
--ON EmployeeDemographics.EmployeeID = WareHouseEmployeeDemographics.EmployeeID

--SELECT *
--FROM EmployeeDemographics
--UNION
--SELECT *
--FROM WareHouseEmployeeDemographics

--SELECT *
--FROM EmployeeDemographics
--UNION ALL
--SELECT *
--FROM WareHouseEmployeeDemographics

--SELECT EmployeeID, FirstName, Age
--FROM EmployeeDemographics
--UNION
--SELECT EmployeeID, JobTitle, Salary
--FROM EmployeeSalary
--ORDER BY EmployeeID

------CASE STATEMENTS------

--SELECT FirstName, LastName, Age,
--CASE
--	WHEN Age>30 THEN 'OLD'
--	WHEN Age BETWEEN 27 AND 30 THEN 'YOUNG'
--	ELSE 'BABY'
--END AS 'Adjetive'
--FROM EmployeeDemographics
--WHERE Age is NOT NULL
--ORDER BY Age

--SELECT FirstName, LastName, JobTitle, Salary,
--CASE	
--	WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
--	WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
--	WHEN JobTitle = 'HR' THEN Salary + (Salary * .0001)
--	ELSE Salary + (Salary * .03)
--END as SalaryAfterRaise
--FROM EmployeeDemographics
--JOIN EmployeeSalary
--ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

------HAVING CLAUSES------

--SELECT JobTitle, COUNT (JobTItle)
--FROM EmployeeDemographics
--JOIN EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--GROUP BY JobTitle
--HAVING COUNT (JobTitle) > 1

--SELECT JobTitle, AVG (Salary)
--FROM EmployeeDemographics
--JOIN EmployeeSalary
--	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
--GROUP BY JobTitle
--HAVING AVG (Salary) > 45000
--ORDER BY AVG (Salary)

------Edit and deleting tables------

--SELECT *
--FROM EmployeeDemographics

--UPDATE EmployeeDemographics
--SET EmployeeID = 1012
--WHERE FirstName = 'Holly' AND LastName = 'Flax'

--UPDATE EmployeeDemographics
--SET Age = 31, Gender = 'Female'
--WHERE FirstName = 'Holly' AND LastName = 'Flax'

--DELETE FROM EmployeeDemographics
--WHERE EmployeeID = 1005

--------Aliasing--------

--SELECT FirstName as Fname FROM EmployeeDemographics 
--or
--SELECT FirstName Finame FROM EmployeeDemographics

--This shows to columns combined--
--SELECT FirstName + ' ' + LastName as FullName FROM EmployeeDemographics

--This is to make the script shorter, we use alias insted of the name of the table--

--SELECT Demo.EmployeeID, Sal.Salary
--FROM EmployeeDemographics AS Demo
--JOIN EmployeeSalary AS Sal
--	ON Demo.EmployeeID = Sal.EmployeeID

--SELECT Demo.EmployeeID, Demo.FirstName, Demo.LastName, Sal.JobTitle, Ware.Age
--FROM EmployeeDemographics AS Demo
--LEFT JOIN EmployeeSalary AS Sal
--	ON Demo.EmployeeID = Sal.EmployeeID
--LEFT JOIN WareHouseEmployeeDemographics AS Ware
--	ON Demo.EmployeeID = Ware.EmployeeID

--------Partition by--------
--SELECT FirstName, LastName, Salary,
--COUNT (Gender) OVER (PARTITION BY Gender) AS TotalGender
--FROM EmployeeDemographics dem
--JOIN EmployeeSalary sal
--	ON dem.EmployeeID = sal.EmployeeID

---Is the same as the following two--- 

--SELECT FirstName, LastName, Salary, COUNT (Gender) 
--FROM EmployeeDemographics dem
--JOIN EmployeeSalary sal
--	ON dem.EmployeeID = sal.EmployeeID
--GROUP BY FirstName, LastName, Salary

--SELECT Gender, COUNT (Gender) TotalGender
--FROM EmployeeDemographics dem
--JOIN EmployeeSalary sal
--	ON dem.EmployeeID = sal.EmployeeID
--GROUP BY Gender 

--------CTEs similar to a temp table but it is not stores anywhere--------

--WITH CTE_Employee as
--(SELECT FirstName, LastName, Gender, Salary,
--COUNT(Gender) OVER (PARTITION by Gender) AS TotalGender,
--AVG (Salary) OVER (PARTITION by Gender) AS AvgSalary
--FROM EmployeeDemographics emp
--JOIN EmployeeSalary sal
--	ON emp.EmployeeID = sal.EmployeeID
--WHERE Salary > '45000'
--)

--SELECT * 
--FROM CTE_Employee

--SELECT FirstName, AvgSalary
--FROM CTE_Employee

--------Temp tables--------

--CREATE TABLE #temp_Employee(
--EmployeeID int,
--JobTitle varchar (100),
--Salary int
--)

--INSERT INTO #temp_Employee VALUES (
--'1001', 'HR', '45000'
--)

--SELECT * FROM #temp_Employee

--INSERT INTO #temp_Employee
--SELECT*
--FROM EmployeeSalary

--SELECT * FROM #temp_Employee

--DROP TABLE IF EXISTS #temp_EMployee2
--CREATE TABLE #temp_EMployee2(
--JobTitle varchar(50),
--EmployeesPerJob int,
--AvgAge int,
--AvgSalary int)

--INSERT INTO #temp_EMployee2
--SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
--FROM EmployeeDemographics emp
--JOIN EmployeeSalary sal
--	ON emp.EmployeeID = sal.EmployeeID
--GROUP BY JobTitle

--Select * FROM #temp_EMployee2


--------String functions TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower--------

--Drop Table EmployeeErrors;

--CREATE TABLE EmployeeErrors (
--EmployeeID varchar(50)
--,FirstName varchar(50)
--,LastName varchar(50)
--)

--Insert into EmployeeErrors Values 
--('1001  ', 'Jimbo', 'Halbert')
--,('  1002', 'Pamela', 'Beasely')
--,('1005', 'TOby', 'Flenderson - Fired')

--Select *
--From EmployeeErrors

----Using Trim, LTRIM, RTRIM (get rid of empty spaces)----

--Select EmployeeID, TRIM(employeeID) AS IDTRIM
--FROM EmployeeErrors 

--Select EmployeeID, RTRIM(employeeID) as IDRTRIM
--FROM EmployeeErrors 

--Select EmployeeID, LTRIM(employeeID) as IDLTRIM
--FROM EmployeeErrors

---Using Replace---

--Select LastName, REPLACE(LastName, '- Fired', '') as LastNameFixed
--FROM EmployeeErrors


---- Using Substring (table, where to start, for how many spaces) ----

--Select Substring(err.FirstName,1,3), Substring(dem.FirstName,1,3), Substring(err.LastName,1,3), Substring(dem.LastName,1,3)
--FROM EmployeeErrors err
--JOIN EmployeeDemographics dem
--	on Substring(err.FirstName,1,3) = Substring(dem.FirstName,1,3)
--	and Substring(err.LastName,1,3) = Substring(dem.LastName,1,3)



---- Using UPPER and LOWER change to lower or upper case----

--Select firstname, LOWER(firstname)
--from EmployeeErrors

--Select Firstname, UPPER(FirstName)
--from EmployeeErrors


--------Stored procedures--------

--CREATE PROCEDURE Temp_Employee
--AS
--DROP TABLE IF EXISTS #temp_employee
--Create table #temp_employee (
--JobTitle varchar(100),
--EmployeesPerJob int ,
--AvgAge int,
--AvgSalary int
--)

--Insert into #temp_employee
--SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
--FROM SQLTutorial..EmployeeDemographics emp
--JOIN SQLTutorial..EmployeeSalary sal
--	ON emp.EmployeeID = sal.EmployeeID
--group by JobTitle

--Select * 
--From #temp_employee
--GO;

--CREATE PROCEDURE Temp_Employee2 
--@JobTitle nvarchar(100)
--AS
--DROP TABLE IF EXISTS #temp_employee3
--Create table #temp_employee3 (
--JobTitle varchar(100),
--EmployeesPerJob int ,
--AvgAge int,
--AvgSalary int
--)

--Insert into #temp_employee3
--SELECT JobTitle, Count(JobTitle), Avg(Age), AVG(salary)
--FROM SQLTutorial..EmployeeDemographics emp
--JOIN SQLTutorial..EmployeeSalary sal
--	ON emp.EmployeeID = sal.EmployeeID
--where JobTitle = @JobTitle --- make sure to change this in this script from original above
--group by JobTitle

--Select * 
--From #temp_employee3
--GO;

--exec Temp_Employee2 @jobtitle = 'Salesman'
--exec Temp_Employee2 @jobtitle = 'Accountant'

--------Subqueries--------

--Select EmployeeID, JobTitle, Salary
--From EmployeeSalary

---- Subquery in Select

--Select EmployeeID, Salary, (Select AVG(Salary) From EmployeeSalary) as AllAvgSalary
--From EmployeeSalary

---- How to do it with Partition By
--Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
--From EmployeeSalary

---- Why Group By doesn't work
--Select EmployeeID, Salary, AVG(Salary) as AllAvgSalary
--From EmployeeSalary
--Group By EmployeeID, Salary
--order by EmployeeID


---- Subquery in From

--Select a.EmployeeID, AllAvgSalary
--From 
--	(Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
--	 From EmployeeSalary) a
--Order by a.EmployeeID


---- Subquery in Where


--Select EmployeeID, JobTitle, Salary
--From EmployeeSalary
--where EmployeeID in (
--	Select EmployeeID 
--	From EmployeeDemographics
--	where Age > 30)




