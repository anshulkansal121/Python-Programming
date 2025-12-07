-- DML Command / CRUD Commands
-- CREATE -> INSERT
-- READ -> SELECT
-- UPDATE -> UPDATE
-- DELETE -> DELETE


CREATE DATABASE IF NOT EXISTS Practice;


-- Data Manipulation Languages (DML) Commands

CREATE TABLE IF NOT EXISTS dml_commands(
	id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    branch VARCHAR(255) NOT NULL
);

-- INSERT
INSERT INTO dml_commands() -- There is no need to mention the () if you are inserting in all the columns 
VALUES (1, 'jonny', 'IT'), (2, 'DEX', 'CS'), (3, 'SAM', 'MEAH');

-- Different Ways of Insertion
-- 1. Inserting into All Columns
CREATE TABLE users (id INT, name VARCHAR(50), age INT);
INSERT INTO users
VALUES (1, 'John Doe', 30);

-- 2. Inserting into Specific Columns
CREATE TABLE users (id INT AUTO_INCREMENT, name VARCHAR(50), age INT);
INSERT INTO users (name, age)
VALUES ('Jane Doe', 28);

-- 3. Inserting Multiple Rows at Once
CREATE TABLE customers (name VARCHAR(50), age INT, country VARCHAR(50));
INSERT INTO customers (name, age, country)
VALUES
    ('Mike', 35, 'USA'),
    ('Emma', 22, 'UK'),
    ('Tom', 40, 'Canada');

-- 4. Inserting from Another Table - (IMP)
CREATE TABLE new_customers (name VARCHAR(50), age INT);
CREATE TABLE old_customers (name VARCHAR(50), age INT);

INSERT INTO new_customers (name, age) -- Dont need to write `VALUES` here
SELECT name, age
FROM old_customers;

-- 5. Inserting with Default Values
CREATE TABLE users (id INT AUTO_INCREMENT, name VARCHAR(50), age INT DEFAULT 18);
INSERT INTO users (name)
VALUES ('Alex');

-- DELETE
SET SQL_SAFE_UPDATES = 0;
DELETE FROM dml_commands
WHERE name = 'DEX';

-- UPDATE
UPDATE dml_commands
SET name = 'new_name', branch = 'ABC' -- Multiple Updations
WHERE id = 1;

-- DELETE and UPDATE are perminant Querries

SELECT * FROM dml_commands; -- SELECT is a DQL command

-- Creating new column with default values
SELECT
brand_name, 'smartphone' AS 'phone' -- `phone` is col name and `smartphone` is default value
from dml.smartphones;


-- READING / FETCHING RECORDS FROM THE TABLES
-- FOR THIS PART I have IMPORTED data using Data import Wizard and Dataset can be found here
-- LINK: https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbndlOFpCSndSbThiZkdWaFBsVTVuZjhUX0c0QXxBQ3Jtc0trajF6QkIxRFFjMnl2em1QU0hlM28tVzZsWFdubTYyVEpVeFRwVHN1Rk0tREhoM3lNSHdNZkNXTHZNWUJLS0pyMDBqNW45YV9yNVlhcVRhZWllUzdoa21OeXZLekhjVHVXYzgzTFBDWmlMNXNVMDFPZw&q=https%3A%2F%2Fdrive.google.com%2Fdrive%2Ffolders%2F1rN2AkOfuJEhroHqRuECshxBKhz0gJBeJ%3Fusp%3Dshare_link&v=kzMZDlvHFak

-- FETCHING ALL RECORDS
SELECT * FROM smartphones;

-- FETCHING SPECIFIC COLUMNS / RECORDS
SELECT model,price,rating FROM smartphones;

-- WE CAN ALSO CHANGE ORDERS OF COLUMNS
SELECT os, battery_capacity FROM smartphones;

-- ALIAS 
SELECT os AS "Operating System", battery_capacity as "MaH"
FROM smartphones;

-- WE NEED each model with thier PPI Value
-- PPI = sqrt(width^2 + height^2) / screen_resolution

SELECT model as "Phone",
ROUND(SQRT(resolution_width*resolution_width + resolution_height*resolution_height) / screen_size,2)
FROM smartphones;


-- FETCHING UNIQUE / DISTINCT Values from a Columns
SELECT DISTINCT(brand_name) as "BRANDS" FROM smartphones;

-- Filtering ROWS based on Columns values using WHERE clause
-- Q. FETCHING ALL THE DETAILS OF THE SMARTPHONES TABLE WHERE BRAND NAME IS SAMSUNG
SELECT * 
FROM smartphones
WHERE brand_name = "Samsung";

-- FETCH EVERY PHONE  with PRICE > 50000
SELECT *
FROM smartphones
WHERE price > 50000;

-- Similarly we can have multiple operators that can be used in WHERE clause
-- 1. Arithematic Operator
-- a. Addition 
-- b. Substraction
-- c. Multiplication
-- d. Division
-- e. Modulus / Remainder

-- 2. Comparison Operator
-- a. Equal to (=)
-- b. Not equal to (<> or !=) 
-- c. Greater than ( > )
-- d. Less than ( < )
-- e. Greater than or equal to ( >= )
-- f. Less than or equal to ( <= )

-- 3. STRING Operator
-- a. LIKE


-- FETCH THE NAME OF THE BRANDS THAT MAKE PHONE PRICE greater than 50000
SELECT brand_name
FROM smartphones
WHERE price > 50000;


-- FURTHER WE HAVE UPDATE AND DELETE COMMANDS -> Works SIMILAR TO ABOVE.
