--ACID. Commit / Rollback

use everyloop;

select * into newUsers from users;

select * from newUsers;

-- Commit

-- Starts transaction
BEGIN TRANSACTION;
update newUsers SET UserName = '---' where FirstName like 'a%';
update newUsers SET UserName = '***' where FirstName like 'b%';
-- Commits transaction
COMMIT;

-- Roll back changes made since transaction started
ROLLBACK;

------------------- Lock --------------------
BEGIN TRANSACTION;
update newUsers SET UserName = '-' 

-- Table is locked until commited.

