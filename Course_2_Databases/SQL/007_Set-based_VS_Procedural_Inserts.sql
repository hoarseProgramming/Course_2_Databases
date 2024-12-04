
-- Difference in speed set-based programming vs procedural programming

USE ITHS
DROP TABLE DemoData

CREATE TABLE demoData
(
	id int PRIMARY KEY IDENTITY(1, 1),
	timestamp datetime2 default(GETDATE())
)
GO

--Procedural solution #1
-- Sends 100.000 separate inserts from client to server ~ 20 sec

INSERT INTO
	demoData
DEFAULT VALUES
GO 100000

SELECT * FROM demoData


--Procedural solution #2
-- Sends script that does 100.000 separate inserts on server side ~ 10 sec

DECLARE @i int = 0;

WHILE @i < 100000
BEGIN
	INSERT INTO
	demoData
	DEFAULT VALUES
	set @i += 1;
END

-- Set based solution

-- Generate series gives values between two numbers
-- Just gets a constant by using getdate
-- One insert that sets 100.000 rows ~ 0.001 sec

INSERT INTO demoData(timestamp) select GETDATE() FROM generate_series(1, 100000)

-- Resets table + identity
TRUNCATE TABLE
	demoData;


