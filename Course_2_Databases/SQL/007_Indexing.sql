
-- Indexing

USE ITHS

-- Heap table
CREATE TABLE indexDemo
(
	a int,
	b int,
	c int
)

INSERT INTO
	indexDemo
SELECT
	value,
	1000001 - value,
	ABS(CHECKSUM(NEWID())) % 10
FROM generate_series(1, 1000000)

TRUNCATE TABLE indexDemo



-- Algorithm that calculates hash for data, will always be the same for value
SELECT CHECKSUM('hello'), CHECKSUM('hell1')

CREATE TABLE indexDemo_pk
(
	a int PRIMARY KEY,
	b int,
	c int
)

--Primary key by default creates clustered index

INSERT INTO
	indexDemo_pk
SELECT
	value,
	1000001 - value,
	ABS(CHECKSUM(NEWID())) % 10
FROM generate_series(1, 1000000)

-- non clustered index added by menu choice
CREATE TABLE indexDemo_pk_index
(
	a int PRIMARY KEY,
	b int,
	c int
)

INSERT INTO
	indexDemo_pk_index
SELECT
	value,
	1000001 - value,
	ABS(CHECKSUM(NEWID())) % 10
FROM generate_series(1, 1000000)

CREATE TABLE indexDemo_pk_index_with_c
(
	a int PRIMARY KEY,
	b int,
	c int
)

INSERT INTO
	indexDemo_pk_index_with_c
SELECT
	value,
	1000001 - value,
	ABS(CHECKSUM(NEWID())) % 10
FROM generate_series(1, 1000000)

-- Difference between non indexed / indexed tables

SELECT * FROM indexDemo WHERE a = 575000;
SELECT * FROM indexDemo_pk WHERE a = 575000;

-- Difference between non clustered index on b and no index for b
SELECT b FROM indexDemo_pk WHERE b = 575000;
SELECT b FROM indexDemo_pk_index WHERE b = 575000;

-- Difference between non clustered index on b and non clustered 
-- index on b with c added as column
SELECT c FROM indexDemo_pk_index WHERE b = 575000;
SELECT c FROM indexDemo_pk_index_with_c WHERE b = 575000;