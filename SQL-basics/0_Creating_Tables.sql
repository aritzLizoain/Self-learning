-- VARIABLE TYPES
    --- INT: Whole numbers 
    --- DECIMAL (M,N): Decimal numbers. M is the total number of digits and N the number of digits after the period
    --- VARCHAR(M): String text max length M 
    --- BLOB: Binary Large Object, large data 
    --- DATE: 'YYYY-MM-DD' 
    --- TIMESTAMP: 'YYY-MM-DD HH:MM:SS'

CREATE TABLE student (
    student_id INT,
    name VARCHAR(20),
    major VARCHAR(20),
    PRIMARY KEY(student_id)
);

DESCRIBE student;

DROP TABLE student;

ALTER TABLE
    student
ADD
    gpa DECIMAL(3, 2);
ALTER TABLE
    student DROP COLUMN gpa;