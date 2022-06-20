-- Single Row Functions
-- Can be used in select, where, order by clauses

-- Five types of single row functions (Logically)
-- Character  - Accept character values, but can return character or numeric values
-- Numeric    - Accept number data and returns the same
-- Date       - Operates on values of date data types
-- General    - Used to convert one data type to another
-- Conversion - These functions can take any data type. But mainly used to handle null values

-------------------------------------------------------------------------------------------
-----------------------------------Character functions-------------------------------------
-- Character functions
-- Two types :
-- 1. Case conversion functions
-- 2. Character manipulation functions

-- Case conversion functions
-- Three Types :
-- UPPER
-- LOWER
-- INITCAP
SELECT * FROM employees;
-- In SELECT clause
SELECT UPPER(first_name), INITCAP(last_name), LOWER(email) FROM employees;
-- In WHERE clause
SELECT * FROM employees WHERE LOWER(last_name)='king';
SELECT * FROM employees WHERE UPPER(last_name)='KING';
SELECT * FROM employees WHERE INITCAP(last_name)='King';
-- In ORDER BY clause
SELECT UPPER(first_name), last_name FROM employees 
ORDER BY UPPER(first_name), last_name DESC
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY;

-- Character manipulation functions
-- Seven types :
-- SUBSTR
-- LENGTH
-- CONCAT
-- INSTR
-- TRIM
-- REPLACE
-- LPAD or RPAD

-- NOTE - Indexes start from 0 in oracle db

-- SUBSTR
-- If the position specified is greater than the length of string itself then it will return null
SELECT first_name, SUBSTR(first_name, 3), SUBSTR(first_name, 2, 3) FROM employees;

-- LENGTH
-- If the value of a cell is NULL then the length value will return NULL
SELECT first_name, LENGTH(first_name), commission_pct, LENGTH(commission_pct) FROM employees;

-- CONCAT
-- RECOMMENDED
SELECT first_name || last_name FROM employees;
-- For CONCAT, more than two strings are not allowed
SELECT CONCAT(first_name || ' ', last_name) FROM employees;
SELECT CONCAT(CONCAT(first_name, last_name), email) FROM employees;

-- INSTR
SELECT INSTR('VANAM RUTHVIK CHANDRA', 'H') FROM dual;
-- SEARCH STARTS FROM LEFT AND AT INDEX 4
SELECT INSTR('VANAM RUTHVIK CHANDRA', 'H', 4) FROM dual;
-- SEARCH STARTS FROM LEFT AND AT INDEX 4 AND GET THE 2ND OCCURRANCE
-- IF THERE IS NO NTH OCCURRANCE THEN RETURNS 0 
SELECT INSTR('VANAM RUTHVIK CHANDRA', 'H', 4, 2) FROM dual;
-- SEARCH STARTS FROM LAST LETTER(-1) AND RIGHT
SELECT INSTR('VANAM RUTHVIK CHANDRA', 'H', -1) FROM dual;

--TRIM
-- By default spaces are trimmed
SELECT TRIM('  My name is Ruthvik  ') trimmed_text FROM dual;

-- Both are same
-- The trim string must only contain single character
SELECT TRIM( ' ' FROM '  My name is Ruthvik  ') trimmed_text FROM dual;
SELECT TRIM( BOTH ' ' FROM '  My name is Ruthvik  ') trimmed_text FROM dual;

-- Removes all the ' ' from beginning to text starting, does not remove ' ' after the text
SELECT TRIM( LEADING ' ' FROM '  My name is Ruthvik  ') trimmed_text FROM dual;

-- Removes all the ' ' from ending to text ending, does not remove ' ' before the text
SELECT TRIM( TRAILING ' ' FROM '  My name is Ruthvik  ') trimmed_text FROM dual;

-- Replacing ' ' with 'x'
SELECT TRIM( BOTH 'x' FROM 'xxMy name is Ruthvikxx') trimmed_text FROM dual;
SELECT TRIM( LEADING 'x' FROM 'xxMy name is Ruthvikxx') trimmed_text FROM dual;
SELECT TRIM( TRAILING 'x' FROM 'xxMy name is Ruthvikxx') trimmed_text FROM dual;

-- In built functions for trim for either left or right
-- To solve the problem with multiple letters, these functions were introduced
-- By default spaces are trimmed
SELECT LTRIM('    My name is Ruthvikxxx') l_trimmed_text FROM dual;
SELECT LTRIM('xxxMy name is Ruthvikxxx', 'x') l_trimmed_text FROM dual;
SELECT LTRIM('xxxMy name is Ruthvikxxx', 'xM') l_trimmed_text FROM dual;

SELECT RTRIM('My name is Ruthvik   ') r_trimmed_text FROM dual;
SELECT RTRIM('xxxMy name is Ruthvikxxx', 'x') r_trimmed_text FROM dual;
SELECT RTRIM('xxxMy name is Ruthvikxxx', 'xk') r_trimmed_text FROM dual;

-- Trimming web URL
-- Need to be careful
SELECT RTRIM(LTRIM('www.petdunia.com', 'w.'), '.moc') website FROM dual;

-- Regular expressions can be used, not explained, check advanced sql course
SELECT RTRIM('12312131231231213My name is Ruthvikxxx') r_trimmed_text FROM dual;

-- REPLACE
SELECT ('My Name is Ruthvik') FROM dual;
SELECT REPLACE('My Name is Ruthvik', 'Ruthvik', 'Vanam Ruthvik Chandra') FROM dual;

-- If replacement string is not given then it will remove the replace string
SELECT first_name, REPLACE(first_name, 'a') FROM employees;
SELECT first_name, REPLACE(first_name, 'a', '-') FROM employees;

-- LPAD
-- Second argument is character length
SELECT last_name, LPAD(last_name, 10, '*') FROM employees;
SELECT last_name, RPAD(last_name, 10, '*') FROM employees;

-------------------------------------------------------------------------------------------
-------------------------------------Numeric functions-------------------------------------

-- ROUND
-- TRUNC
-- CEIL
-- FLOOR
-- MOD

-- ROUND
SELECT ROUND(12.351) FROM dual;
SELECT ROUND(12.351, 1) FROM dual;
SELECT ROUND(12.351, 2) FROM dual;
SELECT ROUND(12.351, -1) FROM dual;

-- TRUNC
SELECT TRUNC(12.351) FROM dual;
SELECT TRUNC(12.351, 2) FROM dual;
SELECT TRUNC(12.351, -1) FROM dual;

-- CEIL
SELECT CEIL(12.001) FROM dual;

-- FLOOR
SELECT FLOOR(12.9) FROM dual;

-- MOD
SELECT MOD(9, 2) FROM dual;

-- More numeric functions - https://docs.oracle.com/cd/E49933_01/server.770/es_eql/src/ceql_functions_numeric.html

-------------------------------------------------------------------------------------------
-------------------------------------DATE Functions----------------------------------------

-- Dates are stored in special format (changes frequently)
-- Tools -> Preferences -> Database -> NLS -> Date Format

SELECT hire_date FROM employees;

-- DD   - Day
-- MON  - Month
-- RR   - Last 2 digits of a year (complicated)
-- YYYY - Year
-- YY   - Last 2 digits of a year (if 2012, then 12)
-- HH   - Hour
-- HH24 - Hour 24 format
-- Mi   - Minute
-- SS   - Seconds
-- X    - Separator
-- FF   - Fractional seconds
-- AM   - Morning
-- PM   - Evening

-- DATE Datatype
-- TIMESTAMP Datatype : This datatype stores Year, Month, Day, Hour. Minute, Seconds and also Fractional Seconds
-- TIMESTAMP WITH ZONE : Same as TIMESTAMP but also stores ZONE
-- TIMESTAMP WITH LOCAL TIME ZONE : This is same as TIMESTAMP WITH ZONE but the stored timezone is the database's timezone.

-- DATE Functions
-- SYSDATE         : returns the current DATE and TIME of the OS where the database is installed.
-- CURRENT_DATE    : returns the current DATE and TIME of the place WHERE the user's session is logged in from
-- SESSIONTIMEZONE : returns the timezone of user's session
-- SYSTIMESTAMP    : returns the date and time of the database

SELECT SYSDATE, SYSTIMESTAMP, CURRENT_DATE, CURRENT_TIMESTAMP, SESSIONTIMEZONE FROM dual;

-- ARITHMETIC Operations on DATE functions

-- INCREMENTS the SYSDATE with two days
SELECT SYSDATE, SYSDATE + 2 FROM dual;
-- INCREMENTS the SYSDATE with 1 hour
SELECT SYSDATE, SYSDATE + (1/24) FROM dual;
-- INCREMENTS the SYSDATE with 1 minute
SELECT SYSDATE, SYSDATE + 1/(24 * 60) FROM dual;
-- INCREMENTS the SYSDATE with 1 second
SELECT SYSDATE, SYSDATE + 1/(24 * 60 * 60) FROM dual;

SELECT employee_id, hire_date, SYSDATE from employees;
-- Get the number of days from hire_date to sysdate
SELECT employee_id, hire_date, SYSDATE, SYSDATE - hire_date no_of_days from employees;

-- Date functions
-- ADD_MONTHS
-- MONTHS_BETWEENN
-- ROUND
-- TRUNC
-- EXTRACT
-- NEXT_DAY
-- LAST_DAY

-- ADD_MONTHS
SELECT ADD_MONTHS('27Jul2021', 1) FROM dual;
SELECT ADD_MONTHS('27Jul2021', -1) FROM dual;

-- MONTHS_BETWEEN
SELECT MONTHS_BETWEEN('01-Aug2022', '27Jul2021') FROM dual;

-- ROUND & TRUNC
SELECT employee_id, hire_date, ROUND(hire_date, 'YEAR') ROUND_DATE, TRUNC(hire_date, 'YEAR') TRUNC_DATE FROM employees;

-- EXTRACT
SELECT EXTRACT(DAY FROM SYSDATE) FROM dual;
SELECT EXTRACT(MONTH FROM SYSDATE) FROM dual;
SELECT EXTRACT(YEAR FROM SYSDATE) FROM dual;

-- NEXT_DAY
SELECT NEXT_DAY(SYSDATE, 'FRIDAY') FROM dual;

-- LAST_DAY
SELECT LAST_DAY(SYSDATE) FROM dual;



