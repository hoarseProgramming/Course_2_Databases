
-- creating databases

create database myDataBase;


use myDataBase;

-- creating tables

create table teachers
(
	id int primary key, 
	firstname nvarchar(max),
	lastname nvarchar(max),
	birthdate datetime2
)

insert into teachers (id, firstname) values(1, 'Fredrik');
insert into teachers (id, firstname) values(2, 'Angela');

delete from teachers where id = 2;

update teachers set lastname = 'Johansson' where id = 1;
update teachers set birthdate = '0001-01-01'

select * from teachers

-- Deleting tables/databases

drop table teachers;

-- Can't delete itself
drop database myDataBase;