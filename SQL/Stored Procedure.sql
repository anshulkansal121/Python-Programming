-- Stored Procedure - Block of SQL statements contains procedural logic that is stored in a DB and is executed by db user or application
-- often used to encapsulate business logic or business logic such as user validation, database update, can seperate application logic from presentation logic
-- simplify application code.

-- EG: we can create a SP that check that no two users have same email address, it helps reduce application code for this data validation and db itself checks this
-- HELLO WORLD Stored procedure

CREATE PROCEDURE hello_world()
BEGIN 
SELECT 'hello World';
END

CALL hello_world

-- CREATE a Stored Procedure to create a new user with email and name
-- only work if email doesnot exists otherwise error message_

CREATE PROCEDURE add_user(
  IN input_name VARCHAR(255),
  IN input_email VARCHAR(255),
  OUT message VARCHAR(255)
)
BEGIN
  -- Check if input_email exists in user table 
  DECLARE user_count INTEGER;
  SELECT COUNT(*) INTO user_count FROM users WHERE email = input_email;

  IF user_count = 0 THEN 
    INSERT INTO users(name,email) VALUES (input_name, input_email);
    SET message = "User Inserted";
  ELSE 
    SET message = "User already Exists";
  END IF;

END 

-- CREATE a variable for message and then output the message
SET @message = '';
CALL add_user('Ankit','ankit@gmail.com',@message);
SELECT @message;



-- CREATE a Store Procedure that returns every order detail of the user based on email
CREATE PROCEDURE user_orders (IN input_email VARCHAR(255))
BEGIN 
  DECLARE id INTEGER;
  SELECT user_id INTO id FROM users WHERE input_email = email;
  SELECT * from orders WHERE user_id = id;
END

CALL user_orders('vartika@gmail.com');



