----------------------------------------------------------------------------------------

-- Sub queries
-- Intro
-- Find out the employees salary greater than the salary of employee id 145.
SELECT salary FROM employees
WHERE employee_id = 145;

SELECT * FROM employees
WHERE salary > 14000;

-- Inner query runs first
-- Based on the result of inner query, the outer query fetches the results
-- Sub queries are enclosed with parenthesis
-- Sub queries can be used with the SELECT, WHERE, HAVING and FROM clauses
-- 3 types : 1 - single row, 2 - multiple row, 3 - multiple-column
-- Group functions can be used 
-- Can be used with where clause comparision operators
SELECT * FROM employees
WHERE salary > (
SELECT salary FROM employees
WHERE employee_id = 145);

---------------------------------1 - Single row subquery--------------------------------
----------------------------------------------------------------------------------------
-- Query out all the employees who work in same department as the employee 145
SELECT department_id FROM employees 
WHERE employee_id = 145; 

SELECT * FROM employees 
WHERE department_id = 80;

-- subquery for the about 2 queries
-- This is single row subquery because the subquery returns only single row & column or value.
SELECT * FROM employees 
WHERE department_id = (SELECT department_id FROM employees 
WHERE employee_id = 145);

----------------------------------------------------------------------------------------

-- Find the employees who work in same department as the employee John (145) and earns less than him.
SELECT department_id FROM employees
WHERE employee_id = 145;

SELECT * FROM employees
WHERE department_id = 80;

SELECT salary FROM employees
WHERE employee_id = 145;

-- Sub query
SELECT * FROM employees
WHERE department_id = (SELECT department_id FROM employees
WHERE employee_id = 145) AND salary < (SELECT salary FROM employees
WHERE employee_id = 145);

----------------------------------------------------------------------------------------

-- Find the employee who were hired first
SELECT MIN(hire_date) FROM employees;

SELECT * FROM employees WHERE hire_date='13-JAN-01';

SELECT * FROM employees 
WHERE hire_date = (SELECT MIN(hire_date) FROM employees);

----------------------------------------------------------------------------------------

-- Find the employees who were hired recently
SELECT * FROM employees 
WHERE hire_date = (SELECT MAX(hire_date) FROM employees);


--------------------------------2 - Multiple row subquery-------------------------------
----------------------------------------------------------------------------------------
-- Can be used in FROM, WHERE, HAVING clause

SELECT first_name, last_name, salary FROM employees
WHERE salary IN (10000, 14000, 15000);

SELECT MIN(salary) FROM employees
GROUP BY department_id;

SELECT first_name, last_name, salary, department_id FROM employees
WHERE salary IN (SELECT MIN(salary) FROM employees
GROUP BY department_id);

SELECT first_name, last_name, salary, department_id FROM employees
WHERE salary > ANY (SELECT salary FROM employees
WHERE job_id='SA_MAN');

SELECT first_name, last_name, salary, department_id FROM employees
WHERE salary > ALL (SELECT salary FROM employees
WHERE job_id='SA_MAN');

SELECT * FROM departments;

SELECT first_name, last_name, salary, department_id FROM employees
WHERE department_id = ANY -- IN OR = ANY is same
       (SELECT department_id FROM departments 
        WHERE location_id IN 
                (SELECT location_id FROM locations
                WHERE country_id IN 
                        (SELECT country_id FROM countries 
                        WHERE country_name='United Kingdom'
                        )
                 )
        );

------------------------------3 - Multiple column subquery------------------------------
----------------------------------------------------------------------------------------
-- Two types -
-- Non pairwise comparision
-- Pairwise comparision

-- Can be used in FROM, WHERE, HAVING
-- Usually used with IN and NOT IN

-- Non pairwise comparision
SELECT employee_id, first_name, last_name, department_id, salary
FROM employees
WHERE department_id IN 
        (SELECT department_id FROM employees
         WHERE employee_id IN (103, 105, 110))
AND salary IN 
        (SELECT salary FROM employees
         WHERE employee_id IN (103, 105, 110));

-- Know the difference between the up and down query

-- Pairwise comparision
SELECT employee_id, first_name, last_name, department_id, salary
FROM employees
WHERE (salary, department_id) IN 
         (SELECT salary, department_id FROM employees
         WHERE employee_id IN (103, 105, 110));

------------------------------Using subqueries as a table-------------------------------
----------------------------------------------------------------------------------------




