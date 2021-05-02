--Find the number of employees
SELECT COUNT(emp_id)
FROM employee;

--Find the number of employees with supervisors
SELECT COUNT(super_id)
FROM employee;

--Find the number of female employees born after 1970
SELECT COUNT(emp_id)
FROM employee
WHERE sex = 'F' AND birth_day > '1970-01-01';

--Find the average of all employee's salaries
SELECT AVG(salary)
FROM employee;

--Find the average of all employee's that are males
SELECT AVG(salary)
FROM employee
WHERE sex = 'M';

--Find the sum of all employee's salaries
SELECT SUM(salary)
FROM employee;

--Find out how many males and females there are
---SELECT COUNT(emp_id)
---FROM employee
---WHERE sex = 'F';
SELECT COUNT(sex), sex
FROM employee
GROUP BY sex;

--Find the total sales of each salesman
SELECT emp_id, SUM(total_sales)
FROM works_with
GROUP BY emp_id;

--Find the total spend of each client
SELECT client_id, SUM(total_sales)
FROM works_with
GROUP BY client_id
ORDER BY SUM(total_sales) DESC;