-- What we will Learn
-- OVER 
-- RANK
-- DENSE_RANK 
-- ROW_NUMBER
-- FRIST_VALUE
-- LAST_VALUE
-- NTH_VALUE
-- LAG
-- LEAD

-- Understanding
-- FRAMES

  

-- Creating Marks Table
CREATE TABLE marks(
	name VARCHAR(255),
    branch VARCHAR(255),
    marks INT
);

INSERT INTO marks (name,branch,marks) VALUES 
('Nitish','EEE',82),
('Rishabh','EEE',91),
('Anukant','EEE',69),
('Rupesh','EEE',55),
('Shubham','CSE',78),
('Ved','CSE',43),
('Deepak','CSE',98),
('Arpan','CSE',95),
('Vinay','ECE',95),
('Ankit','ECE',88),
('Anand','ECE',81),
('Rohit','ECE',95),
('Prashant','MECH',75),
('Amit','MECH',69),
('Sunny','MECH',39),
('Gautam','MECH',51);



select * from marks;

SELECT branch, AVG(marks)
FROM marks
GROUP BY branch;

-- OVER With Partition by
-- Find the avg marks of all the student for their respective branch
SELECT 
      * ,
      AVG(marks) OVER(PARTITION BY branch)
FROM marks

-- Find the minimum and max marks corrosopnding to all the student as per there specific branch
SELECT name, branch, marks,
MIN(marks) OVER(PARTITION BY branch) AS "Lowest Marks",
MAX(marks) OVER(PARTITION BY branch) AS "Highest Marks"
FROM marks;


-- ROW_NUMBER(): Unique sequential integer (1, 2, 3...) per partition.
-- RANK(): Ranks with gaps for ties (e.g., 1, 1, 3).
-- DENSE_RANK(): Ranks without gaps for ties (e.g., 1, 1, 2).
-- NTILE(n): Splits rows into n groups (e.g., quartiles).

SELECT *, 
      RANK() OVER(PARTITION BY branch ORDER BY marks DESC) AS "RANK",
      DENSE_RANK() OVER(PARTITION BY branch ORDER BY marks DESC) AS "DENSE_RANK",
      ROW_NUMBER() OVER(PARTITION BY branch ORDER BY marks DESC) AS "ROW_NUMBER"
FROM marks;


-- You have to find top 2 users from each month who have the total max bill in that month
WITH month_ranking AS (SELECT MONTHNAME(date),
      user_id,
      SUM(amount),
      RANK() OVER(PARTITION BY MONTHNAME(date) ORDER BY SUM(amount) DESC) as 'month_rank'
FROM orders
GROUP BY MONTHNAME(date),user_id
)

SELECT *
FROM month_ranking
WHERE month_rank < 3

-- FIRST_VALUE(column): First row in the partition.
-- LAST_VALUE(column): Last row in the partition.
-- NTH_VALUE(column): Nth row in the partition.

-- Find the student who got highest marks in there respective branch
SELECT *,
FIRST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC) AS "Topper",
LAST_VALUE(name) OVER(PARTITION BY branch ORDER BY marks DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Back Bencher", -- Frames
NTH_VALUE(name, 2) OVER(PARTITION BY branch ORDER BY marks ASC) AS "Avg"
FROM marks;


-- LEAD(column, offset): Access a subsequent row.
-- LAG(column, offset): Access a preceding row
SELECT *,
LEAD(marks) OVER(PARTITION BY branch),
LAG(marks) OVER(PARTITION BY branch)
FROM marks;

-- Find the MoM revenue growth of Zomato - Important
SELECT 
      MONTHNAME(date), 
      SUM(amount),
      (SUM(amount) - LAG(SUM(amount)) OVER(ORDER BY MONTHNAME(date) DESC))/(LAG(SUM(amount)) OVER(ORDER BY MONTHNAME(date) DESC))*100
FROM orders
GROUP BY MONTHNAME(date)
ORDER BY MONTHNAME(date) DESC