SHOW DATABASES;
CREATE DATABASE IF NOT EXISTS student_db;
USE student_db;
CREATE TABLE IF NOT EXISTS students (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  age INT
);
INSERT INTO students (name, age) VALUES ('John Doe', 22);
SELECT * FROM students;
