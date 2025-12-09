-- For this Notebook we will again we working with the smartphones data. Carry out this with a series of questions
-- Sorting

-- Syntax: 
-- ORDER BY column_name DESC/ASC

-- 1. find the top 5 Samsung phones with the biggest screen size
SELECT * FROM smartphones;
SELECT *
FROM smartphones
WHERE brand_name = "samsung"
ORDER BY screen_size DESC 
LIMIT 5;

-- 2. sort all the phones in descending order of the number of total cameras

SELECT *
FROM smartphones
ORDER BY ( num_rear_cameras + num_front_cameras ) DESC;

-- 3. sort data on the basis of ppi in decreasing order
SELECT * , 
  SQRT((resolution_width * resolution_width) + (resolution_height * resolution_height)) as "ppi"
FROM smartphones
ORDER BY ppi DESC;

-- 4. find the phone with 2nd largest battery
SELECT model, battery_capacity
FROM smartphones
ORDER BY battery_capacity DESC 
LIMIT 1,1;

-- 5. find the name and rating of the worst rated apple phone
SELECT model, rating
FROM smartphones
WHERE brand_name = 'apple'
ORDER BY rating ASC;

-- 6. sort phones alphabetically and then on the basis of rating in desc order
SELECT *
FROM smartphones
ORDER BY brand_name ASC, rating DESC;

-- 7. sort phones alphabetically and then on the basis of price in ascending order
SELECT *
FROM smartphones
ORDER BY brand_name ASC, price ASC;

-- GROUP BY
-- Group smartphones by brand and get the count, average price, max rating, avg screen size, and avg battery capacity
SELECT brand_name,COUNT(*), AVG(price), max(rating), AVG(screen_size), AVG(battery_capacity)
FROM smartphones
GROUP BY brand_name;

-- Group smartphones by whether they have an NFC and get the average price and rating
SELECT has_nfc , AVG(price), AVG(rating)
FROM smartphones
group by has_nfc;

-- Group smartphones by the extended memory available and get the average price
SELECT extended_memory_available, AVG(price)
FROM smartphones
GROUP BY extended_memory_available;

-- GROUP BY ON MULTIPLE COLUMNS
-- Group smartphones by the brand and processor brand and get the count of models and the average primary camera resolution (rear)
SELECT brand_name, processor_brand, COUNT(model), AVG(primary_camera_rear)
FROM smartphones
GROUP BY brand_name, processor_brand;

-- Find the top 5 most costly phone brands
SELECT brand_name, ROUND(AVG(price),2) as "APrice"
FROM smartphones
GROUP BY brand_name
ORDER BY APrice desc
LIMIT 5;

-- Group smartphones by the brand, and find the brand with the highest number of models that have both NFC and an IR blaster
SELECT brand_name, COUNT(model) as "num_of_model"
FROM smartphones
WHERE has_nfc = "True" AND has_ir_blaster = "True"
GROUP BY brand_name
ORDER BY num_of_model DESC;


-- Find all Samsung 5g enabled smartphones and find out the avg price for NFC and Non-NFC phones
SELECT has_nfc, AVG(price)
FROM smartphones
WHERE brand_name = "samsung"
GROUP BY has_nfc

-- HAVING CLAUSE
-- Costliest Brand which has at least 20 phones.
SELECT brand_name, AVG(price)
FROM smartphones
GROUP BY brand_name
HAVING COUNT(*) > 20
ORDER BY AVG(price) DESC
LIMIT 1

-- find the avg rating of smartphone brands that have more than 20 phones
SELECT brand_name, AVG(rating)
FROM smartphones
GROUP BY brand_name
HAVING COUNT(*) > 40
ORDER BY AVG(rating) DESC


-- Find the top 3 brands with the highest avg ram that has a refresh rate of at least 90 Hz and fast charging available and don't consider brands that have less than 10 phones
SELECT brand_name, AVG(ram_capacity) as "Avg_Ram"
FROM smartphones
WHERE refresh_rate >= 90 AND fast_charging_available = 1
GROUP BY brand_name
HAVING COUNT(model) < 10
ORDER BY Avg_Ram DESC LIMIT 3;

-- Find the avg price of all the phone brands with avg rating of 70 and num_phones more than 10 among all 5g enabled phones
SELECT brand_name, AVG(price)
FROM smartphones
WHERE has_5g = "True"
GROUP BY brand_name
HAVING AVG(rating) > 70 AND COUNT(model) > 10