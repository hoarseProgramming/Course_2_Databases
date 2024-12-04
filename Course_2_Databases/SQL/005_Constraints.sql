------------- Constraints ------------------
use ITHS;

----- PRIMARY KEY, NOT NULL, UNIQUE

CREATE TABLE compositeKeyDemo
(
	id int primary key, -- unique, not null
	firstName nvarchar(max) not null,
	SSN nvarchar(20) unique
	-- SSN nvarchar(20) unique not null
)

insert into
	compositeKeyDemo(id, firstName) values(1, 'Hampus');

insert into
	compositeKeyDemo(id, firstName, SSN) values(2, 'Hampus', '91');
	
insert into
	compositeKeyDemo(id, firstName, SSN) values(3, '', '92');

DROP TABLE compositeKeyDemo

-------------- Composite primary key ----------------

-- Can be more than two columns in a composite key.

CREATE TABLE compositeKeyDemo
(
	id int NOT NULL,
	firstName nvarchar(20) NOT NULL,
	SSN nvarchar(20) unique NOT NULL,
	primary key(id, firstName)
)

-- Id or firstName doen't have to be unique, but the combination between them 
-- must be!

insert into
	compositeKeyDemo(id, firstName, SSN) values(1, '1', '93');
insert into
	compositeKeyDemo(id, firstName, SSN) values(2, '1', '94');
insert into
	compositeKeyDemo(id, firstName, SSN) values(2, '2', '95');
select
	*
from
	compositeKeyDemo;

----------------- CHECK, DEFAULT -------------------

drop table constraintsDemo

CREATE TABLE constraintsDemo
(
	id int PRIMARY KEY IDENTITY(1, 1),
	firstName nvarchar(20) DEFAULT('Hampus'),
	createdAt datetime2 DEFAULT(GETDATE()),
	SSN nvarchar(20) check(SSN LIKE '[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]') DEFAULT('000000-0000'),
	SSN1 nvarchar(20) check(SSN1 LIKE CONCAT(REPLICATE('[0-9]', 6), '-', REPLICATE('[0-9]', 4))) DEFAULT('000000-0000')
)
INSERT INTO constraintsDemo(firstName) values ('Anders')
INSERT INTO constraintsDemo default values;
INSERT INTO constraintsDemo(firstName, SSN, SSN1) values('A"#¤%&/()!', '123456-1234', '123456-1234');

select * from constraintsDemo

