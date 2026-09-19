# Healthcare Data Analysis & Dashboard

## Project Overview

This project analyzes healthcare data using MySQL, SQL, and Power BI to understand patient demographics, medical conditions, hospital admissions, billing, insurance providers, and hospital stay patterns.

The project focuses on data validation, SQL-based analysis, advanced SQL techniques, and interactive dashboard development.

## Objectives

- Validate healthcare data and identify data-quality issues
- Analyze patient demographics and medical conditions
- Examine admission types and insurance providers
- Analyze billing patterns
- Calculate hospital stay duration
- Apply advanced SQL techniques such as CTEs and window functions
- Build an interactive Power BI dashboard to communicate key findings

## Dataset

The dataset contains 1,000 healthcare records with information including:

- Patient demographics
- Age and gender
- Blood type
- Medical condition
- Date of admission
- Doctor and hospital
- Insurance provider
- Billing amount
- Admission type
- Discharge date
- Medication
- Test results

## Tools & Technologies

- **MySQL**
- **SQL**
- **Power BI**
- **DAX**
- **CSV**

## SQL Analysis

The SQL analysis includes:

### Data Validation
- Total patient record count
- Missing-value checks for important fields

### Patient Demographics
- Gender distribution
- Minimum, maximum, and average age
- Age-group analysis

### Medical Condition Analysis
- Patient count by medical condition
- Average age by condition
- Average billing by condition

### Admission Analysis
- Patient count by admission type
- Average billing by admission type

### Insurance Analysis
- Patient count by insurance provider
- Average billing
- Total billing

### Hospital Stay Analysis
- Hospital stay duration using `DATEDIFF()`
- Average stay by medical condition
- Comparison of average stay and average billing

### Advanced SQL
- Common Table Expressions (CTEs)
- `RANK()` window function
- Conditional filtering
- Aggregate functions
- `CASE` statements
- Date functions

## Data Quality Finding

The analysis identified two records with negative billing amounts.

These records were retained as a data-quality finding rather than being removed from the dataset. Separate analysis was performed after excluding negative billing values.

## Key Findings

- The dataset contains **1,000 patient records**.
- Male patients represent **52.5%** of the dataset and female patients represent **47.5%**.
- Patients aged **60+ represent 35.5%** of the dataset.
- **Asthma** had the highest average billing at approximately **$27.5K**.
- **Asthma** also had the longest average hospital stay at approximately **17.7 days**.
- Two records contained negative billing amounts and were identified for data-quality investigation.

## Power BI Dashboard

![Healthcare Analysis Dashboard](dashboard.png)

The Power BI dashboard includes:

- Total Patients KPI
- Average Age KPI
- Average Billing KPI
- Average Hospital Stay KPI
- Patient Admissions Trend
- Patients by Gender
- Patients by Medical Condition
- Patients by Admission Type
- Patients by Insurance Provider
- Average Billing by Medical Condition
- Interactive filters for:
  - Gender
  - Medical Condition
  - Admission Type

