USE Chinook;
SHOW TABLES
-- TASK 1; STRING FUNCTIONS
-- Write a query that will return all the columns for the tracks that contain the word love
SELECT 
POSITION("love" IN Name) AS position
FROM Track;

-- 2: Limit to 10
SELECT 
POSITION("love" IN Name) AS position
FROM Track
LIMIT 10;

-- 3. Formulate a query that returns customers with email addresses that have domains that end in three letters. 
SELECT 
CustomerId,
Email,
right(Email, 3) AS domain
FROM Customer
WHERE Email LIKE "%.___";

-- 4. Write a query that shows all customers who live in the UK.
SELECT 
CustomerId,
Country
FROM Customer
WHERE Country = "United Kingdom";

-- 5. Write a query that shows employee first and last names in the same column. 
SELECT 
FirstName,
LastName,
CONCAT(FirstName," ", LastName) AS full_name
FROM Customer;

-- DATETIME FUNCTIONS
-- 1. Run a query that will give us a view of the data type of the employees table. 
DESCRIBE Employee;

 -- 2. Write a query that shows the age of all employees when they were hired. 
 SELECT  
 EmployeeId,
 BirthDate,
 HireDate,
 timestampdiff(YEAR, BirthDate, HireDate) AS age
 FROM Employee;
 
 
-- 3. Return data in the FirstName and LastName columns and create an Age when hired alias for the age from the employees table
SELECT  
FirstName,
LastName,
timestampdiff(YEAR, BirthDate, HireDate) AS age_when_hired
FROM Employee;

-- 4. In the context of DateTime SQL objects, the substr() function allows us to trim or extract certain information within the date or time. We use it by specifying the string and the indices from which to show data, i.e. substr(datetime_column,start_index, end_index) 
SELECT 
HireDate,
substr(HireDate, 1, 4) AS year
FROM Employee;

SELECT 
HireDate,
substr(HireDate, 6, 2) AS month
FROM Employee;

SELECT 
HireDate,
substr(HireDate, 9, 2) AS day
FROM Employee;

-- 5. Write a query that calculates the month-to-month revenue at Chinook.
SELECT 
MONTH(InvoiceDate) AS month_R, 
SUM(Total) AS monthly_revenue
FROM Invoice
GROUP BY 1;

 -- 6. Return the month and revenue and use aliases to name the calculated columns appropriately. 
SELECT
YEAR(InvoiceDate) AS year_R, 
MONTH(InvoiceDate) AS month_R,
SUM(Total) AS monthly_revenue,
SUM(SUM(Total)) OVER (PARTITION BY YEAR(InvoiceDate)) AS Annual_Revenue
FROM Invoice
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate)
order by 1,2;

-- 7. Write a query that calculates the year-to-year revenue at Chinook. 
SELECT 
YEAR(InvoiceDate) AS years_R, 
SUM(Total) AS yearly_revenue
FROM Invoice
GROUP BY 1;

-- 8. Write a query that returns employees who were hired after 2002-08-14 and before 2003-10-17.
SELECT 
EmployeeId,
FirstName,
LastName,
HireDate
FROM Employee
WHERE HireDate >'2002-08-14' AND HireDate < '2003-10-17';








 

