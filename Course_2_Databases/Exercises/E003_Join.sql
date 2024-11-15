use everyloop;

-- A: Company

--1: F�retagets totala produktkatalog best�r av 77 unika produkter. 
--Om vi kollar bland v�ra ordrar, hur stor andel av dessa produkter har vi n�gon g�ng leverarat till London?

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
	Format(cast(count(distinct p.ProductName) as decimal) / 77, 'P') as 'Percentage of products sold to London'
from company.orders o 
	join company.order_details od on o.id = od.OrderId
	join company.products p on p.id = od.ProductId
where ShipCity = 'London'
group by
	o.ShipCity

select 
	Format(cast(41 as decimal) / count(*), 'P') as 'Percentage of products sold to London'
from company.products

--2: Till vilken stad har vi levererat flest unika produkter?

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

--3: Av de produkter som inte l�ngre finns I v�rat sortiment, hur mycket har vi s�lt f�r totalt till Tyskland?



--4: F�r vilken produktkategori har vi h�gst lagerv�rde?

--5: Fr�n vilken leverant�r har vi s�lt flest produkter totalt under sommaren 2013?