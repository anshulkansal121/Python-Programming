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










