-- View are Virtual Table that do not stores any data but is viewed as table in SQL
-- BTS : Views Store SQL Queries anfd Everytime you run / Query them that query fetched the data so their are somewhat dynamic in nature
-- Views can be Simple or Complex depending upon the number of tables and complexity of the underlying query

CREATE VIEW order_data AS
SELECT order_id,amount, r_name, name, date, delivery_time,delivery_rating,restaurant_rating
FROM orders o JOIN
users u ON o.user_id = u.user_id
JOIN restaurants r ON r.r_id = o.r_id;

SELECT * FROM order_data;

-- Readonly View - These cannot be updated
-- Updatable View - These can be writable, Update in Views will be reflected in the underlying tables aswell
-- inorder for a view to be updatable that it does not contain Aggregate Function, Subqueries, DISTINCT, HAVING, UNION//UNIONALL, CERTAIN JOINS


-- Materialized Views - it stores the result of the queries unlike normal Views that stores the SQL Query, 
-- BENEFIT: FASTER EXECUTION
-- DISADVANTAGE: NEED TO MANUALLY UPDATE THE VIEW




