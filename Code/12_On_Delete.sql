-- ON DELETE SET NULL --
DELETE FROM employee
WHERE first_name='Michael' AND last_name='Scott';

SELECT * 
FROM branch;
-- mgr_id corresponding to Michael Scott is now NULL
--Because when the branch table was created, mgr_id was set as ON DELETE SET NULL

SELECT*
FROM employee;

-- ON DELETE SET CASCADE --
--Because of the way the branch_supplier table is created, if a branch_id is deleted,
--the whole row will be deleted. And on the other tables where the branch_id is present,
--it's defined as 2

DELETE FROM branch
WHERE branch_id = 2;

SELECT * FROM branch;


-- ON DELETE SET NULL: for foreign keys. Not neccesarilly essential for the table
-- ON DELETE SET CASCADE: for crucial columns. If the value disappears, the table makes no sense
--we need to delete the whole thing. If a foreign key is a primary or component of a primary key 
--on another table, always CASCADE