CREATE TABLE [dbo].[Orders]
(
	[OrderDate] DATE NOT NULL , 
    [Quantity] NVARCHAR(MAX) NULL, 
    [ShipDate] DATE NULL, 
    [CustID] NVARCHAR(50) NOT NULL, 
    [ProdID] NVARCHAR(50) NOT NULL, 
    [ShipMode] NVARCHAR(50) NOT NULL, 
    CONSTRAINT [PK_Orders] PRIMARY KEY ([OrderDate], [CustID], [ProdID]),
    CONSTRAINT [FK_OrdersCustomer] FOREIGN KEY ([CustID]) REFERENCES Customer(CustID),
    CONSTRAINT [FK_OrdersProduct] FOREIGN KEY ([ProdID]) REFERENCES Product(ProdID),
    CONSTRAINT [FK_OrdersShipping] FOREIGN KEY ([ShipMode]) REFERENCES Shipping(ShipMode)
)
