
use everyloop;
--------------- Self-referencing relationship -----------

select Id, FirstName, LastName, Title, ReportsTo from company.employees;

select
	e.id,
	concat(e.FirstName, ' ', e.LastName) as 'Name',
	e.ReportsTo,
	concat(e2.FirstName, ' ', e2.LastName) as 'ReportsToName'
from 
	company.employees e
	left join company.employees e2 on e.ReportsTo = e2.Id
