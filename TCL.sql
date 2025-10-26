-- ==========================================
-- TCL Commands Example: COMMIT, ROLLBACK, SAVEPOINT
-- ==========================================

-- Step 1: Create the 'students' table
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(30),
    department VARCHAR(10)
);

-- Step 2: Insert some initial records
INSERT INTO students VALUES (1, 'Rahul', 'CSE');
INSERT INTO students VALUES (2, 'Anu', 'ECE');
INSERT INTO students VALUES (3, 'Vishnu', 'EEE');

-- Save the current state permanently
COMMIT;

-- ==========================================
-- Example 1: Using COMMIT
-- ==========================================
INSERT INTO students VALUES (4, 'Manu', 'IT');
-- The new record is not yet permanent until COMMIT is executed
COMMIT;  
-- ✅ Now the data is permanently stored in the database


-- ==========================================
-- Example 2: Using ROLLBACK
-- ==========================================
DELETE FROM students WHERE id = 2;
-- The record with id=2 (Anu) is deleted temporarily
ROLLBACK;
-- ✅ The delete operation is undone; record with id=2 is restored


-- ==========================================
-- Example 3: Using SAVEPOINT and ROLLBACK TO
-- ==========================================
-- Begin a new transaction
BEGIN;

UPDATE students SET department = 'CIVIL' WHERE id = 1;
-- Create a checkpoint after first update
SAVEPOINT sp1;

UPDATE students SET department = 'MECH' WHERE id = 3;
-- Create another checkpoint
SAVEPOINT sp2;

-- Undo the second update but keep the first one
ROLLBACK TO sp1;

-- Make remaining changes permanent
COMMIT;

-- ==========================================
-- Final Data View
-- ==========================================
SELECT * FROM students;
