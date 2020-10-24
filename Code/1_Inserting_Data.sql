CREATE TABLE student (
    student_id INT,
    name VARCHAR(20),
    major VARCHAR(20),
    PRIMARY KEY(student_id)
);


INSERT INTO student VALUES(1, 'Jack', 'Biology');
INSERT INTO student VALUES(2, 'Kate', 'Sociology');
INSERT INTO student(student_id, major) VALUES(3, 'Physics');
INSERT INTO student(student_id, major, name) VALUES(4, 'Physics', 'Claire');

SELECT * FROM student;
--SELECT student_id FROM student;