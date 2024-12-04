USE everyloop;

-- Subqueries

SELECT
	subquery.Name,
	subquery.Email
FROM
(
SELECT
	concat(FirstName, ' ', LastName) as 'Name',
	Email,
	Phone
FROM 
	users
WHERE
	FirstName LIKE '[a-d]%'
) AS subquery
WHERE	
	LEN(Name) > 15

-- This is a way to avoid joins, but much slower
-- When subquery is dependent on data from the outer query, 
-- it needs to execute for each row in the outer query
-- Inner subqueries should be able to run on their own, otherwise performance issues.
SELECT 
	TrackId,
	Name,
	AlbumId,
	(SELECT Title FROM music.albums WHERE AlbumId = t.AlbumId)
FROM 
	music.tracks t
