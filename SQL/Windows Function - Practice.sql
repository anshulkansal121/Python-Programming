
-- For the problems use the *Health Insurance Claim* dataset. You can get the details as well as the dataset from(https://www.kaggle.com/datasets/thedevastator/insurance-claim-analysis-demographic-and-health).
SELECT * FROM insurance;

-- What are the top 5 patients who claimed the highest insurance amounts?
SELECT *, 
ROW_NUMBER() OVER(ORDER BY claim DESC) FROM insurance
LIMIT 5;

-- What is the average insurance claimed by patients based on the number of children they have?
SELECT *,
AVG(claim) OVER(partition by children)
from insurance;

-- What is the highest and lowest claimed amount by patients in each region?

-- What is the percentage of smokers in each age group?

-- What is the difference between the claimed amount of each patient and the first claimed amount of that patient?

-- For each patient, calculate the difference between their claimed amount and the average claimed amount of patients with the same number of children.

-- Show the patient with the highest BMI in each region and their respective rank.

-- Calculate the difference between the claimed amount of each patient and the claimed amount of the patient who has the highest BMI in their region.

-- For each patient, calculate the difference in claim amount between the patient and the patient with the highest claim amount among patients with the same bmi and smoker status, within the same region. Return the result in descending order difference.

-- For each patient, find the maximum BMI value among their next three records (ordered by age).

-- For each patient, find the rolling average of the last 2 claims.

-- Find the first claimed insurance value for male and female patients, within each region order the data by patient age in ascending order, and only include patients who are non-diabetic and have a bmi value between 25 and 30.









