SELECT student.*
FROM student
ORDER BY major DESC, student_id DESC
LIMIT 2;
--ASC or nothing for ascending

SELECT student.name, student.major
FROM student
WHERE major='Computer Science' OR name='Jack';

SELECT student.*
FROM student
WHERE student_id <= 3;

SELECT student.*
FROM student
WHERE minor<>'No minor' AND name='Jack';

SELECT student.*
FROM student
WHERE major IN ('Biology', 'Chemistry') AND minor='Physics';