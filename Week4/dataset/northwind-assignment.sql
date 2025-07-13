-- Q1.Given the Employees table, write a SQL query to convert the salary of all employees from integer to string data type.
USE northwind ;
SELECT*
FROM employees;

/* Q2. In the Orders table, some of the ShipName entries have leading and trailing white
spaces. Write a SQL query to trim these white spaces.*/
SELECT
ship_name,
TRIM(ship_name) AS New_Ship_Name
FROM orders;

/* Q3. The Customers table contains null values in the ContactTitle column. Write a SQL
command to replace these null values with the string 'N/A'. */
SELECT
home_phone,
IFNULL(home_phone, 'N/A') AS New_home_phone,
mobile_phone,
IFNULL(mobile_phone, 'N/A') AS New_mobile_phone
FROM customers;

/* Q4 Write a SQL command to extract the first three characters from the City column in
the Customers table. */
SELECT
city,
SUBSTR(city, 1, 3) AS Modified_city
FROM customers;

/* 5. Write a SQL query to concatenate the FirstName and LastName of employees in
the Employees table into a new column FullName. */
SELECT
first_name,
last_name,
CONCAT(first_name,' ',last_name) AS FullName
FROM employees;

/* Q6. You are working in the marketing department of your company and you have been
given the task of conducting an email marketing campaign targeting all customers
based in France. */
-- DROP DATABASE sir_co;
CREATE DATABASE ImaginaryEve;
USE ImaginaryEve;
CREATE TABLE customers(
	customer_id INT PRIMARY KEY,
	Cust_name VARCHAR(100),
	email_address VARCHAR (100),
	country VARCHAR (100),
	city VARCHAR (100)
);
INSERT INTO customers
(customer_id, Cust_name, email_address, country, city)
VALUES
(1, 'John maina', '  maina@gmail.com', 'France', 'paris'),
(2,'Chris Henswe',' chris3@gmail.com', 'France', 'paris'),
(3,'Chris Henswe',' chris3@gmail.com', 'France', 'paris'),
(4,'  Sinorita milo' ,' milo98@gmail.com ', 'France', 'paris'),
(5, 'Tom Otieno', NULL , 'France', 'paris'),
(6, 'Awillo ongoma', 'ongoma@gmail.com ', 'France', 'paris');

SELECT
	email_address
FROM customers
WHERE country = 'France';


/* 7. You have a Customers table which includes an Email column. However, the data isn't
perfect. Some email addresses might be duplicated, others might be NULL, and some
might have unnecessary white spaces at the start or end of the address.
Your task is to clean up the data and compile a list of unique email addresses to use
for the marketing campaign. Here are the requirements:
I. Exclude any NULL email addresses from your list. We can't send emails to
addresses we don't have.
II. Make sure there are no duplicates in your list. We don't want to annoy our
customers by sending them the same email multiple times.
III. Remove any unnecessary white spaces from the start or end of the email
addresses. This will help avoid any errors when sending the emails */


-- I. Exclude any NULL email addresses from your list. We can't send emails to addresses we don't have.
SELECT
cust_name,
email_address
FROM customers
WHERE email_address IS NOT NULL;

-- II. Make sure there are no duplicates in your list. We don't want to annoy our customers by sending them the same email multiple times.
SELECT
DISTINCT email_address
FROM customers
WHERE email_address IS NOT NULL;

-- III. Remove any unnecessary white spaces from the start or end of the email addresses. This will help avoid any errors when sending the emails
SELECT
DISTINCT (TRIM( email_address)) AS New_email
FROM customers
WHERE email_address IS NOT NULL;

-- WINDOW FUNCTIONS
/* 8. Rank all the orders of a specific customer from the most recent to the least recent using
window functions. Assume that the customer ID is 'ALFKI' */
USE northwind ;
SELECT
customer_id,
id,
RANK() OVER (ORDER BY order_date DESC) AS Rank_order_date
FROM orders
ORDER BY 3;

-- Q9. Calculate a running total of the quantity of orders using window functions.
SELECT
Order_id,
quantity,
SUM(quantity) OVER (ORDER BY Order_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Running_total
FROM order_details;

-- Q10 Use window functions to find the difference in successive order dates for each customer.
SELECT
customer_id,
order_date,
LAG (order_date, 1) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_order, 
DATEDIFF(order_date, LAG (order_date, 1) OVER (PARTITION BY customer_id ORDER BY order_date))AS Days_diff
FROM orders;

-- Q11 Calculate the moving average of the quantity of the last 3 orders for each product using window functions.
SELECT
product_id,
order_id,
quantity,
AVG(quantity) OVER (PARTITION BY product_id ORDER BY order_id ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Moving_avg_qnt
FROM order_details;






