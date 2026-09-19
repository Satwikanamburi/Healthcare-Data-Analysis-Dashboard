-- =========================================================
-- PROJECT: Healthcare Data Analysis
-- TOOL: MySQL
-- DATASET: Healthcare Dataset (1,000 records)
-- PURPOSE: Analyze patient demographics, medical conditions,
--          admissions, billing, insurance, and hospital stays
-- =========================================================

-- =========================================================
-- 1. DATA VALIDATION
-- =========================================================

-- Check total number of patient records

SELECT COUNT(*) AS total_patients
FROM healthcare_data;


-- Check for missing values in important columns

SELECT
    SUM(patient_name IS NULL) AS missing_name,
    SUM(age IS NULL) AS missing_age,
    SUM(gender IS NULL) AS missing_gender,
    SUM(medical_condition IS NULL) AS missing_condition,
    SUM(date_of_admission IS NULL) AS missing_admission_date,
    SUM(hospital IS NULL) AS missing_hospital,
    SUM(insurance_provider IS NULL) AS missing_insurance,
    SUM(billing_amount IS NULL) AS missing_billing,
    SUM(admission_type IS NULL) AS missing_admission_type,
    SUM(discharge_date IS NULL) AS missing_discharge_date
FROM healthcare_data;

-- =========================================================
-- 2. PATIENT DEMOGRAPHICS
-- =========================================================

-- Gender distribution

SELECT
    gender,
    COUNT(*) AS patient_count
FROM healthcare_data
GROUP BY gender
ORDER BY patient_count DESC;


-- Overall age statistics

SELECT
    MIN(age) AS youngest_patient,
    MAX(age) AS oldest_patient,
    ROUND(AVG(age), 2) AS average_age
FROM healthcare_data;


-- Age group distribution

SELECT
    CASE
        WHEN age < 18 THEN 'Under 18'
        WHEN age BETWEEN 18 AND 30 THEN '18-30'
        WHEN age BETWEEN 31 AND 45 THEN '31-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS patient_count
FROM healthcare_data
GROUP BY age_group
ORDER BY patient_count DESC;

-- =========================================================
-- 3. MEDICAL CONDITION ANALYSIS
-- =========================================================

-- Patient count by medical condition

SELECT
    medical_condition,
    COUNT(*) AS patient_count
FROM healthcare_data
GROUP BY medical_condition
ORDER BY patient_count DESC;


-- Condition-wise age and billing analysis

SELECT
    medical_condition,
    COUNT(*) AS patient_count,
    ROUND(AVG(age), 2) AS average_age,
    ROUND(AVG(billing_amount), 2) AS average_billing
FROM healthcare_data
GROUP BY medical_condition
ORDER BY average_billing DESC;

-- =========================================================
-- 4. ADMISSION ANALYSIS
-- =========================================================

-- Patient count and average billing by admission type

SELECT
    admission_type,
    COUNT(*) AS patient_count,
    ROUND(AVG(billing_amount), 2) AS average_billing
FROM healthcare_data
GROUP BY admission_type
ORDER BY patient_count DESC;

-- =========================================================
-- 5. INSURANCE PROVIDER ANALYSIS
-- =========================================================

SELECT
    insurance_provider,
    COUNT(*) AS patient_count,
    ROUND(AVG(billing_amount), 2) AS average_billing,
    ROUND(SUM(billing_amount), 2) AS total_billing
FROM healthcare_data
GROUP BY insurance_provider
ORDER BY total_billing DESC;

-- =========================================================
-- 6. HOSPITAL ANALYSIS
-- =========================================================

-- Top 10 hospitals by patient count

SELECT
    hospital,
    COUNT(*) AS patient_count,
    ROUND(AVG(billing_amount), 2) AS average_billing
FROM healthcare_data
GROUP BY hospital
ORDER BY patient_count DESC
LIMIT 10;

-- =========================================================
-- 7. BILLING ANALYSIS & DATA QUALITY
-- =========================================================

-- Overall billing metrics

SELECT
    ROUND(SUM(billing_amount), 2) AS total_billing,
    ROUND(AVG(billing_amount), 2) AS average_billing,
    ROUND(MIN(billing_amount), 2) AS minimum_billing,
    ROUND(MAX(billing_amount), 2) AS maximum_billing
FROM healthcare_data;


-- Identify negative billing records

SELECT
    patient_name,
    medical_condition,
    billing_amount,
    admission_type,
    insurance_provider
FROM healthcare_data
WHERE billing_amount < 0
ORDER BY billing_amount;


-- Billing metrics after excluding negative values

SELECT
    ROUND(SUM(billing_amount), 2) AS total_billing,
    ROUND(AVG(billing_amount), 2) AS average_billing,
    ROUND(MIN(billing_amount), 2) AS minimum_billing,
    ROUND(MAX(billing_amount), 2) AS maximum_billing
FROM healthcare_data
WHERE billing_amount >= 0;

-- =========================================================
-- 8. HOSPITAL STAY ANALYSIS
-- =========================================================

-- Calculate hospital stay duration

SELECT
    patient_name,
    date_of_admission,
    discharge_date,
    DATEDIFF(discharge_date, date_of_admission) AS stay_days
FROM healthcare_data
ORDER BY stay_days DESC
LIMIT 10;


-- Average stay by medical condition

SELECT
    medical_condition,
    COUNT(*) AS patient_count,
    ROUND(
        AVG(DATEDIFF(discharge_date, date_of_admission)),
        2
    ) AS average_stay_days
FROM healthcare_data
GROUP BY medical_condition
ORDER BY average_stay_days DESC;


-- Compare average stay and average billing

SELECT
    medical_condition,
    ROUND(
        AVG(DATEDIFF(discharge_date, date_of_admission)),
        2
    ) AS average_stay_days,
    ROUND(AVG(billing_amount), 2) AS average_billing
FROM healthcare_data
WHERE billing_amount >= 0
GROUP BY medical_condition
ORDER BY average_stay_days DESC;

-- =========================================================
-- 9. ADVANCED SQL
-- =========================================================

-- CTE: Conditions above overall average billing

WITH condition_billing AS (
    SELECT
        medical_condition,
        ROUND(AVG(billing_amount), 2) AS average_billing
    FROM healthcare_data
    WHERE billing_amount >= 0
    GROUP BY medical_condition
)
SELECT
    medical_condition,
    average_billing
FROM condition_billing
WHERE average_billing > (
    SELECT AVG(billing_amount)
    FROM healthcare_data
    WHERE billing_amount >= 0
)
ORDER BY average_billing DESC;


-- Window Function: Rank conditions by average billing

WITH condition_billing AS (
    SELECT
        medical_condition,
        ROUND(AVG(billing_amount), 2) AS average_billing
    FROM healthcare_data
    WHERE billing_amount >= 0
    GROUP BY medical_condition
)
SELECT
    medical_condition,
    average_billing,
    RANK() OVER (ORDER BY average_billing DESC) AS billing_rank
FROM condition_billing
ORDER BY billing_rank;