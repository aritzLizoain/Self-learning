-- Find names of all employees who have sold over 30,000 to a single client

--MY WAY WITH PREVIOUS KNOWLEDGE
SELECT employee.emp_id, works_with.total_sales, employee.first_name, employee.last_name
FROM employee
JOIN works_with
ON employee.emp_id = works_with.emp_id
WHERE works_with.total_sales > 30000;

--NESTED QUERIES WAY
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
    SELECT works_with.emp_id
    FROM works_with
    WHERE works_with.total_sales > 30000
);

--Find all clients who are handled by the branch that Michael Scott manages
--Assume you know Michael's ID (102)

SELECT client.client_name
FROM client
WHERE client.client_id IN(
    SELECT works_with.client_id
    FROM works_with
    WHERE works_with.emp_id = 102
);

--His way (now it's not  "WHERE" + "IN" but "WHERE" + "=")
SELECT client.client_name
FROM client
WHERE client.branch_id = (
    SELECT branch.branch_id
    FROM branch
    WHERE branch.mgr_id = 102
    LIMIT 1
);
--Limit 1 just in case Michael is the manager of more than one branch

--Find all clients who are handled by the branch that Michael Scott manages
--Assume you DON'T know Michael's ID (my own creation)

SELECT client.client_name
FROM client
WHERE client.client_id IN(
    SELECT works_with.client_id
    FROM works_with
    WHERE works_with.emp_id IN (
        SELECT employee.emp_id
        FROM employee
        WHERE first_name = 'Michael'
    )
);

