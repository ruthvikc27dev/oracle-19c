----------------------------------------------------------------------------------------

-- Substitution variable (multiple are supported)
-- works in sqlplus cmdline
-- For number
-- Can be used any where in the select statement
SELECT first_name, last_name, department_id FROM employees
WHERE department_id=&department_no;
-- For string, without quotes also works. Only for strings
SELECT first_name, last_name, department_id FROM employees
WHERE first_name='&first_name_value';

----------------------------------------------------------------------------------------

-- Double ampersand
-- The value entered is used until the current session is completed
SELECT first_name, last_name, salary FROM employees
WHERE salary BETWEEN &&sala AND &sala + 1000;
-- OR
SELECT first_name, last_name, salary FROM employees
WHERE salary BETWEEN &&sala AND &&sala + 2000;

----------------------------------------------------------------------------------------

-- define & undefine
-- def and undef can be used
DEFINE emp_num = 100;
SELECT * FROM employees WHERE employee_id=&emp_num;
-- OR
SELECT * FROM employees WHERE employee_id=&&emp_num;

UNDEFINE emp_num;
SELECT * FROM employees WHERE employee_id=&&emp_num;

-- To see all the substitution variables
DEFINE;

-- To print the substution varaible
DEFINE sal;

----------------------------------------------------------------------------------------

-- Accept / prompt
ACCEPT emp_id PROMPT 'Enter a valid Employee ID - ';
SELECT first_name, last_name, employee_id, salary FROM employees WHERE employee_id=&emp_id;

ACCEPT min_salary PROMPT 'Please specify MINIMUM Salary : ';
ACCEPT max_salary PROMPT 'Please specify MAXIMUM Salary : ';
SELECT first_name, last_name, salary, employee_id FROM employees 
WHERE salary BETWEEN &min_salary AND &max_salary;

----------------------------------------------------------------------------------------
-- Verify ON and OFF
-- If verify is executed, it will stay until the session is executed
-- press RUN SCRIPT BUTTON or F5 to show the old and new status of the variable
SET VERIFY ON;
SELECT first_name, last_name, employee_id, salary FROM employees WHERE employee_id=&emp_id;

----------------------------------------------------------------------------------------
SET DEFINE OFF;
SELECT * FROM departments WHERE department_name='R&D';

----------------------------------------------------------------------------------------







