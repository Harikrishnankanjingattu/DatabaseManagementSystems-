-- ==========================================
-- VIEWS IN DBMS: SINGLE COPY-CODE FORMAT
-- ==========================================

-- 1️⃣ Create a Simple View
-- A view that selects specific columns from a single table
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;

-- 2️⃣ Create a Complex View
-- A view that selects data from multiple tables using JOINs or other operations
CREATE VIEW view_name AS
SELECT t1.column1, t2.column2, ...
FROM table1 t1
JOIN table2 t2 ON t1.column = t2.column
WHERE condition;

-- 3️⃣ Querying a View
-- Fetch all data from the view
SELECT * FROM view_name;

-- Fetch specific columns from the view
SELECT column1, column2
FROM view_name
WHERE condition;

-- 4️⃣ Updating Data Through a View (if the view is updatable)
UPDATE view_name
SET column1 = value
WHERE condition;

-- 5️⃣ Dropping a View
-- Remove the view from the database
DROP VIEW view_name;

-- ==========================================
-- NOTES:
-- 1. Views do not store data physically; they dynamically fetch data from underlying tables.
-- 2. Simple views are usually updatable; complex views may not be updatable.
-- 3. Views are useful for security: you can grant SELECT privileges on views without giving access to base tables.
