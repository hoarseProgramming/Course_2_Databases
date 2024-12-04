use everyloop;

-- 1: Elements

select * from Elements

select 
	Period,
	min(Number) as 'from element number',
	max(Number) as 'to element number',
	Format(SUM(Stableisotopes) / cast(count(Stableisotopes) AS DECIMAL), 'F2') as 'average isotopes',
	STRING_AGG(Symbol, ', ') as 'symbols'
from 
	Elements
group by 
	Period;

---- 2: Cities with minimum 2 customers

select * from company.customers

select * from company.Customers order by City

select	
	Region,
	Country,
	City,
	count(*) as 'Customers'
from
	company.customers
group by
	Region,
	Country,
	City
having 
	count(*) >= 2

-- 3: GoT aggregated string

select * from GameOfThrones;

Declare @gameOfThronesString as nvarchar(max) = '';

select
	@gameOfThronesString += 'Season ' + cast(Season as nvarchar) + ' ',
	@gameOfThronesString += 'aired from ' + LOWER(Format(min([Original air date]), 'MMMM')) + ' ',
	@gameOfThronesString += 'to ' + LOWER(Format(max([Original air date]), 'MMMM')) + ' ',
	@gameOfThronesString += FORMAT(max([Original air date]), 'yyyy') + '. ',
	@gameOfThronesString += 'There was a total of ' + cast(count(*) as nvarchar) + ' episodes in the season, ',
	@gameOfThronesString += 'where each episode was watched by an average of ' + format(avg([U.S. viewers(millions)]), 'F1') + ' million people in the U.S.' + nchar(13)
from 
	GameOfThrones
group by 
	Season

print @gameOfThronesString

-- 4: Name, age, sex

select * from Users;

select
	CONCAT(FirstName, ' ', LastName) as 'Name',
	DATEDIFF(YEAR, DATEFROMPARTS(cast('19' + left(id, 2) as int), SUBSTRING(id, 3, 2), SUBSTRING(id, 5, 2)), GETDATE()) as 'Age',
	IIF
	(
		SUBSTRING(id, 10, 1) % 2 = 0, 
		'Woman', 
		'Man'
	) as 'Sex'
from
	Users
order by
	FirstName,
	LastName;

-- 5: Aggregate data for different regions.

select * from Countries
order by region;

select
	Region,
	count(*) as 'Number of countries',
	sum(cast([Population] as bigint)) as 'Total number of citizens',
	cast(sum([Area (sq# mi#)]) as nvarchar) + ' m' + nchar(0x00B2) as 'Total Area (m²)',
	Format(sum(cast([population] as bigint)) / sum(cast([Area (sq# mi#)] as decimal)), 'F2') as 'Population density per m²'
from
	Countries
group by 
	Region

-- 6: Group by country

----------------- Working pretty good -----------------------

select * from Airports

select 
	IATA,
	ICAO,
	[Location served]
INTO AirportsExercise2
from Airports

select 
	IIF
	(
		CHARINDEX(',', [Location served]) != 0,
		IIF
		(
			PATINDEX('%[0-9]%', [Location served]) > 0,
			RIGHT
			(
				REPLACE([Location served], SUBSTRING([Location served], PATINDEX('%[0-9]%', [Location served]), 1), ''),
				CHARINDEX
				(
					',',
					REVERSE
					(
						REPLACE([Location served], SUBSTRING([Location served], PATINDEX('%[0-9]%', [Location served]), 1), '')
					)
				) - 2
			),
			RIGHT([Location served], CHARINDEX(',', REVERSE([Location served])) - 2)
		),
		[Location served]
	) as 'Country',
	IATA,
	ICAO
INTO 
	AirportsExercise3
from 
	AirportsExercise2

SELECT 
	Country, 
	COUNT(IATA) AS 'Number of Airports',
	COUNT(IATA) - COUNT(ICAO) AS 'Number of airports missing ICAO code',
	FORMAT(CAST(COUNT(IATA) - COUNT(ICAO) AS decimal) / COUNT(IATA), 'P') AS 'Percentage missing ICAO'
FROM 
	AirportsExercise3
GROUP BY
	Country
ORDER BY 
	Country

----- Testing REPLACE --------------
--select
--	REPLACE(Country, SUBSTRING(Country, PATINDEX('%[0-9]%', Country), 1), '')
--from 
--	Airportsexercise3



-------- Looking for special characters ------------------

--DECLARE @position INT, @nstring NVARCHAR(MAX)
--SET @position = 1;
--SELECT 
--	@nstring = Country 
--from 
--	Airportsexercise3
--where
--	IATA = 'ZMH'

--PRINT 
--	'Character #' + ' ' + 'Unicode Character' + ' ' + 'UNICODE Value';  
--WHILE @position <= LEN(@nstring)  

--BEGIN;
--	SELECT 
--		@position AS [position],
--		SUBSTRING(@nstring, @position, 1) AS [character],
--		UNICODE(SUBSTRING(@nstring, @position, 1)) AS [code_point];
--	SET @position = @position + 1;
--END;