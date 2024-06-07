-- Pawnee Council sent out a memo for the bonus and pay increase structure of the employess.
-- In summary,  if they make less than 45k then they get a 5% raise
-- if they make more than 45k they get a 7% raise
-- they get a bonus of 10% if they work for the Finance Department

-- SOLUTION --

SELECT 
    dept_id,
    first_name,
    last_name,
    salary current_salary,
    CASE
        WHEN salary < 50000 THEN salary * 1.05
        WHEN salary > 55000 THEN salary * 1.07
    END raise
FROM
    employee_salary;

-- Now we need to also account for Bonuses, let's make a new column
SELECT 
    dept_id,
    first_name,
    last_name,
    salary current_salary,
    CASE
        WHEN salary < 45000 THEN salary * 1.05
        WHEN salary > 45000 THEN salary * 1.07
    END Raise,
    CASE
        WHEN dept_id = 6 THEN salary * 0.1
    END Bonus
FROM
    employee_salary;

-- as you can see Ben is the only one who get's a bonus