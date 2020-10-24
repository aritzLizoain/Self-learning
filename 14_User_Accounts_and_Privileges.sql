-- To see databases
SHOW databases;

-- To see tables
SHOW tables;

-- To show users and host
SELECT user, host from mysql.user;

-- To create user
CREATE user 'bob'@'localhost' identified by '123456';

-- Look at bob's privileges
SHOW grants for bob@localhost;
-- Output: GRANT USAGE ON *.* TO `bob`@`localhost`
-- databases.tables --> *.* == all databases and all tables

-- My privileges
SHOW grants;
-- Output: ... WITH GRANT OPTIONS == I can give privileges

-- All privileges: https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html

-- Asign privileges to bob: select to all databases and all tables
grant select on *.* to bob@localhost;
 
 -- Deprive all privileges to bob
revoke all on *.* from bob@localhost;

-- Allow bob inserting records into the branch table of the girrafe database
grant insert on girrafe.branch to bob@localhost;

-- Allow bob updating things on the branch table. But we need to be careful.
-- we don't want bob to screw it up with the branch_id.
-- no reason to change the name either.
-- he will be able to update the manager id and the starting date of the manager

grant update(mgr_id, mgr_start_date) on girrafe.branch to bob@localhost;

-- Let's deprive bob from being able to insert anything
revoke insert on girrafe.branch from bob@localhost;

-- Give all privileges on the girrafe database to Sue (new user). She can even give privileges to other users.
create user 'sue'@'localhost' identified by '123456';
select user, host from mysql.user;
grant all privileges on *.* to sue@localhost;
-- Full control

-- Login as a different user (sue)
-- Windows CMD
--- cd \
--- cd Program Files\MySQL\MySQL Server 8.0\bin
--- mysql -usue -p

-- Delete a user. Sue really never liked bob anyways...
select user, host from mysql.user;
drop user bob@localhost;
select user, host from mysql.user;

-- host
-- localhost: from here
-- 192.168.1.2: remote (defining the IP)
-- %: anywhere. Just by not defining the host when creating the user