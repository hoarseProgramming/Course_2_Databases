
-- View (Vy)

-- Like table without it's own data.

DROP VIEW myView;

--CREATE VIEW myView AS
-- With schema binding. Now you can't alter the table structure
-- that the view references.

GO 

ALTER VIEW myView WITH SCHEMABINDING AS
SELECT
	concat(FirstName, ' ', LastName) as 'Name',
	Email,
	Phone
FROM 
	dbo.newUsers
WHERE
	FirstName LIKE '[a-d]%'
-- with check option: Now you can't insert rows into view that
-- don't fulfill where statement (in this case)
WITH CHECK OPTION
-- Go keyword = SSMS command
-- -> Separates commands in queries, executes separately
GO

DROP TABLE newUsers

-- You can insert into view. This updates the table behind the view.

SELECT
	*
FROM
	myView