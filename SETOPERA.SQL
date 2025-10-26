-- ==========================================
-- SET Operations Syntax in DBMS
-- ==========================================

-- 1️⃣ UNION
-- Combines the result sets of two queries and removes duplicate records
-- Syntax:
SELECT column1, column2, ...
FROM table1
UNION
SELECT column1, column2, ...
FROM table2;

-- 2️⃣ UNION ALL
-- Combines the result sets of two queries including duplicate records
-- Syntax:
SELECT column1, column2, ...
FROM table1
UNION ALL
SELECT column1, column2, ...
FROM table2;

-- 3️⃣ INTERSECT
-- Returns only the common records present in both queries
-- Syntax:
SELECT column1, column2, ...
FROM table1
INTERSECT
SELECT column1, column2, ...
FROM table2;

-- 4️⃣ MINUS / EXCEPT
-- Returns records from the first query that are not present in the second query
-- Syntax (Oracle uses MINUS, SQL Server uses EXCEPT):
SELECT column1, column2, ...
FROM table1
MINUS       -- or EXCEPT in some databases
SELECT column1, column2, ...
FROM table2;
