create database temptable
use temptable

create table #temptable (id int)
insert into #temptable values (1),(2)

delete #temptable
where id=2

select*from #temptable

-- DDL Script for Tables
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(100),
    DepartmentID INT,
    HireDate DATE,
    Salary DECIMAL(10, 2)
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(100)
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName NVARCHAR(100),
    StartDate DATE,
    EndDate DATE
);

CREATE TABLE EmployeeProjects (
    EmployeeID INT,
    ProjectID INT,
    HoursWorked INT,
    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);


-- Insert Statements for Sample Data
-- Insert into Departments
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');

-- Insert into Employees
INSERT INTO Employees (EmployeeID, Name, DepartmentID, HireDate, Salary) VALUES
(101, 'Alice', 1, '2022-01-15', 60000.00),
(102, 'Bob', 2, '2021-06-20', 75000.00),
(103, 'Charlie', 3, '2020-03-01', 50000.00),
(104, 'Diana', 2, '2019-07-10', 80000.00),
(105, 'Eve', 1, '2023-02-25', 55000.00);

-- Insert into Projects
INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate) VALUES
(201, 'Project Alpha', '2023-01-01', '2023-12-31'),
(202, 'Project Beta', '2022-05-15', NULL),
(203, 'Project Gamma', '2021-09-01', '2022-12-31');

-- Insert into EmployeeProjects
INSERT INTO EmployeeProjects (EmployeeID, ProjectID, HoursWorked) VALUES
(101, 201, 120),
(102, 202, 200),
(103, 203, 150),
(104, 201, 100),
(105, 202, 180);

-- Puzzle 1: Create a Stored Procedure
-- Create a stored procedure that returns all employees in a given department.
-- Input: Department Name
-- Output: Employee Details

--create procedure getempdept @DepartmentName varchar(30)
--as
--begin
--select e.*, d.departmentname from Employees E
--join Departments D on e.DepartmentID=d.DepartmentID
--where d.DepartmentName=@DepartmentName
--end



--execute getempdept 'hr'


create procedure getempdept2 @salary decimal(10,2)
as begin 
 select* from Employees
 where Salary>@salary
 end

execute  getempdept2 60000


Puzzle 2: Create a View
-- Create a view that shows employee names, department names, and total hours worked on all projects.

create view getallprojects 
as 
select 
d.departmentname,
e.name,
sum(p.hoursworked)  as totalHours
from Departments d
join Employees E on d.DepartmentID=e.DepartmentID
 left join EmployeeProjects P on e.EmployeeID=p.EmployeeID
group by e.Name,d.DepartmentName

select*from getallprojects


------------------------------------------------------------
declare @start int
 declare @end int
 set @start=1
 set @end=101

while @start < @end
begin 
   if @start%2=0
   print @start
   set @start = @start+1
end











----------------------------------------------------------------------------------------------
-- Homework 3: Create a View for Analysis
-- Create a view that lists all active projects (projects that have not ended yet)
-- and the number of employees assigned to each project
----------------------------------------------------------------------------------------------------------------
--Homework 4:
--- write a query to check number is perfect or not






select* from  Departments
select* from Employees
select* from Projects
select* from EmployeeProjects


--Homework 1: Use a Temporary Table
-- Create a temporary table to store employees hired in the last year and their department names.
-- Then return the contents of the temporary table.

create table #TempEmployeehire (
    EmployeeID int,
    EmployeeName varchar(30),
    DepartmentName varchar(30),
    HireDate DATE)

insert into #TempEmployeehire (EmployeeID,EmployeeName,DepartmentName,HireDate)
select e.EmployeeID, e.Name,e.HireDate,d.departmentName from Employees as E
join Departments D on e.DepartmentID=d.DepartmentID
where e.HireDate>(select DATEADD(year,-3,getdate())) 

select*from #TempEmployeehire
drop table #TempEmployeehire




-- Homework 2: Advanced Stored Procedure
-- Create a stored procedure that assigns an employee to a project.
-- Input: EmployeeID, ProjectID, HoursWorked
-- Output: Success/Failure Message


    create proc assignemp
               @EmployeeID int,
               @ProjectID int,
               @HoursWorked int

as
  begin
       insert into employeeprojects  (EmployeeID,ProjectID ,HoursWorked ) 
        values( @EmployeeID ,@ProjectID ,@HoursWorked )
        if @HoursWorked>150 
   begin
       print 'success'
   end
   else
   begin
       print'failure'
   end
   end

exec adstoredproc 
































































