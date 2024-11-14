use everyloop;

declare @name nvarchar(max) = 'Sigfrid'
declare @lastName nvarchar(max) = '';

--print @name

--set @name = 'Sigge'

--print @name

---- Doesn't give result to client
---- Can set multiple values at once

--select @lastName = LastName from Users where FirstName = @name;

select @lastName += LastName + '; ' from Users where FirstName = @name;

print @lastName
select @lastName


----------- Table Variable -------------

declare @myTable as Table
(
	firsName nvarchar(20),
	lastName nvarchar(20)
)

insert into @myTable values('Gustav', 'Gustavsson');
insert into @myTable values('Pelle', 'Pellesson');

select * from @myTable;
