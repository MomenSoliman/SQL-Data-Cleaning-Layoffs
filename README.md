# 🧹 SQL Data Cleaning Project: Global Layoffs

## 📌 Project Overview
This project focuses on cleaning and preparing a raw dataset of global corporate layoffs using **MySQL**. Raw data is rarely ready for immediate analysis, so the goal of this project was to transform messy, unstandardized data into a reliable format. 

This is **Part 1** of a broader data project. The cleaned dataset from this phase will be used in **Part 2: Exploratory Data Analysis (EDA)**, which is currently in progress.

## 🛠️ Tools Used
* **Database Management System:** MySQL
* **Concepts Applied:** Common Table Expressions (CTEs), Window Functions (`ROW_NUMBER()`), Data Type Conversions, String Manipulation, Self-Joins.

## 🗂️ The Dataset
* **Source File:** `layoffs.csv` (Available in the `dataset/` folder)
* **Description:** The dataset contains information about company layoffs globally, including company names, locations, industries, total laid off, and funding stages.

## ⚙️ Data Cleaning Process
The cleaning process was executed in four main phases (view the full code in `scripts/1_data_cleaning.sql`):

### 1. Removing Duplicates
* Created a staging table to keep the raw data intact.
* Utilized **CTEs** and the `ROW_NUMBER() OVER()` window function partitioned by all columns to identify exact duplicate rows.
* Safely deleted the identified duplicate records.

### 2. Standardizing the Data
* Trimmed whitespace from text columns to ensure consistency.
* Corrected inconsistent naming conventions within the `industry` and `country` columns.
* Converted the `date` column from a text string format to a standard SQL `DATE` format using the `STR_TO_DATE()` function.

### 3. Handling Null and Blank Values
* Identified rows with missing or blank `industry` values.
* Used a **Self-Join** on the table to populate missing `industry` data by matching the company name and location with other rows where the industry was known.
* Left strategic nulls (like `total_laid_off` and `percentage_laid_off`) intact where no reference data existed, rather than filling them with inaccurate dummy data.

### 4. Removing Unnecessary Columns & Rows
* Filtered out rows where both `total_laid_off` and `percentage_laid_off` were null, as they provided no value for the upcoming layoff analysis.
* Dropped utility columns (like `row_num`) that were only needed during the deduplication phase using the `ALTER TABLE` statement.

## 🚀 Next Steps
With the dataset now cleaned, standardized, and structured, the next step is to uncover trends and insights. 

Stay tuned for **Exploratory Data Analysis (EDA)**, where I will dive deep into this cleaned dataset to understand the timelines, impacted industries, and global trends of these layoffs!
