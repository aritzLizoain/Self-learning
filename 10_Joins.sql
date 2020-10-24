INSERT INTO branch VALUES (4, 'Buffalo', NULL, NULL);

-- 4 TYPES OF JOINS

-- INNER JOIN
SELECT branch.mgr_id AS 'manager id', employee.first_name, branch.branch_name
FROM employee
JOIN branch
ON employee.emp_id = branch.mgr_id;

-- LEFT JOIN (include all rown from the employee table)
SELECT branch.mgr_id AS 'manager id', employee.first_name, branch.branch_name
FROM employee
LEFT JOIN branch
ON employee.emp_id = branch.mgr_id; 

-- RIGHT JOIN (include all rows from the branch table)
SELECT branch.mgr_id AS 'manager id', employee.first_name, branch.branch_name
FROM employee
RIGHT JOIN branch
ON employee.emp_id = branch.mgr_id; 

-- FULL OUTER JOIN (takes all rows from both tables, no matter they have a match or not)