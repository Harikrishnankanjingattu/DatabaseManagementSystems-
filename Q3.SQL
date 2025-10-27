-- ================================================================
-- ✅ Q1(a): Create Database and Switch to It
-- ================================================================
CREATE DATABASE Company;
USE Company;

-- ================================================================
-- ✅ Q1(b): Create Tables with Constraints
-- ================================================================

-- Department Table
CREATE TABLE DEPARTMENT (
    Dept_id INT PRIMARY KEY,
    Dept_name VARCHAR(40) NOT NULL
);

-- Employee Table
CREATE TABLE EMPLOYEE (
    Emp_id INT PRIMARY KEY,
    EmpName VARCHAR(40) NOT NULL,
    Address VARCHAR(60),
    Phone VARCHAR(10),
    Joining_date DATE,
    Manager_id INT,
    Salary DECIMAL(10,2),
    City VARCHAR(30),
    Dept_id INT,
    FOREIGN KEY (Dept_id) REFERENCES DEPARTMENT(Dept_id),
    FOREIGN KEY (Manager_id) REFERENCES EMPLOYEE(Emp_id)
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
    Emp_id INT,
    Project_id INT,
    Hours_worked INT,
    FOREIGN KEY (Emp_id) REFERENCES EMPLOYEE(Emp_id),
    FOREIGN KEY (Project_id) REFERENCES PROJECTS(Project_id)
);

-- ================================================================
-- ✅ Sample Data for Testing
-- ================================================================

-- Insert Departments
INSERT INTO DEPARTMENT (Dept_id, Dept_name) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Marketing'),
(5, 'Research');

-- Insert Employees
INSERT INTO EMPLOYEE (Emp_id, EmpName, Address, Phone, Joining_date, Manager_id, Salary, City, Dept_id) VALUES
(101, 'Rahul Sharma', 'Delhi', '98765432', '2020-03-15', NULL, 80000, 'Delhi', 1),
(102, 'Neha Patel', 'Mumbai', '98234567', '2021-01-10', 101, 55000, 'Mumbai', 1),
(103, 'Amit Kumar', 'Chennai', '98123456', '2022-07-21', 101, 50000, 'Chennai', 1),
(104, 'Sneha Rao', 'Bangalore', '97890123', '2019-09-30', NULL, 90000, 'Bangalore', 3),
(105, 'Karan Singh', 'Hyderabad', '97987654', '2023-06-25', 104, 60000, 'Hyderabad', 3);

-- Insert Projects
INSERT INTO PROJECTS (Project_id, Project_name, Dept_id) VALUES
(201, 'Recruitment System', 1),
(202, 'Payroll Management', 2),
(203, 'AI Chatbot', 3),
(204, 'Ad Campaign', 4),
(205, 'Research Portal', 5);

-- Insert Works_On Records
INSERT INTO WORKS_ON (Work_id, Emp_id, Project_id, Hours_worked) VALUES
(1, 101, 201, 25),
(2, 102, 201, 30),
(3, 103, 203, 45),
(4, 104, 203, 20),
(5, 105, 203, 35);

-- ================================================================
-- ✅ Q1(c): List employees who work in the same department as their manager
-- ================================================================
SELECT 
    E.Emp_id,
    E.EmpName AS Employee_Name,
    M.EmpName AS Manager_Name,
    E.Dept_id
FROM 
    EMPLOYEE E
JOIN 
    EMPLOYEE M ON E.Manager_id = M.Emp_id
WHERE 
    E.Dept_id = M.Dept_id;


-- ================================================================
-- ✅ Q2(a): Create Trigger for Employee Log
-- ================================================================

-- Create log table
CREATE TABLE EMPLOYEE_LOG (
    Log_id INT AUTO_INCREMENT PRIMARY KEY,
    Emp_id INT,
    Action_performed VARCHAR(50),
    Action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Emp_id) REFERENCES EMPLOYEE(Emp_id)
);

-- Create trigger
DELIMITER //
CREATE TRIGGER after_employee_insert
AFTER INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
    INSERT INTO EMPLOYEE_LOG (Emp_id, Action_performed)
    VALUES (NEW.Emp_id, 'New Employee Added');
END //
DELIMITER ;

-- ================================================================
-- ✅ Q2(b): Start a Transaction (Update City)
-- ================================================================
START TRANSACTION;

UPDATE EMPLOYEE
SET City = 'Kochi'
WHERE City = 'Thrissur';

COMMIT;

-- ================================================================
-- ✅ Q3: Stored Procedure TransferEmployee
-- ================================================================

-- Create log table for transfers
CREATE TABLE DEPT_TRANSFER_LOG (
    Log_id INT AUTO_INCREMENT PRIMARY KEY,
    Emp_id INT,
    Old_Dept INT,
    New_Dept INT,
    Transfer_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create stored procedure
DELIMITER //
CREATE PROCEDURE TransferEmployee(IN emp_number INT, IN new_dept_id INT)
BEGIN
    DECLARE old_dept INT;
    
    -- Get old department
    SELECT Dept_id INTO old_dept FROM EMPLOYEE WHERE Emp_id = emp_number;
    
    -- Update department
    UPDATE EMPLOYEE
    SET Dept_id = new_dept_id
    WHERE Emp_id = emp_number;
    
    -- Log the transfer
    INSERT INTO DEPT_TRANSFER_LOG (Emp_id, Old_Dept, New_Dept)
    VALUES (emp_number, old_dept, new_dept_id);
END //
DELIMITER ;

-- Example:
-- CALL TransferEmployee(103, 2);

-- ================================================================
-- ✅ Q4: Create View for High Salary Employees
-- ================================================================
CREATE VIEW High_Salary_Employees AS
SELECT Emp_id, EmpName, Salary, City, Dept_id
FROM EMPLOYEE
WHERE Salary > 50000;

-- To display the view:
-- SELECT * FROM High_Salary_Employees;
