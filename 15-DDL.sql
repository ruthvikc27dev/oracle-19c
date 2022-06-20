-- Data defination language- 
-- DDL contains commands like CREATE, ALTER and ANALYZE which are used to CREATE TABLEs, view stored subprograms and packages in a database schema.
-- A table name cannot exceed more than 30 characters.
-- Unquoted objects names are not case-senstive in Oracle

-- CREATE
-- ALTER
-- DROP
-- TRUNCATE -- Cannot be rolled back
-- COMMENT
-- RENAME

-- DDL COMMANDS ARE ALWAYS AUTO COMMITED
-- WHEREAS INSERT, UPDATE AND DELETE (need to manually commit)

----------------------------------NAMING CONVENTIONS------------------------------------
----------------------------------------------------------------------------------------
-- TABLES
-- Table names must be always plural
-- If there are more than 2 words then they should be separated by '_'
-- Aliases or short forms can be used (but should be careful)
-- 128 characters at most

-- COLUMNS
-- Column names must be always singular
-- If there are more than 2 words then they should be separated by '_'
-- Column name should include alias of the related table underscore the table name
-- The primary key column name must always end with "_id"
-- The logical alias of both the columns must be used while naming the foreign key column
-- 128 characters at most

---------------------------------------CREATE-------------------------------------------
----------------------------------------------------------------------------------------

-- If for the same user, don't need to provide schema name down
CREATE TABLE ruthvikc27.my_employees(
      employee_id NUMBER(3)   NOT NULL, 
      first_name VARCHAR(50)  DEFAULT 'No Name',
      last_name VARCHAR(50),
      hire_date DATE          DEFAULT sysdate NOT NULL
);

SELECT * FROM my_employees;

DESC my_employees;

INFO my_employees;

-- Creating table with data from another table
-- For CTS, only NOT NULL contraints are inherited
CREATE TABLE employees AS SELECT * FROM my_employees;

-- Creating structure of a table from another table
CREATE TABLE employees AS (SELECT * FROM hr.employees WHERE 1=2);

-- Columns must be equal or else error
CREATE TABLE employees(fname, lname, mail) AS SELECT first_name, last_name, email FROM hr.employees;

CREATE TABLE employees AS SELECT * FROM hr.employees;

DESC employees;
DESC hr.employees;

INFO employees;
INFO hr.employees;

SELECT * FROM employees;
DROP TABLE employees;

---------------------------------------ALTER-------------------------------------------
----------------------------------------------------------------------------------------

DROP TABLE my_employees;
--CREATE TABLE my_employees(
--      employee_id NUMBER(3)   NOT NULL, 
--      first_name VARCHAR2(50)  DEFAULT 'No Name',
--      last_name VARCHAR2(50),
--      hire_date DATE          DEFAULT sysdate NOT NULL
--);

CREATE TABLE my_employees AS SELECT * FROM hr.employees;

-- Adding a column to existing table my_employees
ALTER TABLE my_employees ADD ssn VARCHAR2(11);
SELECT * FROM my_employees;

-- If the rows are already present, the default value is added to those rows
-- This is not true for adding default to existing column
ALTER TABLE my_employees ADD (
       fax_id VARCHAR2(11),
       date_of_birth DATE,
       password VARCHAR2(11) DEFAULT '_Abc@123'
);
SELECT * FROM my_employees;

-- MODIFY
ALTER TABLE my_employees MODIFY password VARCHAR2(50);
-- It will preserve the existing data
-- You cannot remove default value completely
-- To remove default value, modify default value to null
ALTER TABLE my_employees MODIFY (
       fax_id VARCHAR2(11) DEFAULT '-',
       password VARCHAR(10) 
);
SELECT * FROM my_employees;
DESC my_employees;

-- DROP
-- Cannot be recovered easily
ALTER TABLE my_employees DROP COLUMN fax_id;
ALTER TABLE my_employees DROP (password, date_of_birth);
SELECT * FROM my_employees;

---------------------------------------SET UNUSED---------------------------------------
----------------------------------------------------------------------------------------
-- these columns will no longer be available
-- Logically they are deleted, physically will present until they are dropped.
-- New columns can be created by the unused column names
-- **Cannot be reused**
-- **This command is only for user interaction.**
ALTER TABLE my_employees SET UNUSED COLUMN ssn;
ALTER TABLE my_employees SET UNUSED (first_name, last_name);
ALTER TABLE my_employees DROP UNUSED COLUMNS;
SELECT * FROM my_employees;

SELECT * FROM user_unused_col_tabs; 

-- Can enable DML operations on unused columns until this query is processing by specifing "ONLINE" at the end of the alter statement
-- except this, everything is sames like without online
ALTER TABLE my_employees SET UNUSED (manager_id) ONLINE;
SELECT * FROM my_employees;
DESC my_employees;

---------------------------------READ ONLY TABLES---------------------------------------
----------------------------------------------------------------------------------------
-- DML operations won't work and certain DDL operations won't work
ALTER TABLE my_employees READ ONLY;

DELETE my_employees;

-- Altering
ALTER TABLE my_employees ADD first_name VARCHAR(55) DEFAULT '-' NOT NULL;

-- Not altering
ALTER TABLE my_employees DROP COLUMN first_name;
SELECT * FROM my_employees;

-- Dropping
DROP TABLE my_employees;

ALTER TABLE my_employees READ WRITE;

-------------------------------------------DROP-----------------------------------------
----------------------------------------------------------------------------------------
SELECT * FROM my_employees;
CREATE TABLE my_employees AS SELECT * FROM hr.employees;

-- Removes all the data and move to recycle bin
-- After droping the table, all the other objects will be deleted or become invalid
-- can be revocered from recycle bin but not guaranteed
DROP TABLE my_employees;

-- Not working for rhel (developers may not have previliges)
FLASHBACK TABLE my_employees TO BEFORE DROP;

-- Delete from recycle bin also
DROP TABLE my_employees purge;


----------------------------------------TRUNCATE----------------------------------------
----------------------------------------------------------------------------------------
-- DELETE command deletes row by row
-- Can be rolled back
DELETE FROM my_employees;

-- Whereas TRUNCATE deletes all rows more quickly
-- auto commit, no rollback
-- Truncate does not store undo information or log data, so it cannot restore the data
-- Only the creater of this table has this privilege
-- Or need to have "DROP ANY TABLE" privilege
TRUNCATE my_employees;

----------------------------------------COMMENT-----------------------------------------
----------------------------------------------------------------------------------------

INFO my_employees;

COMMENT ON COLUMN my_employees.job_id IS 'This column store abbreviations of job title.';

COMMENT ON TABLE my_employees IS 'This column stores information about employees';

-- We cannot directly drop a comment but can create new comment with empty text
COMMENT ON COLUMN my_employees.job_id IS '';

SELECT * FROM user_tab_comments;

SELECT * FROM user_col_comments;

----------------------------------------RENAME------------------------------------------
----------------------------------------------------------------------------------------

-- Should manage dependencies like views, indexes etc before renaming a column
-- Previleges needed

SELECT * FROM my_employees;

DESC my_employees;

ALTER TABLE my_employees RENAME COLUMN hire_date to start_date;

RENAME my_employees TO employees;
ALTER TABLE employees RENAME TO my_employees;


----------------------------------------------------------------------------------------
