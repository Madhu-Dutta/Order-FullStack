CREATE TABLE [dbo].[Product]
(
	[ProdID] NVARCHAR(50) NOT NULL , 
    [Description] NVARCHAR(MAX) NULL, 
    [UnitPrice] NVARCHAR(MAX) NULL, 
    [CatID] INT NOT NULL, 
    CONSTRAINT [PK_Product] PRIMARY KEY ([ProdID]),
	CONSTRAINT [FK_ProductCategory] FOREIGN KEY (CatID) REFERENCES Category(CatID)
)
