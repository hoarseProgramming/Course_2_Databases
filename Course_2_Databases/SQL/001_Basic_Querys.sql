/* Tips
Ctrl+R shows or hide results
You can select what portion of query to execute. Just select text in editor and press execute.
SQL is not case sensitive!
Order of keywords is impportant!
*/

-- select * from students; -- gets data from server * = all
/*
-- changes database
use ITHS;

select 
	-- Projection, how to show data found as columns
	[id], -- To select column, works in all SQL(?).
	"name", -- Needs to be used when column name has white space or special characters.
	id,
	10 + id as 'IDplus10',
	'hej ' + name as greeting
from 
	students
where	
	/* Selection: Selects what data to get
	Equality operators:

	= Equals
	<> not equal (But T-SQL also accepts !=)
	< less than
	> larger than
	<= less or equal
	>= larger or equal

	Logical operators:
	and (&&)
	or (||)
	not (|)
	*/
	id > 1 and id < 3; -- gets id, name, id,  10 + id, the greeting where id is larger than 1 and less than 3.

	*/
-- top = get specified number of rows, percent = percent of rows

/*

select top 50 percent * from students;
-- Standard SQL: select * from students limit 50;

select * from students where id between 2 and 3;
select * from students where id >= 2 and id <= 3;

*/

-- in
-- select * from students where name in ('Sven Svensson', 'Kalle Kallesson');

-- between
-- select * from students where name between 'a' and 's';

-- like
-- used when you want to match text fields to a specific pattern, ex: all textfields starting with 'B'.

/* 
% any string, 0 or more letters
_ one char, any
[] One char in a set or span: [abcd] / [a-d]
[^] Not char in a set or span: [^abcd] / [^a-d]
*/

-- select * from students where name like '[a-k]%';

-- changes database
use everyloop;

/* Order by
Sort results on one or more columns.
Last in expression.
ascending (asc) default. descending (desc) is the other option.
Sorts before selecting! Top 5 gets top 5 after sorting.
*/

select * from Users where len(FirstName) = 5 order by FirstName;

select * from Users order by FirstName desc, LastName asc; --asc

select top 5 * from Users order by FirstName desc;


-- distinct, gets every unique
select Region from Countries;

select distinct Region from Countries;

-- aliases: give new column name (as)

-- union all
-- get as same result

select country from Countries where country like 'a%'
union all
select firstname from Users where firstname like 'b%';

-- case-when
-- if, else if statement

select
	FirstName,
	len(firstname) as 'Length of firstname',
	case
		when len(firstname) < 4 then 'Short'
		when len(firstname) < 8 then 'Mid'
		else 'Long'
	end as 'Name length'
from 
	Users;