use everyloop;

---- A: Company

----1: Företagets totala produktkatalog består av 77 unika produkter. 
----Om vi kollar bland våra ordrar, hur stor andel av dessa produkter har vi någon gång leverarat till London?

select 
	p.id,
	p.ProductName,
	count(*) as 'Number of orders'
from 
	company.products p 
	join company.order_details od on p.id = od.ProductId
group by
	p.id,
	p.ProductName

select 
	o.ShipCity as 'City',
	count(distinct p.ProductName) as 'Unique products ordered',
	Format(cast(count(distinct p.ProductName) as decimal) / (SELECT COUNT(*) FROM company.products), 'P') as 'Percentage of products sold to London'
from company.orders o 
	join company.order_details od on o.id = od.OrderId
	join company.products p on p.id = od.ProductId
where ShipCity = 'London'
group by
	o.ShipCity

-- Get rid of unnecessary join
select 
	o.ShipCity as 'City',
	count(distinct od.ProductId) as 'Unique products ordered',
	Format(cast(count(distinct od.ProductId) as decimal) / (SELECT COUNT(*) FROM company.products), 'P') as 'Percentage of products sold to London'
from company.orders o 
	join company.order_details od on o.id = od.OrderId
	--join company.products p on p.id = od.ProductId
where ShipCity = 'London'
group by
	o.ShipCity

----2: Till vilken stad har vi levererat flest unika produkter?

select
	cor.ShipCity,
	count(distinct cp.ProductName) as 'Number of unique products ordered'
from 
	company.products cp
	join company.order_details cod on cp.Id = cod.ProductId
	join company.orders cor on cod.OrderId = cor.id 
group by
	cor.ShipCity
order by 
	count(distinct cp.ProductName) desc

----3: Av de produkter som inte längre finns I vårat sortiment, hur mycket har vi sålt för totalt till Tyskland?

select 
	co.ShipCountry,
	p.UnitPrice,
	cod.UnitPrice,
	cod.Quantity,
	cod.Quantity * cod.UnitPrice as 'Total cost'
from 
	company.products p
	join company.order_details cod on p.id = cod.ProductId
	join company.orders co on cod.OrderId = co.Id
where 
	p.Discontinued = 1 AND co.ShipCountry = 'Germany'

select 
	cod.Quantity * cod.UnitPrice as 'Total cost' into company.Exercise1
from 
	company.products p
	join company.order_details cod on p.id = cod.ProductId
	join company.orders co on cod.OrderId = co.Id
where 
	Discontinued = 1 AND co.ShipCountry = 'Germany'

select 
	sum([Total cost]) as 'Sum of orders of discontinued products to Germany'
from 
	company.Exercise1

----4: För vilken produktkategori har vi högst lagervärde?

select
	CategoryId,
	[UnitPrice] * UnitsInStock as 'Value of stock'
into
	company.Exercise2
from 
	company.products

select
	CategoryId,
	sum([Value of stock]) as 'Total value in category'
from 
	company.Exercise2
group by
	CategoryId
order by
	sum([Value of stock]) desc

select * from company.products

----5: Från vilken leverantör har vi sålt flest produkter totalt under sommaren (june, july, august) 2013?

--select * from company.order_details 

---- Most quantity sold

select 
	cs.CompanyName,
	sum(cod.Quantity) as 'Quantity sold'
from 
	company.orders co
	join company.order_details cod on co.Id = cod.OrderId
	join company.products cp on cod.ProductId = cp.Id
	join company.suppliers cs on cp.SupplierId = cs.Id
where 
	OrderDate >= '2013-06-01' AND OrderDate < '2013-09-01'
group by
	cs.CompanyName
order by
	sum(cod.Quantity) desc

------------------------- B ------------------------


--Genre	Artist	Album	Track	Length	Size	Composer
--Heavy Metal	Iron Maiden	Killers	Killers	05:00	6.9 MiB	Steve Harris
--Heavy Metal	Iron Maiden	Killers	Wrathchild	02:54	4.0 MiB	Steve Harris
--Metal	Black Sabbath	Black Sabbath	N.I.B	06:08	11.5 MiB	-

declare @playlist varchar(max) = 'Heavy metal classic';

select 
	mg.Name as 'Genre',
	mar.Name as 'Artist',
	mal.Title as 'Album',
	mt.Name as 'Track',
	FORMAT(mt.Milliseconds / 60000, '0#') + ':' + FORMAT(mt.Milliseconds % 60000 / 1000 , '0#') as 'Length',
	FORMAT(cast(mt.Bytes as decimal) / POWER(1024, 2), '0.0') + ' MiB' as 'Size',
	isnull(mt.Composer, '-') as 'Composer'
from 
	music.playlists mp
	join music.playlist_track mpt on mp.PlaylistId = mpt.PlaylistId
	join music.tracks mt on mpt.TrackId = mt.TrackId
	join music.genres mg on mt.GenreId = mg.GenreId
	join music.albums mal on mt.AlbumId = mal.AlbumId
	join music.artists mar on mal.ArtistId = mar.ArtistId
where 
	mp.Name = @playlist

----------------------- C ------------------------

--Av alla audiospår, vilken artist har längst total speltid?
--Vad är den genomsnittliga speltiden på den artistens låtar?

select 
	mar.Name,
	sum(mt.Milliseconds) as 'Total playing time in milliseconds',
	FORMAT(sum(mt.Milliseconds) / count(*) / 60000, 'F0') + ':' + FORMAT(sum(mt.Milliseconds) / count(*) % 60000 / 1000, '00') as 'Average playing time'
from 
	music.tracks mt
	join music.albums ma on mt.AlbumId = ma.AlbumId
	join music.artists mar on mar.ArtistId = ma.ArtistId
group by
	mar.Name
order by
	sum(mt.Milliseconds) desc

--Vad är den sammanlagda filstorleken för all video?

select 
	FORMAT(sum(cast(mt.Bytes as bigint)) * 0.000001, '#') as 'File size of all video (MB)'
from 
	music.tracks mt
	join music.albums ma on mt.AlbumId = ma.AlbumId
	join music.artists mar on mar.ArtistId = ma.ArtistId 
where 
	mt.MediaTypeId = 3

--Vilket är det högsta antal artister som finns på en enskild spellista?

select 
	mp.PlaylistId,
	mp.Name,
	count(distinct ma.ArtistId) as 'Number of artists in playlist'
--into 
--	music.Exercise2
from 
	music.playlist_track mpt
	join music.playlists mp on mpt.PlaylistId = mpt.PlaylistId
	join music.tracks mt on mpt.TrackId = mt.TrackId
	join music.albums ma on mt.AlbumId = ma.AlbumId
where 
	mp.PlaylistId = mpt.PlaylistId
group by
	mp.PlaylistId,
	mp.Name
order by
	count(distinct ma.ArtistId) desc

--Vilket är det genomsnittliga antalet artister per spellista?

SELECT 
	FORMAT(SUM([Number of artists in playlist]) / CAST(COUNT(*) AS DECIMAl), '#') as 'Average number of artists in playlists'  
FROM 
	music.Exercise2
WHERE
    p.Name NOT IN ('Music Videos', 'TV Shows', 'Movies', 'Audiobooks')

select * from music.Exercise2
order by PlaylistId

select * from music.playlists
order by PlaylistId

-- Johannes alternative with subquery
SELECT 
    FORMAT(AVG(CAST([Unique artists] AS FLOAT)), '00.00') AS [Average unique artists per playlist]
FROM (
    SELECT
        p.PlaylistId,
        COUNT(DISTINCT a.ArtistID) AS [Unique artists]
    FROM
        music.playlists p
    LEFT JOIN music.playlist_track pt
        ON p.PlaylistId = pt.PlaylistId
    LEFT JOIN music.tracks t
        ON t.TrackId = pt.TrackId
    LEFT JOIN music.albums a
        ON t.AlbumId = a.AlbumId
    WHERE 
       p.Name NOT IN ('Music Videos', 'TV Shows', 'Movies', 'Audiobooks')
    GROUP BY
        p.PlaylistId
) AS Subquery;