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


-- Find the most favourit food of each customer (criteria - most ordered)