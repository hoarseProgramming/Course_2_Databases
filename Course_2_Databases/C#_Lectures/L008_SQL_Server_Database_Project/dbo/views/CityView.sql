CREATE VIEW [dbo].[CityView] AS
SELECT 
	[ci].[Id], 
	[ci].[Name] AS 'City', 
	[ci].[CountryId],
	[co].[Name] AS 'Country'
FROM 
	[dbo].[Cities] ci
	left join [dbo].[Countries] co on ci.CountryId = co.Id

