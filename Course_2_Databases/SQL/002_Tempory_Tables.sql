
 --Temporary tables

 --Is created in system database 'tempdb' / Temporary tables
 --#(local, can only be accessed by session that made it)
 --##(global, can be accessed by all sessions)

select id, FirstName, LastName into #myTable from Users where FirstName like '[a-d]%';

select id, FirstName, LastName into ##myGlobalTable from Users where FirstName like '[a-d]%';

select * from #myTable;

select * from ##myGlobalTable;