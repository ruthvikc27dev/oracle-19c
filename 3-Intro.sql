----------------------------------------------------------------------------------------

-- info related tables
-- shift + f4 on table name- to display all info about a table
DESC employees;
INFO employees;

----------------------------------------------------------------------------------------

-- select statements
SELECT * FROM employees;
SELECT first_name, last_name, email FROM employees;

----------------------------------------------------------------------------------------

-- aliases (for readability)
SELECT first_name name, last_name surname, email FROM employees;
SELECT first_name AS name, last_name AS surname, email FROM employees;
SELECT first_name AS "First   Name", last_name AS "Last Name", email AS "E-Mail" FROM employees; -- can use special character within the quotes

----------------------------------------------------------------------------------------

-- qoute operator
SELECT * FROM dual; -- dummy table, used for selecting something when not actually intersted in the data but instead want to show some functions etc.
SELECT 'My Name is Ruthvik' FROM dual; -- dual table is only present in this DB
SELECT 'My Name is Ruthvik' AS "Output" FROM dual;
SELECT q'[My Name is Ruthvik]' AS "Output" FROM dual;  -- [], {}, (), <>, or even any characters 'A', '*'... [] is common
SELECT q'[My Name is 'Ruthvik']' AS "Output" FROM dual;
                   -- OR
SELECT 'My Name is ''Ruthvik''' AS "Output" FROM dual;

----------------------------------------------------------------------------------------

-- DISTINCT and UNIQUE operator (both are same)
SELECT job_id FROM employees;
SELECT DISTINCT job_id FROM employees;
SELECT DISTINCT(job_id) FROM employees;
SELECT UNIQUE job_id FROM employees; -- old syntax..non standard..not recommended
SELECT DISTINCT job_id, department_id FROM employees; -- Gets the unqiue rows of both job_id and department_id
SELECT DISTINCT job_id, department_id, first_name FROM employees; -- must be placed before the first column name and query must contain only 1 "DISTINCT" word

----------------------------------------------------------------------------------------

-- concatenation operators
SELECT 'My Name is Ruthvik' FROM employees;
SELECT 'My Name is ' || first_name FROM employees;
SELECT first_name || ' ' || last_name AS full_name FROM employees;
SELECT 'My commission percentage is ' || commission_pct FROM employees; -- concatinating with NULL does not return NULL but returns empty
SELECT * FROM locations;
SELECT street_address || ', ' || city || '-' || postal_code || ', ' || state_province || ', ' || country_id AS "Full Address" FROM locations;

----------------------------------------------------------------------------------------

-- arithmetic expressions
SELECT 1 + 1 FROM dual;
SELECT employee_id, salary, salary+100*12 AS "Annual Salary" FROM employees;
SELECT employee_id, salary, (salary+100) * 12 AS "Annual Salary" FROM employees;
      -- Arithmetic operation with date values return new date values
SELECT SYSDATE + 3 AS "3 Days From Now" FROM dual;   -- return the current date and time of the operating system
SELECT hire_date, hire_date + 30 FROM employees;
      -- Arithmetic operations with the NULL values return NULL
SELECT salary, commission_pct, salary * commission_pct FROM employees;

----------------------------------------------------------------------------------------
