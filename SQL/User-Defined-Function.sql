-- UDFs created by users to perform specific tasks, used as builtin functions and can take parameters
-- SYNTAX:

DELIMITER $$
CREATE FUNCTION function_name(
  parameter datatype,
  parameter datatype...
)
RETURNS return_datatype
[NOT] DETERMINISTIC 
BEGIN 
  FUNCTION_BODY 
  Return Return_Value
END $$

DELIMITER ;


-- hello world
CREATE FUNCTION hello_world()
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN 
    RETURN 'HELLO WORLD';
END

SELECT hello_world()


-- parameterised vs non-parameterised
DROP FUNCTION calculate_age
CREATE FUNCTION calculate_age(dob DATE)
RETURNS INTEGER DETERMINISTIC 
BEGIN 
DECLARE age INTEGER;
SET age = ROUND(DATEDIFF(DATE(NOW()),dob)/365);
RETURN age;
END

SELECT calculate_age('2001-01-12')


--
CREATE FUNCTION title(
  name VARCHAR(255),
  gender VARCHAR(255),
  married VARCHAR(255)
)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN 
DECLARE title VARCHAR(255);
IF gender = 'M' THEN 
  SET title = CONCAT('Mr.',' ',name);
ELSE 
  IF married = 'Y' THEN 
    SET title = CONCAT('Mrs.',' ',name);
  ELSE
    SET title = CONCAT('Ms.',' ',name);
  END IF;
END IF;
RETURN title;
END;


SELECT title('Anshul Kansal','M','Y')