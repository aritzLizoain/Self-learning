SELECT * FROM student;

--UPDATE

UPDATE student
SET major = 'Biochemistry'
WHERE major = 'Bio' OR major = 'Chemistry';

UPDATE student
SET major = 'Chemistry Jacks', name = 'Jacks Chemistry'
WHERE major = 'Chemistry' AND name = 'Jacks';

UPDATE student
SET minor='choose a new minor';

--DELETE

DELETE FROM student
WHERE major='Bio' AND name='Jacks';

DELETE FROM student; --deletes everything