# Analysing the budget of films released in differrent years
-- In this exercise, we'll write a query that returns the average budget and gross earnings for films
-- each year after 1990 if the average budget is greater than 60 million.

-- Select the release_year for films released after 1990 grouped by year
SELECT 
    release_year
FROM
    films
WHERE release_year > 1990
GROUP BY release_year;

-- Now, let's modify the query to also list the average budget and average gross
SELECT 
    release_year,
    AVG(budget) AS avg_budget,
    AVG(gross) AS avg_gross
FROM
    films
WHERE
    release_year > 1990
GROUP BY release_year;

-- Further, let's modify the query to see only years with an avg_budget of more than 60 million
SELECT 
    release_year,
    AVG(budget) AS avg_budget,
    AVG(gross) AS avg_gross
FROM
    films
WHERE
    release_year > 1990
GROUP BY release_year
HAVING AVG(budget) > 60000000;

-- Finally, we'll order the results from highest to lowest average gross and limit to one
SELECT 
    release_year,
    AVG(budget) AS avg_budget,
    AVG(gross) AS avg_gross
FROM
    films
WHERE
    release_year > 1990
GROUP BY release_year
HAVING AVG(budget) > 60000000
ORDER BY AVG(gross) DESC
LIMIT 1;