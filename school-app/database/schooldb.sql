CREATE DATABASE IF NOT EXISTS schooldb;

USE schooldb;

CREATE TABLE IF NOT EXISTS students (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    grade VARCHAR(20),
    email VARCHAR(150)
);

INSERT INTO students (name, age, grade, email)
VALUES
('Rahul', 15, '10th', 'rahul@example.com'),
('Priya', 14, '9th', 'priya@example.com');
