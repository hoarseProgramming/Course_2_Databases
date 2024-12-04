use ITHS;

------------------ FOREIGN KEY ------------------

drop table countries;
drop table cities;

create table countries
(
	-- Should be primary key identity, but isn't 
	-- used here to be able to show different joins
	id int PRIMARY KEY,
	name nvarchar(max)
);

insert into countries values(1, 'Sweden');
insert into countries values(2, 'Norway');
insert into countries values(3, 'Denmark');
insert into countries values(4, 'Finland');


create table cities
(
	id int PRIMARY KEY,
	name nvarchar(max),
	countryId int FOREIGN KEY REFERENCES countries(id)
);

insert into cities values(1, 'Stockholm', 1);
insert into cities values(2, 'Gothenburg', 1);
insert into cities values(3, 'Malmö', 1);
insert into cities values(4, 'Oslo', 2);
insert into cities values(5, 'Bergen', 2);
insert into cities values(6, 'Copenhagen', 3);



select * from countries;
select * from cities;
-------------- Things that don't work anymore ---------------

-- Doesn't work anymore, is no country id 8
 insert into cities values(7, 'London', 8);

 -- No countryid 7
UPDATE
	cities
SET
	countryId = 7
WHERE
	id = 6

-- Can't delete country that has cities refering to it.
-- (Can delete country that has no cities refering to it)
DELETE 
FROM
	countries
WHERE
	id = 1
