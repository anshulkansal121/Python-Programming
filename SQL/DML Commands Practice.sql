-- This is PRACTICE notebook for DML Commands


### Perform the following queries

-- 1. Show records of 'male' patient from 'southwest' region.
-- 2. Show all records having bmi in range 30 to 45 both inclusive.
-- 3. Show minimum and maximum bloodpressure of diabetic patient who smokes. Make column names as MinBP and MaxBP respectively.
-- 4. Find no of unique patients who are not from southwest region.
-- 5. Total claim amount from male smoker.
-- 6. Select all records of south region.
-- 7. No of patient having normal blood pressure. Normal range[90-120]
-- 8. No of pateint belo 17 years of age having normal blood pressure as per below formula -
--     - BP normal range = 80+(age in years × 2) to 100 + (age in years × 2)

--     - Note: Formula taken just for practice, don't take in real sense.
-- 9. What is the average claim amount for non-smoking female patients who are diabetic?
-- 10. Write a SQL query to update the claim amount for the patient with PatientID = 1234 to 5000.
-- 11. Write a SQL query to delete all records for patients who are smokers and have no children.


-- DATASET LINK : https://www.google.com/url?q=https%3A%2F%2Fdocs.google.com%2Fspreadsheets%2Fd%2Fe%2F2PACX-1vRa1wWwXmzxEvqITxj4OQTeLywlGTTsOTbhSRqKj2lPuGefjlci-DQhgLBPpgWXe8AAUu2WUBqY59X1%2Fpub%3Fgid%3D1030172542%26single%3Dtrue%26output%3Dcsv

-- LOAD THE DATASET USING THE FILE IMPORT WIZARD
-- DATASET LOADING -> insurance


-- Let's first take a look at data
SELECT * FROM insurance;

-- -- 1. Show records of 'male' patient from 'southwest' region.
SELECT *
FROM insurance
WHERE gender = 'male' AND region = "southwest";

-- 2. Show all records having bmi in range 30 to 45 both inclusive.
SELECT *
FROM insurance
WHERE bmi BETWEEN 30 AND 45;

-- 3. Show minimum and maximum bloodpressure of diabetic patient who smokes. Make column names as MinBP and MaxBP respectively.

SELECT MIN(bloodpressure) as MINBP, MAX(bloodpressure) as MAXBP
FROM insurance
WHERE smoker = 'Yes';

-- 4. Find no of unique patients who are not from southwest region.
SELECT COUNT (DISTINCT PatientID)
FROM insurance
WHERE region <> 'southwest';

-- 5. Total claim amount from male smoker.
SELECT SUM(claim)
FROM insurance
WHERE smoker = "Yes" AND gender = "male";


-- 6. Select all records of south region.
SELECT *
FROM insurance
WHERE region LIKE "%south%";

-- 7. No of patient having normal blood pressure. Normal range[90-120]
SELECT COUNT(DISTINCT PatientID)
FROM insurance
WHERE bloodpressure BETWEEN 90 AND 120;

-- 8. No of pateint belo 17 years of age having normal blood pressure as per below formula -
--     - BP normal range = 80+(age in years × 2) to 100 + (age in years × 2)

--     - Note: Formula taken just for practice, don't take in real sense.

SELECT COUNT(PatientID)
FROM insurance
WHERE age < 17 and
bloodpressure BETWEEN age*2 + 80 AND age*2 + 100;

-- 9. What is the average claim amount for non-smoking female patients who are diabetic?
SELECT AVG(claim)
FROM insurance
WHERE 
smoker = "No" AND gender = "female" AND diabetic = "Yes";

-- 10. Write a SQL query to update the claim amount for the patient with PatientID = 1234 to 5000.
UPDATE insurance
SET claim = 5000
WHERE PatientID = 1234;
-- CHECKING THE UPDATE QUERY WORKS CORRECTLY
SELECT *
FROM insurance
WHERE PatientID = 1234;

-- 11. Write a SQL query to delete all records for patients who are smokers and have no children.
DELETE FROM insurance
WHERE smoker = "Yes" and children = 0;