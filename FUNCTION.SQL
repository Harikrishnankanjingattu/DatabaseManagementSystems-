-- ==========================================
-- ✅ FUNCTION IN MYSQL
-- ==========================================
-- A FUNCTION in MySQL is a stored program that can be called 
-- to perform a specific task and return a single value.

-- ==========================================
-- 🔹 SYNTAX OF FUNCTION
-- ==========================================
DELIMITER //

CREATE FUNCTION function_name (parameter_name datatype, ...)
RETURNS return_datatype
[DETERMINISTIC | NOT DETERMINISTIC]
BEGIN
    -- Declare local variables
    DECLARE variable_name datatype;

    -- Function logic or calculations
    -- (IF, CASE, SET, etc.)
    
    RETURN value;   -- Return final result
END//

DELIMITER ;

-- ==========================================
-- 🔹 SIMPLE EXAMPLE: CHECK PASS OR FAIL
-- ==========================================
DELIMITER //

CREATE FUNCTION check_result(mark INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE result VARCHAR(20);

    IF mark >= 40 THEN
        SET result = 'PASS';
    ELSE
        SET result = 'FAIL';
    END IF;

    RETURN result;
END//

DELIMITER ;

-- ==========================================
-- 🔹 HOW TO CALL THE FUNCTION
-- ==========================================
SELECT check_result(65) AS Result;   -- Output: PASS
SELECT check_result(25) AS Result;   -- Output: FAIL
