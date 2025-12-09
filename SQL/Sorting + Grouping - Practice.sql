-- This Notebook is for the practice of Sorting & Grouping Exercise

-- Dataset Link: https://www.google.com/url?q=https%3A%2F%2Fwww.kaggle.com%2Fdatasets%2Fequilibriumm%2Fsleep-efficiency
-- Table Name: sleep_efficieny

-- Questions
-- Knowing The Data
SELECT * FROM sleep_efficiency;

-- 1.Find out the average sleep duration of top 15 male candidates who's sleep duration are equal to 7.5 or greater than 7.5.
SELECT *
FROM sleep_efficiency
WHERE Gender = "Male" AND `Sleep duration` >= 7.5
ORDER BY `Sleep duration` DESC LIMIT 15;

-- 2. Show avg deep sleep time for both gender. Round result at 2 decimal places.
-- Note: sleep time and deep sleep percentage will give you, deep sleep time.
SELECT Gender, ROUND(AVG(`Sleep duration`*`Deep sleep percentage`/100),2) AS "Average Deep Sleep Time"
FROM sleep_efficiency
GROUP BY Gender;

-- 3. Find out the lowest 10th to 30th light sleep percentage records where deep sleep percentage values are between 25 to 45. Display age, light sleep percentage and deep sleep percentage columns only.
SELECT Age, `Light sleep percentage`, `Deep sleep percentage`
FROM sleep_efficiency
WHERE `Deep sleep percentage` BETWEEN 25 AND 45
ORDER BY `Light sleep percentage` ASC
LIMIT 20 offset 8;

-- 4. Group by on exercise frequency and smoking status and show average deep sleep time, average light sleep time and avg rem sleep time.
-- Note the differences in deep sleep time for smoking and non smoking status
SELECT  
        `Exercise frequency`, `Smoking Status`, 
        ROUND(AVG(`Sleep duration` * `Deep sleep percentage` / 100),2),
        ROUND(AVG(`Light sleep percentage` * `Sleep duration`/100),2), 
        ROUND(AVG(`REM sleep percentage`*`Sleep duration`/100),2)
FROM sleep_efficiency
GROUP BY `Exercise frequency`, `Smoking status`

-- 5.Group By on Awekning and show AVG Caffeine consumption, AVG Deep sleep time and AVG Alcohol consumption only for people who do exercise atleast 3 days a week. Show result in descending order awekenings
SELECT AVG(`Caffeine consumption`), AVG(`Alcohol consumption`)
FROM sleep_efficiency
WHERE `Exercise frequency` >= 3
GROUP BY `Awakenings`
ORDER BY `Awakenings` DESC


-- DataSet Link: https://www.google.com/url?q=https%3A%2F%2Fwww.kaggle.com%2Fdatasets%2Farvindnagaonkar%2Fpower-generation-data
-- Table: power

-- Understanding Data:
SELECT * FROM power;

-- Display those power stations which have average 'Monitored Cap.(MW)' (display the values) between 1000 and 2000 
-- and the number of occurance of the power stations (also display these values) are greater than 200. Also sort the result in ascending order.

SELECT `Power Station`, AVG(`Monitored Cap.(MW)`), COUNT(*) AS "Occurence of Power Station"
FROM power
GROUP BY `Power Station`
HAVING AVG(`Monitored Cap.(MW)`) BETWEEN 1000 AND 2000 AND COUNT(*) > 200
ORDER BY `Occurence of Power Station` ASC;

-- DataSet Link: https://www.google.com/url?q=https%3A%2F%2Fwww.kaggle.com%2Fdatasets%2Fkfoster150%2Favg-cost-of-undergrad-college-by-state
-- Table: college

-- Understanding Data
SELECT * FROM college;

-- Questions;

-- Display top 10 lowest "value" State names of which the Year either belong to 2013 or 2017 or 2021 and type is 'Public In-State'. 
-- Also the number of occurance should be between 6 to 10. Display the average value upto 2 decimal places, state names and the occurance of the states.

SELECT `State`, COUNT(*)
FROM college
WHERE `Year` IN (2013,2017,2021) AND Type = "Public In-State"
GROUP BY `State`
HAVING  COUNT(*) BETWEEN 6 AND 10
ORDER BY AVG(Value) ASC 
LIMIT 10

-- Best state in terms of low education cost (Tution Fees) in 'Public' type university.
SELECT `State`
FROM college
WHERE Type LIKE "Public%"
GROUP BY `State`
ORDER BY AVG(Value) ASC
LIMIT 1







