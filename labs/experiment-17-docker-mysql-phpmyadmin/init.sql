USE mydb;

CREATE TABLE IF NOT EXISTS students (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50),
  age INT
);

INSERT INTO students (name, age)
SELECT 'Alice', 21
WHERE NOT EXISTS (SELECT 1 FROM students WHERE name = 'Alice');

INSERT INTO students (name, age)
SELECT 'Bob', 22
WHERE NOT EXISTS (SELECT 1 FROM students WHERE name = 'Bob');
