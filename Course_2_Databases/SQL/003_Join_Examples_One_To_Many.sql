use ITHS;

-------------------------- Joins -------------------------------

drop table countries;
drop table cities;

create table countries
(
	-- Should be primary key identity, but isn't 
	-- used here to be able to show different joins
	id int,
	name nvarchar(max)
);

insert into countries values(1, 'Sweden');
insert into countries values(2, 'Norway');
insert into countries values(3, 'Denmark');
insert into countries values(4, 'Finland');


create table cities
(
	id int,
	name nvarchar(max),
	countryId int
);

insert into cities values(1, 'Stockholm', 1);
insert into cities values(2, 'Gothenburg', 1);
insert into cities values(3, 'Malmö', 1);
insert into cities values(4, 'Oslo', 2);
insert into cities values(5, 'Bergen', 2);
insert into cities values(6, 'Copenhagen', 3);
insert into cities values(7, 'London', 8);

select * from countries;
select * from cities;

-------------------------- Inner join -------------------------------

select 
	-- We can choose columns we want here
	-- Using aliases
	ci.id,
	ci.name as 'City',
	co.name as 'Country',
	-- When unique column name, you don't need to use alias
	countryId
from 
	countries co
	-- join = default. => inner join
	-- Declare aliases
	join cities ci on co.id = ci.countryId

-------------------------- Left join -------------------------------

select 
	cities.id,
	cities.name as 'City',
	countries.name as 'Country'
from 
	countries
	left join cities on countries.id = cities.countryId

-------------------------- Right join -------------------------------

select 
	cities.id,
	cities.name as 'City',
	countries.name as 'Country'
from 
	countries
	right join cities on countries.id = cities.countryId

-------------------------- Full join -------------------------------

select 
	cities.id,
	cities.name as 'City',
	countries.name as 'Country'
from 
	countries
	full join cities on countries.id = cities.countryId


-------------------------- Cross join -------------------------------

select 
	*
from 
	countries
	cross join cities 

-------------------------- Old joins -------------------------------

-- Don't do this! The old way of doing joins.
-- cross join
select * from countries,cities

--left join
select * from countries,cities where countries.id = cities.countryId

-------------------------- Exercise -------------------------------

-- Write a select that gets all countries with columns: 
-- id, country name, number of cities, names comma separated

select 
	countries.id as 'Country Id',
	countries.name as 'Country',
	count(*) as 'Number of cities',
	-- if not null does left argument, if null = right argument
	isnull(STRING_AGG(cities.name, ', '), '-') as 'Cities'
from 
	countries
	left join cities on countries.id = cities.countryId
group by 
	countries.id,
	countries.name

