-- Create a new user 'hari' with password 'Hari@123'
CREATE USER hari IDENTIFIED BY Hari@123;


-- ==========================================
-- DCL Commands Example: GRANT and REVOKE
-- ==========================================

-- Step 1: Create a sample table 'employee'
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,       -- Employee ID (Unique)
    first_name VARCHAR(30),       -- Employee First Name
    last_name VARCHAR(30),        -- Employee Last Name
    phone VARCHAR(15),            -- Employee Phone Number
    hire_date DATE,               -- Date of Joining
    dept_id INT                   -- Department ID
);

-- Step 2: Insert some sample data
INSERT INTO employee VALUES (1, 'Rahul', 'Sharma', '9876543210', '2025-01-10', 101);
INSERT INTO employee VALUES (2, 'Anu', 'George', '9876501234', '2025-02-15', 102);
INSERT INTO employee VALUES (3, 'Vishnu', 'Kumar', '9876512345', '2025-03-20', 101);

COMMIT;  -- Save changes permanently

-- ==========================================
-- Step 3: Create a new database user
-- ==========================================
CREATE USER hari IDENTIFIED BY Hari@123;

-- ==========================================
-- Step 4: GRANT privileges to the user
-- ==========================================
-- Grant permission to connect to the database and perform operations on 'employee' table
GRANT CREATE SESSION TO hari;      -- Allows user to log in
GRANT SELECT, INSERT, UPDATE, DELETE ON employee TO hari;  -- Table-level privileges

-- ==========================================
-- Step 5: REVOKE privileges from the user
-- ==========================================
-- Remove UPDATE and DELETE permissions
REVOKE UPDATE, DELETE ON employee FROM hari;

-- ==========================================
-- Step 6: Check granted privileges (Oracle example)
-- ==========================================
-- List all privileges granted to user 'hari'
SELECT * FROM USER_TAB_PRIVS WHERE GRANTEE = 'HARI';
