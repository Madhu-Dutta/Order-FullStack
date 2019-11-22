CREATE TABLE [dbo].[Customer]
(
	[CustID] NVARCHAR(50) NOT NULL , 
    [FullName] NVARCHAR(MAX) NULL, 
    [City] NVARCHAR(MAX) NULL, 
    [Country] NVARCHAR(MAX) NULL, 
    [State] NVARCHAR(MAX) NULL, 
    [PostCode] NVARCHAR(MAX) NULL, 
    [SegID] INT NOT NULL, 
    [Region] NVARCHAR(50) NOT NULL, 
    CONSTRAINT [PK_Customer] PRIMARY KEY ([CustID]),
    CONSTRAINT [FK_CustomerSegment] FOREIGN KEY ([SegID]) REFERENCES Segment(SegID),
    CONSTRAINT [FK_CustomerRegion] FOREIGN KEY ([Region]) REFERENCES Region(Region)
)
