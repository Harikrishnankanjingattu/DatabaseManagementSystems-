-- ✅ Q2(a): Create Database and Switch to It
CREATE DATABASE Company;
USE Company;

-- ✅ Q2(b): Create Tables

-- Department Table
CREATE TABLE DEPARTMENT (
    Dept_id INT PRIMARY KEY,
    Dept_name VARCHAR(40) NOT NULL
);

-- Employee Table
CREATE TABLE EMPLOYEE (
    emp_id INT PRIMARY KEY,
    Fname VARCHAR(30) NOT NULL,
    Lname VARCHAR(30),
    Address VARCHAR(50),
    Phone VARCHAR(10),
    Joining_date DATE,
    Dept_id INT,
    FOREIGN KEY (Dept_id) REFERENCES DEPARTMENT(Dept_id)
);

-- Projects Table
CREATE TABLE PROJECTS (
    Project_id INT PRIMARY KEY,
    Project_name VARCHAR(50),
    Dept_id INT,
    FOREIGN KEY (Dept_id) REFERENCES DEPARTMENT(Dept_id)
);

-- Works_On Table
CREATE TABLE WORKS_ON (
    Work_id INT PRIMARY KEY,
    emp_id INT,
    Project_id INT,
    Hours_worked INT,
    FOREIGN KEY (emp_id) REFERENCES EMPLOYEE(emp_id),
    FOREIGN KEY (Project_id) REFERENCES PROJECTS(Project_id)
);

-- ✅ Q2(c): Insert Sample Records

-- Insert Departments
INSERT INTO DEPARTMENT (Dept_id, Dept_name) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Marketing'),
(5, 'Research');

-- Insert Employees
INSERT INTO EMPLOYEE (emp_id, Fname, Lname, Address, Phone, Joining_date, Dept_id) VALUES
(101, 'Rahul', 'Sharma', 'Delhi', '98765432', '2022-03-15', 1),
(102, 'Neha', 'Patel', 'Mumbai', '98234567', '2023-01-10', 2),
(103, 'Amit', 'Kumar', 'Chennai', '98123456', '2021-07-21', 3),
(104, 'Sneha', 'Rao', 'Bangalore', '97890123', '2020-09-30', 4),
(105, 'Karan', 'Singh', 'Hyderabad', '97987654', '2023-06-25', 5);

-- Insert Projects
INSERT INTO PROJECTS (Project_id, Project_name, Dept_id) VALUES
(201, 'Recruitment System', 1),
(202, 'Budget Analyzer', 2),
(203, 'AI Chatbot', 3),
(204, 'Ad Campaign', 4),
(205, 'Research Portal', 5);

-- Insert Works_On Records
INSERT INTO WORKS_ON (Work_id, emp_id, Project_id, Hours_worked) VALUES
(1, 101, 201, 25),
(2, 102, 202, 30),
(3, 103, 203, 45),
(4, 104, 204, 20),
(5, 105, 205, 35);

-- ✅ Q3: Backup and Restore

-- (Run these commands in Command Prompt, not inside MySQL)

-- To take backup of Company database:
-- mysqldump -u root -p Company > Company.sql

-- To create backup database and restore it:
-- mysql -u root -p -e "CREATE DATABASE Company_Backup;"
-- mysql -u root -p Company_Backup < Company.sql


-- ✅ Q4: Create Stored Procedure GetEmployeeInfo

DELIMITER //
CREATE PROCEDURE GetEmployeeInfo(IN emp_number INT)
BEGIN
    SELECT * FROM EMPLOYEE WHERE emp_id = emp_number;
END //
DELIMITER ;

-- To call the procedure:
-- CALL GetEmployeeInfo(103);
