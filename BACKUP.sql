-- ==========================================
-- 🔹 BACKUP AND RECOVERY IN MYSQL
-- ==========================================

-- ==========================================
-- 🧠 WHAT IS BACKUP?
-- Backup is the process of taking a copy of the database
-- so that it can be restored later in case of data loss or corruption.
-- ==========================================


-- ==========================================
-- 🔹 STEP 1: CREATE A SAMPLE DATABASE
-- ==========================================
CREATE DATABASE college;
USE college;

-- Create a sample table
CREATE TABLE student (
    stud_id INT PRIMARY KEY,
    stud_name VARCHAR(50),
    dept VARCHAR(30)
);

-- Insert some sample records
INSERT INTO student VALUES (1, 'Rahul', 'CSE');
INSERT INTO student VALUES (2, 'Sneha', 'ECE');
INSERT INTO student VALUES (3, 'Amit', 'MECH');

-- Verify data
SELECT * FROM student;


-- ==========================================
-- 🔹 STEP 2: BACKUP DATABASE USING mysqldump
-- ==========================================
-- This command is run in your system terminal (NOT inside mysql>)

mysqldump -u root -p college > collegedata.sql

-- 📝 Explanation:
--  - 'mysqldump' : MySQL utility to create a backup dump file.
--  - '-u root'    : MySQL username (root).
--  - '-p'         : Prompts for password.
--  - 'college'    : Database name to back up.
--  - '> collegedata.sql' : Output file to store backup.

-- After this, a file named 'collegedata.sql' will be created
-- containing all SQL statements to recreate the 'college' database.


-- ==========================================
-- 🔹 STEP 3: DELETE DATABASE (Simulate Data Loss)
-- ==========================================
DROP DATABASE college;

-- Try to view data (it will show an error since database is deleted)
-- SELECT * FROM student;  ❌


-- ==========================================
-- 🔹 STEP 4: RECOVERY (RESTORE BACKUP)
-- ==========================================
-- Run this command in your terminal to restore the backup:

mysql -u root -p college < collegedata.sql

-- 📝 Explanation:
--  - 'mysql' : MySQL command-line client.
--  - '-u root' : Username.
--  - '-p' : Prompts for password.
--  - 'college' : Target database (must exist before restore).
--  - '< collegedata.sql' : Input file for restoration.

-- If the database doesn’t exist, create it first:
CREATE DATABASE college;


-- ==========================================
-- 🔹 STEP 5: VERIFY RESTORATION
-- ==========================================
USE college;
SELECT * FROM student;

-- ✅ All original records should now be restored.


-- ==========================================
-- 🔹 STEP 6: OPTIONAL — BACKUP A SINGLE TABLE
-- ==========================================
mysqldump -u root -p college student > student_backup.sql

-- 🔹 RESTORE SINGLE TABLE
mysql -u root -p college < student_backup.sql

-- ==========================================
-- ✅ END OF BACKUP AND RECOVERY DEMONSTRATION
-- ==========================================
Get-Content company_sql.sql | mysql -u root -p exam
