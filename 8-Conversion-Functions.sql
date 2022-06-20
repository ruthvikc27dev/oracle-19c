
-- Conversation functions
-- Two types of conversions
-- Implicit Data type conversion  - Oracle server automatically converts some datatype to the required one, it is recommended to use explicit functions to ensure reliability  of SQL statements
-- Explicit Data type conversion  - Explicit data type conversions are done using the conversion functions explicitly

-- Implicit data type conversion -
-- A CHAR or VARCHAR2 value is converted to a NUMBER or a DATE by oracle server automatically
-- Similarly a NUMBER or a DATE value is converted to a CHAR or VARCHAR2 by oracle server automatically
-- The implicit conversion are performed only if the characters match with NUMBER or a DATE

-- Comparing NUMBER with a VARCHAR value
SELECT * FROM employees WHERE salary > '5000';
-- Comparing DATE with a VARCHAR2 value
SELECT * FROM employees WHERE hire_date = '17-JUN-03';
-- Converting the NUMBER department_id to VARCHAR2 value
SELECT department_id || ' ' || department_name FROM departments;
-- Converting the DATE to VARCHAR2 value
SELECT first_name || ' ' || SYSDATE FROM employees;

-- Explicit Data type conversion
-- 3 functions -
-- TO_CHAR
-- TO_NUMBER
-- TO_DATE

-- TO_CHAR
-- 1st parameter - input value NUMERIC or DATE
-- 2nd parameter - Output format  (There are many date format models and NUMBER format models)
-- 3rd parameter - NFS
SELECT TO_CHAR(hire_date, 'YYYY') FROM employees;
SELECT TO_CHAR(salary, '$99,999.99') FROM employees;


