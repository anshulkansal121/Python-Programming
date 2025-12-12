-- This Notebook is for Joins Practice
-- Dataset Link  = https://www.google.com/url?q=https%3A%2F%2Fdrive.google.com%2Fdrive%2Ffolders%2F1wr0J571rlfexEJ4-de6_tz1QvU-cJ0df%3Fusp%3Dshare_link
-- Sales DB

-- Tables:
-- 1. customers
-- 2. employees
-- 3. products
-- 4. sales1

-- checking Tables
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM products;
SELECT * FROM sales1;

-- 1. Find top-5 most sold products.
SELECT p.Name, SUM(Quantity) as "Units_Sold"
FROM products p JOIN sales1 s
ON p.ProductID = s.ProductID
GROUP BY p.Name
ORDER BY Units_Sold DESC 
LIMIT 5;

-- 2. Find sales man who sold most no of products.
SELECT e.FirstName, e.LastName, COUNT(s.ProductID) as "Products_Sold"
FROM employees e JOIN sales1 s
ON e.EmployeeID = s.SalesPersonID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY Products_Sold DESC
LIMIT 1;

-- 3. Sales man name who has most no of unique customer.
SELECT e.FirstName, e.LastName, COUNT(DISTINCT CustomerID) as "Customers"
FROM employees e JOIN sales1 s
ON e.EmployeeID = s.SalesPersonID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY Customers DESC 
LIMIT 5

-- 4. Sales man who has generated most revenue. Show top 5.
SELECT e.EmployeeID, e.FirstName, e.LastName, ROUND(SUM(Quantity * Price),2) as "Revenue"
FROM employees e JOIN sales1 s
ON e.EmployeeID = s.SalesPersonID 
JOIN products p
ON s.ProductID = p.ProductID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY Revenue DESC
  LIMIT 5;

-- 5. List all customers who have made more than 10 purchases.
SELECT c.FirstName, c.LastName, COUNT(*)
FROM customers c JOIN sales1 s
ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
HAVING COUNT(*) >= 10;

-- 6. List all salespeople who have made sales to more than 5 customers.
SELECT e.EmployeeID, e.FirstName,e.LastName, COUNT(DISTINCT CustomerID)
FROM employees e JOIN sales1 s
ON e.EmployeeID = s.SalesPersonID
GROUP BY e.EmployeeID, e.FirstName,e.LastName
HAVING COUNT(DISTINCT CustomerID) >  5

-- 7. List all pairs of customers who have made purchases with the same salesperson. -- incomplete





