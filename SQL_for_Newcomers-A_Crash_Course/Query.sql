-- Postgres

-- Browsing and Filtering Data

-- all colomns from a table
SELECT * FROM employees;

-- only selected colomns from a table
SELECT first_name, last_name FROM employees;

-- Select employees with base salary more than or equal to 5000
SELECT first_name, last_name, phone, base_salary
FROM employees
WHERE base_salary  >= 5000;

-- Select employees with base salary less than or equal to 5000
SELECT first_name, last_name, phone, base_salary
FROM employees
WHERE base_salary  <= 5000;

-- Select employees with base salary is not equal to 5000
SELECT first_name, last_name, phone, base_salary
FROM employees
WHERE base_salary  <> 5000;

-- Select employees with base salary between 1000-2000
SELECT first_name, last_name, phone, base_salary
FROM employees
WHERE base_salary BETWEEN 1000 AND 2000;

-- Select employees with salary bracket 1600, 2700 or 4200
SELECT first_name, last_name, phone, base_salary
FROM employees
WHERE base_salary = 1600 OR base_salary = 2700 OR base_salary = 4200;

SELECT first_name, last_name, phone, base_salary
FROM employees
WHERE base_salary IN (1600, 2700, 4200);

-- Select employee with last name 'Oles'
SELECT *
FROM employees
WHERE last_name = 'Oles';

-- Select Employees in Florida (FL) state
SELECT *
FROM employees
WHERE state = 'FL';

-- Select Employee with phone number 718-478-8504
SELECT *
FROM employees
WHERE phone = '718-478-8504';

-- Sorting, Alias Names, Limit Records

-- alias name
SELECT first_name || ' ' || last_name AS "Full name"
FROM employees;

-- Order records by Full name alphabetically
SELECT 
    id,
    first_name || ' ' || last_name AS "Full name",
    email || '@acme.com' AS Email_Address,
    job_title,
    base_salary + (base_salary * commission_pct) AS net_salary
FROM employees
ORDER BY "Full name";

-- Order employees by their net_salary from largest to smallest
SELECT 
    id,
    first_name || ' ' || last_name AS "Full name",
    email || '@acme.com' AS Email_Address,
    job_title,
    base_salary + (base_salary * commission_pct) AS net_salary
FROM employees
ORDER BY net_salary DESC;

-- Select employees from customer department, order by job title and net_salary
SELECT
    id,
    first_name || ' ' || last_name AS "Full name",
    email || '@acme.com' AS Email_Address,
    job_title,
    base_salary + (base_salary * commission_pct) AS net_salary
FROM employees
WHERE job_title LIKE '%Customer%'
ORDER BY job_title, net_salary;

-- limit, show 10 highest-paid employees
SELECT *
FROM employees
ORDER BY base_salary DESC
LIMIT 10;

-- NULL & DISTINCT

-- Employees without phone number
SELECT *
FROM employees
WHERE phone IS NULL OR phone = '';

-- Functions SUM, AVG, COUNT, MIN, MAX

-- Total base salary for all employees
SELECT SUM(base_salary)
FROM employees;

-- Total base salary for employees from New York
SELECT SUM(base_salary)
FROM employees
WHERE state = 'NY';

-- Average salary for all employees
SELECT AVG(base_salary)
FROM employees;

-- Average and sum base salary for employees from New York
SELECT AVG(base_salary) AS avg_base_salary, SUM(base_salary) AS sum_base_salary
FROM employees
WHERE state = 'NY';

-- Count how many employees are in Colorado and Florida
SELECT COUNT(first_name)
FROM employees
WHERE state IN ('CO', 'FL');

-- How many employees do we have in every state
SELECT state, COUNT(*)
FROM employees
GROUP BY state
ORDER BY COUNT(*) DESC;

-- Hoe many employees do we have per state and job title
SELECT state, job_title, COUNT(*) AS count_all
FROM employees
GROUP BY state, job_title
ORDER BY count_all DESC, job_title, state;