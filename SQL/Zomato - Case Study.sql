-- Dataset Link - https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbmpuQnRwcW1FcHhmOWZWLTVmSkhsU21qVnMwZ3xBQ3Jtc0tuRmxNMkpRazZ1V2FGLWUxT2tIWXo4WHJXM3FhY0NSZjh3SHktU0RFc3hsa2NLdUtsMmdIN0E5MnFhNEJIU25FdHA2emktellrM2NncV9sS1I5WGlEWUhyVVVrRms2M0ROLTRMcmU1dko2Mk9yM3N3MA&q=https%3A%2F%2Fdocs.google.com%2Fspreadsheets%2Fd%2F1JgNHxTixDA50W1l6pNFmHKRaX1a9QnXrpGLsJtzo6Gg%2Fedit%3Fusp%3Dsharing&v=jYwcB0KEFfY
-- 

USE Zomato;

-- 
-- Find Null values
SELECT * 
FROM orders
WHERE restaurant_rating IS null;


-- Find the number of order placed by each customer
SELECT name, COUNT(*) AS "Number of Orders"
FROM users u JOIN orders o
ON u.user_id = o.user_id
GROUP BY name

-- Find restraunts with most number of menu items
SELECT r_name, COUNT(menu_id) as "Menu Items"
FROM restaurants r JOIN menu m
ON r.r_id = m.r_id 
GROUP BY r_name
ORDER BY "Menu Items" DESC;

-- Find Number of Votes and Average Rating of all the restaurants
SELECT r_name, COUNT(*) AS "Number of Votes", AVG(restaurant_rating) as "Average Rating"
FROM orders o JOIN restaurants r 
ON o.r_id = r.r_id
WHERE restaurant_rating IS NOT NULL
GROUP BY r_name

-- Find the food that is being sold at most number of resturants

