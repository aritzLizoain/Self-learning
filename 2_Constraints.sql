-- Delete table
DROP TABLE student; 

-- Create table
    --NOT NULL
    --UNIQUE
    --DEFAULT
CREATE TABLE student (
    student_id INT AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    major VARCHAR(20),
    minor VARCHAR(30) DEFAULT 'No minor',
    PRIMARY KEY(student_id)
);

-- NOT NULL: needs a value UNIQUE: cannot be repeated DEFAULT: in case it is not defined
-- AUTO_INCREMENT: primary key numbers automatically 1,2,3,4...

-- Show everything from the table
SELECT * FROM student; 

-- Insert data
INSERT INTO student(name, major, minor) VALUES('Jack', 'Biology', 'Microbiology');
INSERT INTO student(name, major) VALUES('Kate', 'Sociology');
INSERT INTO student(name) VALUES('Claire');
INSERT INTO student(name, major, minor) VALUES('Jack', 'Chemistry', 'Physics');
INSERT INTO student(name, major, minor) VALUES('Mike', 'Computer Science', 'Mechanical Engineering');