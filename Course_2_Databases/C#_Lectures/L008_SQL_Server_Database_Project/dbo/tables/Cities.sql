CREATE TABLE [dbo].[Cities]
(
	[Id] INT NOT NULL PRIMARY KEY, 
    [Name] NVARCHAR(50) NULL, 
    [CountryId] INT NULL, 
    CONSTRAINT [FK_Cities_Countries] FOREIGN KEY ([CountryId]) REFERENCES [Countries]([Id])
)
