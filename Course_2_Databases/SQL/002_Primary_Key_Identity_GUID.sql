/*
Primary key
 A column marked with pramry key must contain unique values

 Primary key is one of following:
 1. A serial number (integer together with identity)
 2. A GUID (data type uniqueidentifier, together with newid() to generate GUID)
 3. Something already unique, for example: social security number, prduct number, ISBN
 */

-- Identity

-- Table with serial number as primary key.
drop table products;

use ITHS;

create table products
(
	-- identity(starting value, incremental value)
	id int primary key identity(1, 1),
	name nvarchar(100) default ('product')
)

-- Deletes rows but doesn't reset identity count
delete from products;

-- Deletes rows and resets identity count
truncate table products;

insert into products (name) values ('Keyboard');

select * from products;



-- GUID
-- Table with GUID as primary key

drop table productsGUID

select newid()

create table productsGUID
(
	-- One way of giving GUID:s to table
	-- id uniqueidentifier primary key,
	-- name nvarchar(100)

	-- Other way of giving GUID:s (like identity)
	id uniqueidentifier primary key default(newid()),
	name nvarchar(100)
)

insert into productsGUID (id, name) values(newid(), 'keyboard');

insert into productsGUID (name) values('keyboard');

select * from productsGUID;