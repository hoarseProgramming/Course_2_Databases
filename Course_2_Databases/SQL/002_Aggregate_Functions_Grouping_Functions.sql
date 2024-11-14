use everyloop;

-- Aggregate functions

select * from Elements;

-- Count

select 
	count(*) as 'Number of rows',
	count(Mass) as 'Number of values in "Mass" column = 114 (4 NULL values)',
	count(Radius) as 'Number of values in "Radius" column',
	count(*) - count(Radius) as 'Number of NULLs in "Radius" Column'
from 
	Elements;

-- Sum, Min, Max, Avg, String_agg

select
	count(Stableisotopes) as 'Number of 5 first values in column "Stableisotopes',
	sum(Stableisotopes) as 'Sum of 5 first values in column "Stableisotopes"',
	min(Stableisotopes) as 'Minimum value in "Stableisotopes"',
	max(Stableisotopes) as 'Minimum value in "Stableisotopes"',
	-- avg Ignores null values!
	avg(cast(Stableisotopes as float)) as 'average of first 5 values in "Stableisotopes"',
	sum(cast(Stableisotopes as float)) / count(Stableisotopes) as 'Wonky way of getting average',
	-- String_Agg(values, separator)
	STRING_AGG(Symbol, ', ') as 'Concatenated strings'
from
	Elements
where 
	Number <= 5;


--------------------------------------------------------------------- Grouping ------------------------------------------------------------

select * from Elements;

-- Example 1

select 
	Period,
	Stableisotopes,
	count(*) as 'Row count',
	count(Stableisotopes) as 'Sum of Stableistopes in Period',
	min(Stableisotopes) as 'Min value of Stableistopes in Period',
	max(Stableisotopes) as'Max value of Stableistopes in Period'
from 
	Elements
-- Groups rows by value of Period and Stableisotopes
group by
	Period,
	Stableisotopes
order by
	Period,
	Stableisotopes;

-- Example 2

select
	id,
	OrderDate,
	ShipRegion,
	ShipCountry,
	ShipCity
from
	company.orders
order by
	ShipRegion,
	ShipCountry,
	ShipCity;

select
	ShipRegion,
	ShipCountry,
	count(*) as 'Number of orders'
from 
	company.orders
group by 
	ShipRegion,
	ShipCountry
order by
	ShipRegion,
	ShipCountry;

-- having
-- Filtering after where-filtering.
select
	ShipRegion,
	count(*) as 'Number of orders'
from 
	company.orders
where
	OrderDate < '2013-01-01 00:00'
group by 
	ShipRegion
having
	count(*) < 10
order by
	count(*);
