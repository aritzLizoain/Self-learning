-- CREATE
--     TRIGGER `event_name` BEFORE/AFTER INSERT/UPDATE/DELETE
--     ON `database`.`table`
--     FOR EACH ROW BEGIN
-- 		-- trigger body
-- 		-- this code is applied to every
-- 		-- inserted/updated/deleted row
--     END;

CREATE TABLE trigger_test (
     message VARCHAR(100)
);


--ADDED NEW EMPLOYEE
--Needs to be done on the command line (MySQL) because the delimeter cannot be changed in PopSQL

DELIMITER $$
CREATE
    TRIGGER my_trigger BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES('added new employee');
    END$$
DELIMITER ;

INSERT INTO employee
VALUES(109, 'Oscar', 'Martinez', '1968-02-19', 'M', 69000, 106, 3);

SELECT * FROM trigger_test;

-- NEW.first_name
DELIMITER $$
CREATE
    TRIGGER my_trigger_firstName BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES(NEW.first_name);
    END$$
DELIMITER ;

INSERT INTO employee
VALUES(110, 'Paul', 'Malone', '1978-02-19', 'M', 69000, 106, 3);

-- Date attempt (my own creation)
DELIMITER $$
CREATE
    TRIGGER my_trigger_date BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES(CURRENT_TIMESTAMP);
    END$$
DELIMITER ;

INSERT INTO employee
VALUES(999, 'Aritz', 'Lizoain', '1900-1-1', 'M', 9999999, NULL, 1);

-- Male/Female/Other employee added
DELIMITER $$
CREATE
    TRIGGER my_trigger_MFO BEFORE INSERT
    ON employee
    FOR EACH ROW BEGIN
         IF NEW.sex = 'M' THEN
               INSERT INTO trigger_test VALUES('added male employee');
         ELSEIF NEW.sex = 'F' THEN
               INSERT INTO trigger_test VALUES('added female');
         ELSE
               INSERT INTO trigger_test VALUES('added other employee');
         END IF;
    END$$
DELIMITER ;
INSERT INTO employee
VALUES(111, 'Pam', 'Beesly', '1988-02-19', 'F', 69000, 106, 3);

DROP TRIGGER my_trigger_MFO;