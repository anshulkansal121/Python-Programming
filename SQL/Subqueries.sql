  -- Types of Subqieries
-- 1. Result it Returns
-- Three Types:
-- a. Scaler Subquery - retunrs a scaler value
-- b. Row Subquery - retunrs rows of values
-- c. Table Subquery  - retunrs a table as result


-- 2 Based on Working
-- a. Independent
-- b. Correlated

--  INDEPENDENT SCALER SUBQUERY
-- Find the Movie with Highest profit
SELECT * FROM movies;
SELECT * 
FROM movies
WHERE (gross - budget) = (SELECT max(gross - budget) FROM movies)


-- Find how many movies have a rating > the average of all the movie rating(Find the count of above movies)
SELECT COUNT(*)
FROM movies 
WHERE score > (SELECT AVG(score) FROM movies)

-- Find the highest rated movie in 2000 year
SELECT * FROM movies WHERE score = (SELECT MAX(score)
FROM movies 
WHERE year = 2000) AND year  = 2000

-- Find the highest rated movie among all the movies whose number of votes are > than dataset avg votes
SELECT * FROM movies
WHERE score = (SELECT MAX(score)
				FROM movies
				WHERE votes > (SELECT AVG(votes) FROM movies)); -- Nested Subquerries

-- Independent Row Subqueries
-- Find the users who never ordered
SELECT * FROM users
WHERE user_id NOT IN (SELECT DISTINCT(user_id) FROM orders)

-- Find all the movies made by top 3 directors(in terms of total gross income)
SELECT * 
FROM movies
WHERE director IN (
SELECT director
FROM movies
GROUP BY director
ORDER BY SUM(gross) DESC
LIMIT 3
)

with top_directors as (SELECT director
FROM movies
GROUP BY director
ORDER BY SUM(gross) DESC
LIMIT 3)

SELECT * FROM movies
WHERE director in (SELECT * FROM top_directors)


-- Independent Table Subquery
-- Find most profitable movie of each year
SELECT * FROM movies
WHERE (year, gross - budget) IN (
                            SELECT year, 
                            MAX(gross - budget) as "Profit"
                            FROM movies
                            GROUP BY year
  )


-- Find the highest rated movie of each genre votes cutoff of 25000
SELECT * 
FROM movies
WHERE (genre,score) IN
( SELECT genre, MAX(score)
FROM movies
WHERE votes > 25000
GROUP BY genre )


-- Correlated Subquery
-- Print those movies which have higher rating than the average rating of the gonera of which the movie belongs
SELECT * 
FROM movies m1
WHERE score > (
SELECT AVG(score)
FROM movies m2
WHERE m2.genre = m1.genre
)
-- Find the most favourit food of each customer (criteria - most ordered)
WITH fav_food AS (
	SELECT t2.user_id,name, f_name, COUNT(*) as "frequency" 
    FROM users AS t1
    JOIN orders AS t2 ON t1.user_id = t2.user_id
    JOIN order_details AS t3 ON t2.order_id = t3.order_id
    JOIN food AS t4 ON t3.f_id = t4.f_id
    GROUP BY t2.user_id, t3.f_id,name,f_name
)

SELECT * FROM fav_food AS f1
WHERE frequency = (SELECT MAX(frequency) FROM fav_food AS f2 WHERE f2.user_id = f1.user_id);


-- Subquerry with SELECT - you need to be super carefull when using subquerries with select  because for each row you are traversing over entire dataset, its like O(n^2) TC
-- calculate the precent vote of each movie
SELECT name , votes / (SELECT SUM(votes) FROM movies)* 100
FROM movies

-- Display all movie names, genre, score and avg(score)
SELECT name, genre, score, (SELECT AVG(score) FROM movies m2 WHERE m2.genre = m1.genre)
FROM movies m1

-- Subquery with FROM
-- Display AVG rating of all the restraunts



-- Subquerries with Having
-- Find genres having avg(genre) > avg(all)
SELECT genre, AVG(score)
FROM movies
GROUP BY genre
HAVING AVG(score) > (SELECT AVG(score) FROM movies);

-- -- Subquerries with INSERT
CREATE TABLE IF NOT EXISTS loyal_customers(
	name VARCHAR(255),
    money INT
);
INSERT INTO loyal_customers(name) -- Dont write "VALUES" here if you are inserting values from another table
SELECT t1.name
FROM users AS t1
JOIN orders AS t2 ON t1.user_id = t2.user_id
GROUP BY t1.name
HAVING COUNT(*) > 3;

-- subquery with update
UPDATE loyal_customers
SET money = (SELECT SUM(amount)
				FROM zomato.orders
                WHERE orders.user_id = loyal_customers.user_id); # Adhi user id add kr loyal madhe nanter he querry run kr

SELECT t1.name, t2.discount
FROM zomato.user AS t1
INNER JOIN (SELECT user_id, SUM(amount) * 0.1 AS "discount"
FROM zomato.orders
GROUP BY user_id) AS t2 
ON t1.user_id = t2.user_id;

-- Subquerries with DELETE
DELETE FROM users
WHERE user_id IN (SELECT *
					FROM user AS t1
					WHERE user_id NOT IN (SELECT DISTINCT(user_id) FROM orders));

SELECT * FROM employees e
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.employee_id = e.id);