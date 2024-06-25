-- Exploratory Data analysis on layoffs_staging2

#1 Which companies had 1 in 'percentage_laid_off' (i.e 100 percent of the staff were laid off)
SELECT 
    *
FROM
    world_layoffs.layoffs_staging2
WHERE
    percentage_laid_off = 1;
-- it looks like they all went out of business during this time


#2 Now, let's check for the company in the united states that has the most funding but still went under leading to 100% layoff
SELECT 
    *
FROM
    layoffs_staging2
WHERE
    country = 'United States'
        AND percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;
-- We have Quibi in Los Angeles with as much as 1,800,000,000 raised.alter


#3 Next, let's see companies with high amount of layoffs but didn't go under or fold
SELECT 
    company, sum(total_laid_off)
FROM
    layoffs_staging2
WHERE
    percentage_laid_off < 1
        AND total_laid_off IS NOT NULL
GROUP BY company
ORDER BY 2 DESC;
-- Pheeeewww!!! Amazon with the largest number on this one


#4 Do we know the date range of the data we are working with?
-- let's find out
SELECT 
    MIN(`date`), MAX(`date`)
FROM
    layoffs_staging2;
-- Hmmm!! From "2020-03-11" to "2023-03-06". That' three years.
-- we can say that this is the effect of covid-19 on jobs

#5 Let's see the industry that's affected the most with these layoffs
SELECT 
	industry, sum(total_laid_off)
FROM
    layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;
-- Wow! I hope you've learned some tech skills?
-- It seems like the manufacturing and Fin-tech industry were least affected by the layoffs

-- More --

SELECT 
    company, total_laid_off
FROM
    world_layoffs.layoffs_staging
ORDER BY 2 DESC
LIMIT 5;
-- now that's just on a single day

SELECT 
    company, SUM(total_laid_off)
FROM
    world_layoffs.layoffs_staging2
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;



SELECT 
    location, SUM(total_laid_off)
FROM
    world_layoffs.layoffs_staging2
GROUP BY location
ORDER BY 2 DESC
LIMIT 10;

SELECT 
    country, SUM(total_laid_off)
FROM
    world_layoffs.layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT 
    YEAR(date), SUM(total_laid_off)
FROM
    world_layoffs.layoffs_staging2
GROUP BY YEAR(date)
ORDER BY 1 ASC;


SELECT 
    industry, SUM(total_laid_off)
FROM
    world_layoffs.layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;


SELECT 
    stage, SUM(total_laid_off)
FROM
    world_layoffs.layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- TOUGHER QUERIES------------------------------------------------------------------------------------------------------------------------------------

#10 Earlier we looked at Companies with the most Layoffs.
-- Now let's look at companies with the most Layoffs annually.

WITH Company_Year AS 
(
  SELECT company, YEAR(date) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging2
  GROUP BY company, YEAR(date)
)
, Company_Year_Rank AS (
  SELECT company, years, total_laid_off, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;

#11 Rolling Total of Layoffs Per Month
-- Here we used SUBSTRING(date, 1, 7) to select only the year and month of the date
-- 1 indicates where to start the selection on the field and 7 indicates how many content of the cell we need
SELECT 
    SUBSTRING(date, 1, 7) AS MONTH,
    SUM(total_laid_off) AS total_laid_off
FROM
    layoffs_staging2
    WHERE SUBSTRING(date, 1, 7) IS NOT NULL -- here, we didn't use the alias bcos it cannot work due to order of execution
GROUP BY MONTH
ORDER BY MONTH ASC;

-- now use it in a CTE so we can query off of it
WITH DATE_CTE AS 
(
SELECT 
    SUBSTRING(date, 1, 7) AS `MONTH`,
    SUM(total_laid_off) AS total_laid_off
FROM
    layoffs_staging2
    WHERE SUBSTRING(date, 1, 7) IS NOT NULL -- here, we didn't use the alias `MONTH` bcos it cannot work due to order of execution
GROUP BY `MONTH`
ORDER BY `MONTH` ASC
)
SELECT `MONTH`, total_laid_off, SUM(total_laid_off) OVER (ORDER BY `MONTH` ASC) as rolling_total_layoffs
FROM DATE_CTE
ORDER BY `MONTH` ASC;