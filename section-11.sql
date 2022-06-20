-- Group By
-- Aliases cannot be used in this
-- The column which are not present in GROUP BY, cannot be used in ORDER BY (except for grouping functions)
-- The columns in GROUP BY can be present or not in SELECT but vice versa is not true

-- Calculate avg salary for all the employees whose job_id is IT_PROG
SELECT AVG(salary) FROM employees
WHERE job_id = 'IT_PROG' OR job_id = 'SA_REP';

SELECT job_id, AVG(salary), COUNT(*) FROM employees
GROUP BY job_id
ORDER BY COUNT(*) DESC;

SELECT job_id, department_id, COUNT(*) FROM employees
GROUP BY job_id, department_id
ORDER BY COUNT(*) DESC;

SELECT department_id, COUNT(*) FROM employees
GROUP BY job_id, department_id
ORDER BY COUNT(*) DESC;

SELECT AVG(salary) FROM employees
GROUP BY job_id;

SELECT job_id, AVG(salary), COUNT(*) FROM employees
WHERE job_id IN ('ST_CLERK', 'PU_CLERK', 'SA_MAN')
GROUP BY job_id
ORDER BY COUNT(*) DESC
OFFSET 1 ROW;

-- Order of execution of clauses (V1)
-- FROM
-- WHERE
-- GROUP BY
-- HAVING
-- SELECT   (THIS IS WHERE ALIASES ARE CREATED, THAT IS WHY THEY DON'T WORK IN GROUP BY)
-- ORDER BY

----------------------------------------------------------------------------------------
----------------------------------------HAVING------------------------------------------


SELECT job_id, AVG(salary) FROM employees
WHERE AVG(salary) > 10000
GROUP BY job_id;

-- Where clause filters rows
-- Wheras Having clause filters group data


-- Not preferred
SELECT job_id, AVG(salary) FROM employees
HAVING AVG(salary) > 10000
GROUP BY job_id;

-- Preferred
SELECT job_id, AVG(salary) FROM employees
GROUP BY job_id
HAVING AVG(salary) > 10000;


-- NESTED GROUP FUNCTIONS
SELECT department_id, AVG(salary) FROM employees
GROUP BY department_id;

-- Now get the max avg salary
-- In select, only nested aggregate functions can be present
-- Group by is must
-- Maximum depth allowd - 2
SELECT MAX(AVG(salary)), MIN(AVG(salary)) FROM employees
GROUP BY department_id;

-- Next: sub queries


