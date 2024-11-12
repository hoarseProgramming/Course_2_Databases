
select 
	*,
	UPPER([Airport name]) as 'upper',
	LEFT([Airport name], 5) as '5letters'

from Airports where IATA = 'GOT';