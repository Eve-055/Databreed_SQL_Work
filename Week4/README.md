    This is assignment for Week 4 on Northwind data
    #  STRING FUNCTIONS:
Use Northwind.db to solve the following tasks: 
6. Given the Employees table, write a SQL query to convert the salary of all employees 
from integer to string data type. 
7. In the Orders table, some of the ShipName entries have leading and trailing white 
spaces. Write a SQL query to trim these white spaces. 
8. The Customers table contains null values in the ContactTitle column. Write a SQL 
command to replace these null values with the string 'N/A'. 
9. Write a SQL command to extract the first three characters from the City column in 
the Customers table. 
10. Write a SQL query to concatenate the FirstName and LastName of employees in 
the Employees table into a new column FullName. 
11. You are working in the marketing department of your company and you have been 
given the task of conducting an email marketing campaign targeting all customers 
based in France. 
12. You have a Customers table which includes an Email column. However, the data isn't 
perfect. Some email addresses might be duplicated, others might be NULL, and some 
might have unnecessary white spaces at the start or end of the address. 
Your task is to clean up the data and compile a list of unique email addresses to use 
for the marketing campaign. Here are the requirements: 
I. Exclude any NULL email addresses from your list. We can't send emails to 
addresses we don't have. 
II. Make sure there are no duplicates in your list. We don't want to annoy our 
customers by sending them the same email multiple times. 
III Remove any unnecessary white spaces from the start or end of the email 
addresses. This will help avoid any errors when sending the emails.

   # WINDOW FUNCTIONS:
Use Northwind.db to solve the following tasks: 
1. Rank all the orders of a specific customer from the most recent to the least recent using 
window functions. Assume that the customer ID is 'ALFKI' 
2. Calculate a running total of the quantity of orders using window functions. 
3. Use window functions to find the difference in successive order dates for each 
customer.  
4. Calculate the moving average of the quantity of the last 3 orders for each product using 
window functions.

