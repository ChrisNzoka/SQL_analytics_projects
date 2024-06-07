-- Data cleaning project

#1 create a new database(schema)
CREATE SCHEMA `world_layoffs`;

#2 Import data from the table tab by right clicking and selecting 'Table data import wizard'

#3 view the table
SELECT 
    *
FROM
    layoffs;
    
#4 Check for and remove duplicates


#5 Standardize the Data (spellings, typos, etc)


#6 Check for Null values and Blank cells (checking to see if we should populate it or leave it be)


#7 create a staging area for the data(a duplicate)

-- first we create the table
CREATE TABLE layoff_staging LIKE layoffs;

-- then we insert the contents of layoffs into the layoff_staging
INSERT layoff_staging
SELECT * FROM layoffs;

-- Now, let's check out the duplicate
SELECT 
    *
FROM
    layoff_staging;

#7 Remove irrelevant fields(columns) and records(rows)