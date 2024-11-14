use everyloop;

-- 1: GoT - Format

select 
	Title, 
	'S' + Format(Season, '0#') + 'E' + Format(EpisodeInSeason, '0#') as 'Episode', -- Solution 1
	concat('S', Format(Season, '0#'), 'E', Format(EpisodeInSeason, '0#')) as 'Episode' -- Solution 2: Concat = better
from 
	GameOfThrones;

-- 2: Update users

select * into UsersExcersise from Users;

select UserName from Users;
select UserName from UsersExcersise;

select 
	SUBSTRING(UserName, 1, 2) + SUBSTRING(UserName, 4, 2) 
from 
	UsersExcersise;

update UsersExcersise 
	set UserName = SUBSTRING(UserName, 1, 2) + SUBSTRING(UserName, 4, 2); 

-- 3: Update Airports

select * into AirportsExcersise from Airports;

select * 
from AirportsExcersise
	where Time IS NULL OR DST IS NULL;

Update AirportsExcersise
	set Time = '-'
where Time IS NULL;

Update AirportsExcersise
	set DST = '-'
where DST IS NULL;


-- 4: Remove elements

select * into ElementsExcersise from Elements;

select * 
from ElementsExcersise
where Name in ('Erbium', 'Helium', 'Nitrogen')
OR Name like '[dkmou]%'
order by Name;

delete
from ElementsExcersise
where Name in ('Erbium', 'Helium', 'Nitrogen')
OR Name like '[dkmou]%';

-- 5: Check if name start with letters in 'Symbol'

select Symbol, Name into ElementsExcersise2 from Elements;

select * from ElementsExcersise2;

ALTER table ElementsExcersise2
ADD NameStartsWithSymbolLetter nvarchar(3);

update ElementsExcersise2
	set NameStartsWithSymbolLetter = 'Yes'
where Name like Symbol + '%';

update ElementsExcersise2
	set NameStartsWithSymbolLetter = 'No'
where Name not like Symbol + '%';

-- 6: Calculate value in 'Code' from RGB-Values

select Name, Red, Green, Blue into Colors2 from Colors;

select * from Colors;

select 
	Name,
	'#' + Format(Red, 'X2') + Format(Green, 'X2') + Format(Blue, 'X2') as Code,
	Red,
	Green,
	Blue 
from Colors2;

-- 7: Calculate 'Float*, 'DateTime' and 'Bool* columns

select * from Types;

select Integer, string into TypesExcersise from Types;

select * from TypesExcersise;

select 
	Integer,
	Cast(Integer AS FLOAT) * 0.01 as 'Float',
	String,
	DATETIME2FROMPARTS
	(
		2019, 1, Integer, 9, Integer, 0, 0, 7
	) as DateTime,
	case 
		when Integer % 2 = 0 then 0
		else 1
	end as Bool
from TypesExcersise;
