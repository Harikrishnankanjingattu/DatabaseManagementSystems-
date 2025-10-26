DELIMITER //

-- Example tables
CREATE TABLE employee (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    join_date DATE
);

CREATE TABLE new_emp (
    emp_id INT,
    first_name VARCHAR(50)
);

CREATE TABLE employee_log (
    emp_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    change_date DATETIME
);

-- 1️⃣ AFTER INSERT Trigger: Copy inserted employee to new_emp
DROP TRIGGER IF EXISTS after_employee_insert //
CREATE TRIGGER after_employee_insert
AFTER INSERT ON employee
FOR EACH ROW
BEGIN
    -- NEW.column_name refers to the newly inserted row
    INSERT INTO new_emp (emp_id, first_name)
    VALUES (NEW.emp_id, NEW.first_name);
END //

-- 2️⃣ BEFORE INSERT Trigger: Set default department if NULL
DROP TRIGGER IF EXISTS before_employee_insert //
CREATE TRIGGER before_employee_insert
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    -- You can modify NEW values before insertion
    IF NEW.department IS NULL THEN
        SET NEW.department = 'General';
    END IF;
END //

-- 3️⃣ AFTER UPDATE Trigger: Log old and new salary
DROP TRIGGER IF EXISTS after_employee_update //
CREATE TRIGGER after_employee_update
AFTER UPDATE ON employee
FOR EACH ROW
BEGIN
    -- OLD.column_name = value before update
    -- NEW.column_name = value after update
    INSERT INTO employee_log(emp_id, old_salary, new_salary, change_date)
    VALUES (OLD.emp_id, OLD.salary, NEW.salary, NOW());
END //

-- 4️⃣ BEFORE DELETE Trigger: Prevent deletion if salary > 50000
DROP TRIGGER IF EXISTS before_employee_delete //
CREATE TRIGGER before_employee_delete
BEFORE DELETE ON employee
FOR EACH ROW
BEGIN
    -- OLD.column_name = value of row being deleted
    IF OLD.salary > 50000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete employees with salary > 50000';
    END IF;
END //

DELIMITER ;

-- ✅ USAGE EXAMPLES

-- Insert employee (triggers fire automatically)
INSERT INTO employee (first_name, last_name, salary) VALUES ('Rahul', 'Sharma', 45000);

-- Update salary (AFTER UPDATE trigger logs old and new salary)
UPDATE employee SET salary = 47000 WHERE emp_id = 1;

-- Delete employee (BEFORE DELETE trigger may prevent deletion)
DELETE FROM employee WHERE emp_id = 1;

-- View results
SELECT * FROM new_emp;
SELECT * FROM employee_log;
