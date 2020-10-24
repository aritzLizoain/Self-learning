--Find a list of employee and branch names (MODIFIED)
SELECT first_name AS first_column, last_name AS second_column
FROM employee
UNION
SELECT branch_name, mgr_id
FROM branch
UNION
SELECT client_id, client_name
FROM client;
--need to have the same number of columns
--need to have similar data type

--Find a list of all clients & branch suppliers' names
SELECT client_name AS 'client & branch suppliers names', client.branch_id
FROM client
UNION
SELECT branch_name, branch.branch_id
FROM branch
ORDER BY branch_id;
--table name before branch_id in order to make it clear

--Find a list of all money spent or earned by the company
SELECT (-1*salary) AS 'money movements'
FROM employee
UNION
SELECT total_sales
FROM works_with;