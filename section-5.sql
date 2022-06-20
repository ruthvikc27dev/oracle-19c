----------------------------------------------------------------------------------------
-- SECTION 4
SELECT * FROM employees;

----------------------------------------------------------------------------------------

-- ORDER BY (must always come at the end of the statement)
-- Without any order
-- By default order is Ascending
-- Null values are displayed last by default in ascending order
SELECT * FROM employees;

SELECT first_name, last_name, salary FROM employees ORDER BY first_name;
SELECT first_name, last_name, salary FROM employees ORDER BY last_name;
SELECT first_name, last_name, salary FROM employees ORDER BY salary;

SELECT first_name, last_name, salary FROM employees ORDER BY 1;
SELECT first_name, last_name, salary FROM employees ORDER BY 2;
SELECT first_name, last_name, salary FROM employees ORDER BY 3;

SELECT first_name, last_name, salary FROM employees ORDER BY 3 DESC;

SELECT * FROM employees ORDER BY 2;

SELECT first_name, last_name, job_id, salary FROM employees ORDER BY first_name, last_name;
SELECT first_name, last_name, job_id, salary FROM employees ORDER BY first_name, job_id, salary;

SELECT first_name, last_name, job_id, salary FROM employees ORDER BY first_name DESC, last_name;

SELECT first_name, last_name as sur_name, job_id, salary FROM employees ORDER BY first_name DESC, sur_name;

----------------------------------------------------------------------------------------

--Change the behviour of NULLS FIRST and NULLS LAST for ASC and DESC
SELECT * FROM employees WHERE commission_pct IS NULL;
SELECT commission_pct FROM employees ORDER BY commission_pct;
SELECT commission_pct FROM employees ORDER BY commission_pct NULLS FIRST;
SELECT commission_pct FROM employees ORDER BY commission_pct DESC;
SELECT commission_pct FROM employees ORDER BY commission_pct DESC NULLS LAST;

----------------------------------------------------------------------------------------

-- Fastest way to access a row is by using rowid
-- Rowid is permanent
-- 16 digit hex
SELECT first_name, last_name, rowid FROM employees;
SELECT first_name, last_name, rowid FROM employees WHERE rowid='AAAR04AABAAAIN5AAe';
-- Rownum is a conseutive logical sequence number given to the rows fetched from the table
-- Same as the 1st column after executing a select query
-- Rownum is temporary
-- Can be used to limit the rows from the total rows fetched.
SELECT first_name, last_name, rownum FROM employees;
SELECT first_name, last_name, department_id, rownum FROM employees WHERE department_id='80';
SELECT first_name, last_name, department_id, rownum FROM employees WHERE department_id='80' AND rownum<=5;

----------------------------------------------------------------------------------------

-- This query first fetches records and then limit to first 5 records and then applies the order. Which is wrong
SELECT first_name, last_name, department_id, salary, rownum FROM employees WHERE department_id='80' AND rownum<=5 ORDER BY salary DESC;
-- Correct way to handle. This query first fetches all the records and orders them, after that it will fetch first 5 records
SELECT first_name, last_name, department_id, salary, rownum FROM 
(SELECT * FROM employees WHERE department_id='80' ORDER BY salary DESC) 
WHERE rownum<=5;

----------------------------------------------------------------------------------------

-- FETCH query
-- For with ties, to get additional rows, must use with order by
-- offset is optional when fetch is present
-- fetch is optional when offset is present
-- first and next can be interchangably used
-- row and rows can be interchangably used
-- the number in offset and fetch is null, no data is shown in output
SELECT first_name, last_name, salary FROM employees ORDER BY salary DESC;
SELECT first_name, last_name, salary FROM employees ORDER BY salary DESC 
OFFSET 2 ROWS 
FETCH FIRST 10 ROWS ONLY;
SELECT first_name, last_name, salary FROM employees 
ORDER BY salary DESC 
OFFSET 2 ROWS 
FETCH FIRST 10 ROWS WITH TIES;

----------------------------------------------------------------------------------------
