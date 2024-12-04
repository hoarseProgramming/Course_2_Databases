
-- Stored procedure is a function stored in DB
-- Stored procedures can return values
-- We can't set data type, SP always returns int

-- CREATE PROCEDURE
-- Parameters, comma separated (name, data type)
-- Can have default values
-- Can have out data type that returns seomthing else than an int

ALTER PROCEDURE myProcedure @timestamp datetime = '2020-01-01', @name nvarchar(20) AS
BEGIN
	--PRINT @timestamp;
	--PRINT @name;
	DECLARE @now datetime = GETDATE();

	-- Return can be used in logic to stop procedure.
	RETURN;

	SELECT @timestamp as 'Timestamp',
	@now as 'Now',
	DATEDIFF(DAY, @timestamp, @now)  as 'Diff',
	@name as 'Name';

	-- Return is used as error codes
	RETURN LEN(@name);
END;

-- Run myProcedure, call upon with EXEC keyword
EXEC myProcedure '2024-01-01', 'Hampus';
EXEC myProcedure @name = 'Hampus';

GO
------------ SP 2 --------------

ALTER PROCEDURE random @rows int = 1, @total float OUTPUT AS
BEGIN
	--How to turn of messages with "Rows affected"
	SET nocount on;

	DECLARE @i int = 1;

	DECLARE @t table
	(
		n int,
		r float
	)

	WHILE @i <= @rows
	BEGIN
		INSERT INTO @t VALUES(@i, RAND());
		SET @i += 1;
	END

	SELECT @total = SUM(r) FROM @t;
	SELECT * FROM @t;

	-- Turn it off as well :-)
	SET nocount off;
END

GO

DECLARE @result float;

-- How to get return values from SP
EXEC random 5, @total = @result OUTPUT;

PRINT @result;