-- Grouping functions - Multiple Row functions - Aggregate functions
-- These functions ignore null values
-- DISTINCT & ALL keywords are used with the group function to consider the duplicate values
-- Char, Varchar2, Number & Date datatypes can be used
-- Group functions cannot be used in where clause
----------------------------------------------------------------------------------------
-----------------------------------------AVG--------------------------------------------
-- Only for numeric data
-- Can use null related funtions to replace null rows
-- ALL is default
-- There can be as many group functions but not individual column without group by.
SELECT AVG(salary), AVG(ALL(salary)), AVG(DISTINCT(salary)) FROM employees;
SELECT AVG(salary), AVG(ALL(salary)), AVG(DISTINCT(salary)) FROM employees 
WHERE job_id = 'IT_PROG';

SELECT AVG(commission_pct), AVG(nvl(commission_pct, 0)) FROM employees;

----------------------------------------------------------------------------------------
----------------------------------------COUNT-------------------------------------------
-- only COUNT(*) does not ignore null rows
-- You need to use the COUNT(ALL) function with a column like : COUNT(ALL first_name). And unlike the count(*) function, this one does NOT count the NULL values.
-- COUNT(column_name) ignore null rows
-- Can use null related funtions to replace null values
SELECT COUNT(*), COUNT(manager_id), COUNT(ALL manager_id), COUNT(DISTINCT manager_id) FROM employees;
SELECT COUNT(*), 
COUNT(commission_pct), 
COUNT(DISTINCT(commission_pct)), 
COUNT(NVL(commission_pct, 0)),
COUNT(DISTINCT(NVL(commission_pct, 0)))
FROM employees;

----------------------------------------------------------------------------------------
-----------------------------------------MAX--------------------------------------------
-- can be used with number, char and date types
-- DISTINCT or ALL is useless
-- Null values are ignored
-- Null related functions can be used
-- Char or varchar with max returns alphabetically higher order
SELECT MAX(salary), MAX(hire_date), MAX(first_name) FROM employees;

----------------------------------------------------------------------------------------
-----------------------------------------MIN--------------------------------------------
-- Similar as MAX

----------------------------------------------------------------------------------------
-----------------------------------------SUM--------------------------------------------
-- only for numeric data
-- NULLS are ignored
-- Null related functions can be used to handle null values
SELECT SUM(salary), SUM(DISTINCT(salary)) FROM employees;

----------------------------------------------------------------------------------------
---------------------------------------LISTAGG------------------------------------------
SELECT first_name FROM employees
WHERE job_id = 'ST_CLERK';

SELECT LISTAGG(first_name, ', ') employees FROM employees
WHERE job_id = 'ST_CLERK';

-- Order by first name
SELECT LISTAGG(first_name, ', ') 
WITHIN GROUP (ORDER BY first_name) AS "Employees" 
FROM employees
WHERE job_id = 'ST_CLERK';

-- Order by salary
SELECT LISTAGG(first_name, ', ') 
WITHIN GROUP (ORDER BY salary) AS "Employees" 
FROM employees
WHERE job_id = 'ST_CLERK';

-- Using distinct
SELECT LISTAGG(DISTINCT(salary), ' | ') 
WITHIN GROUP (ORDER BY first_name) AS "Employees" 
FROM employees
WHERE job_id = 'ST_CLERK';

SELECT * FROM locations;
SELECT LISTAGG(city, ', ') WITHIN GROUP (ORDER BY city) FROM locations 
WHERE country_id = 'US';

SELECT j.job_title,
LISTAGG (e.first_name, ', ') WITHIN GROUP (ORDER BY e.first_name) AS employee_list
FROM employees e, jobs j 
WHERE e.job_id = j.job_id
GROUP BY j.job_title;




