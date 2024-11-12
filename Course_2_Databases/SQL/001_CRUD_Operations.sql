
-- CRUD operations (Create, Read, Update, Delete

use ITHS;

-- Create 

-- insert into 

-- adds data to table
-- Syntax: (table) (columns) (values)
insert into students (id, name) values(4, 'Bengt Bengtsson');

-- inserts into all columns
insert into students values(5, 'Erik Eriksson', '0001-01-01');

-- choose which columns
insert into students (id, birthdate) values(6, '0006-06-06');

-- select into

-- Get rows and make a new table of the result
-- Need to refresh tables in database for the new one to show up!

select name, birthdate into newStudents from students where id > 3;

-- insert into select from

-- Takes data from one table and puts it in another table

insert into newStudents 
select name, birthdate from students where id < 3;


-- Update

-- Change value on one or more rows in table.

update newStudents set name = 'test' where name like 'a%';

-- Delete

-- Remove one or more rows from table

delete from newStudents where birthdate = '0006-06-06';

-- Upsert

-- Mix of update and insert.
-- Row should update if it exists, otherwise it should be created.