-- Transactions - sequence of operation that are performed as a single unit of work in the database
-- consists of one or more DB operation (write) INSERT, UPDATE, DELETE
-- It follows principle of all or none



-- Three Main commands
-- 1. Commit -> used to permanently save the chnanges made by trasaction 
-- 2. Rollback -> use to undo the changes made by transaction, return the db to its state before transaction begin
  -- 3. savepoint -> used to mark a specific point in transaction


-- Auto commit -> feature that automatically commits the individual db transaction as soon as it completes

-- Each SQL statement is AutoCommit

-- Set Autocommit  = 0
SELECT * FROM users;

SET autocommit = 0;
INSERT INTO users (name, email) VALUES('Anshul Kansal', 'anshul@gmail.com');

-- Reconnecting to DB
SELECT * FROM users;
-- Changes are not saved.

SELECT @@autocommit;

-- creating a Transaction
SET autocommit = 0;
START TRANSACTION;
UPDATE users SET password = "new" WHERE user_id = 1;
UPDATE users SET password = "new2" WHERE user_id = 2;

SELECT * FROM users;

-- Lets Reconnect and then check the changes
SELECT * FROM users;
-- Changes does'nt persists

-- Let's commit our changes;
SET autocommit = 0;
START TRANSACTION;
UPDATE users SET password = "new" WHERE user_id = 1;
UPDATE users SET password = "new2" WHERE user_id = 2;
Commit;

SELECT * FROM users;

-- Reconnect
SELECT * FROM users;

-- All or none
SET autocommit = 0;
START TRANSACTION;
UPDATE users SET password = "changenew" WHERE user_id = 1;
UPDATE users SET password = "changenew2" WHERE user_id2 = 2;
Commit;

SELECT * FROM users;

-- Reconnect;
SELECT * FROM users;




-- ACID Properties
-- 1. Atomicity -> ensure that transaction is trated as one single unit of work, either the transaction is fully commited or none at all
-- 2. Consistency -> ensure that transaction take the db from one valid state to another valid state
-- 3. Isolation -> ensure that concurrent transaction does'nt interfere with each other
-- 4. Durability -> ensure that once transaction is completely commited then changes are permanently stores ,even if db fails