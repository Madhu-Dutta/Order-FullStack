﻿/*
Deployment script for ProductDb

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar loadVar "true"
:setvar DatabaseName "ProductDb"
:setvar DefaultFilePrefix "ProductDb"
:setvar DefaultDataPath "C:\Users\Madhu\AppData\Local\Microsoft\VisualStudio\SSDT"
:setvar DefaultLogPath "C:\Users\Madhu\AppData\Local\Microsoft\VisualStudio\SSDT"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE,
                DISABLE_BROKER 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367)) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'Rename refactoring operation with key 6f4ed823-a68d-4032-abbc-fe89b9f10226 is skipped, element [dbo].[Customer].[Id] (SqlSimpleColumn) will not be renamed to CustID';


GO
PRINT N'Rename refactoring operation with key 443074aa-9b4b-4318-88c6-ba004feebc84 is skipped, element [dbo].[Product].[Id] (SqlSimpleColumn) will not be renamed to ProdID';


GO
PRINT N'Rename refactoring operation with key 4d60475a-4907-49c3-a22b-568b6e499849 is skipped, element [dbo].[Order].[Id] (SqlSimpleColumn) will not be renamed to OrderDate';


GO
PRINT N'Rename refactoring operation with key 02c319d7-c626-4ff6-87e7-3a7f126280c5 is skipped, element [dbo].[Shipping].[Id] (SqlSimpleColumn) will not be renamed to ShipMode';


GO
PRINT N'Rename refactoring operation with key f6ccb061-ad1f-473d-aae1-c478d62e2b1a is skipped, element [dbo].[Order].[ShippingMode] (SqlSimpleColumn) will not be renamed to ShipMode';


GO
PRINT N'Rename refactoring operation with key ef1d6b9b-e74f-46a2-a0ea-af3cbcd7dca1 is skipped, element [dbo].[Segment].[Id] (SqlSimpleColumn) will not be renamed to SegID';


GO
PRINT N'Rename refactoring operation with key 1a27b9cd-9807-40f8-9634-1e1ce06e7e07 is skipped, element [dbo].[Region].[Id] (SqlSimpleColumn) will not be renamed to Region';


GO
PRINT N'Rename refactoring operation with key 3c170019-09c4-435e-a23c-f07a013d14d1 is skipped, element [dbo].[Category].[Id] (SqlSimpleColumn) will not be renamed to CatID';


GO
PRINT N'Creating [dbo].[Category]...';


GO
CREATE TABLE [dbo].[Category] (
    [CatID]   INT            NOT NULL,
    [CatName] NVARCHAR (MAX) NOT NULL,
    CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED ([CatID] ASC)
);


GO
PRINT N'Creating [dbo].[Customer]...';


GO
CREATE TABLE [dbo].[Customer] (
    [CustID]   NVARCHAR (MAX) NOT NULL,
    [FullName] NVARCHAR (MAX) NULL,
    [City]     NVARCHAR (MAX) NULL,
    [Country]  NVARCHAR (MAX) NULL,
    [State]    NVARCHAR (MAX) NULL,
    [PostCode] NVARCHAR (MAX) NULL,
    [SegID]    INT            NOT NULL,
    [Region]   NVARCHAR (MAX) NOT NULL,
    CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED ([CustID] ASC)
);


GO
PRINT N'Creating [dbo].[Orders]...';


GO
CREATE TABLE [dbo].[Orders] (
    [OrderDate] DATE           NOT NULL,
    [Quantity]  NVARCHAR (MAX) NULL,
    [ShipDate]  DATE           NULL,
    [CustID]    NVARCHAR (MAX) NOT NULL,
    [ProdID]    NVARCHAR (MAX) NOT NULL,
    [ShipMode]  NVARCHAR (MAX) NOT NULL,
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([OrderDate] ASC, [CustID] ASC, [ProdID] ASC)
);


GO
PRINT N'Creating [dbo].[Product]...';


GO
CREATE TABLE [dbo].[Product] (
    [ProdID]      NVARCHAR (MAX) NOT NULL,
    [Description] NVARCHAR (MAX) NULL,
    [UnitPrice]   NVARCHAR (MAX) NULL,
    [CatID]       INT            NOT NULL,
    CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED ([ProdID] ASC)
);


GO
PRINT N'Creating [dbo].[Region]...';


GO
CREATE TABLE [dbo].[Region] (
    [Region] NVARCHAR (MAX) NOT NULL,
    CONSTRAINT [PK_Region] PRIMARY KEY CLUSTERED ([Region] ASC)
);


GO
PRINT N'Creating [dbo].[Segment]...';


GO
CREATE TABLE [dbo].[Segment] (
    [SegID]   INT            NOT NULL,
    [SegName] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_Segment] PRIMARY KEY CLUSTERED ([SegID] ASC)
);


GO
PRINT N'Creating [dbo].[Shipping]...';


GO
CREATE TABLE [dbo].[Shipping] (
    [ShipMode] NVARCHAR (MAX) NOT NULL,
    [OrderID]  NVARCHAR (MAX) NOT NULL,
    CONSTRAINT [PK_Shipping] PRIMARY KEY CLUSTERED ([ShipMode] ASC)
);


GO
PRINT N'Creating [dbo].[FK_CustomerSegment]...';


GO
ALTER TABLE [dbo].[Customer] WITH NOCHECK
    ADD CONSTRAINT [FK_CustomerSegment] FOREIGN KEY ([SegID]) REFERENCES [dbo].[Segment] ([SegID]);


GO
PRINT N'Creating [dbo].[FK_CustomerRegion]...';


GO
ALTER TABLE [dbo].[Customer] WITH NOCHECK
    ADD CONSTRAINT [FK_CustomerRegion] FOREIGN KEY ([Region]) REFERENCES [dbo].[Region] ([Region]);


GO
PRINT N'Creating [dbo].[FK_OrdersCustomer]...';


GO
ALTER TABLE [dbo].[Orders] WITH NOCHECK
    ADD CONSTRAINT [FK_OrdersCustomer] FOREIGN KEY ([CustID]) REFERENCES [dbo].[Customer] ([CustID]);


GO
PRINT N'Creating [dbo].[FK_OrdersProduct]...';


GO
ALTER TABLE [dbo].[Orders] WITH NOCHECK
    ADD CONSTRAINT [FK_OrdersProduct] FOREIGN KEY ([ProdID]) REFERENCES [dbo].[Product] ([ProdID]);


GO
PRINT N'Creating [dbo].[FK_OrdersShipping]...';


GO
ALTER TABLE [dbo].[Orders] WITH NOCHECK
    ADD CONSTRAINT [FK_OrdersShipping] FOREIGN KEY ([ShipMode]) REFERENCES [dbo].[Shipping] ([ShipMode]);


GO
PRINT N'Creating [dbo].[FK_ProductCategory]...';


GO
ALTER TABLE [dbo].[Product] WITH NOCHECK
    ADD CONSTRAINT [FK_ProductCategory] FOREIGN KEY ([CatID]) REFERENCES [dbo].[Category] ([CatID]);


GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '6f4ed823-a68d-4032-abbc-fe89b9f10226')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('6f4ed823-a68d-4032-abbc-fe89b9f10226')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '443074aa-9b4b-4318-88c6-ba004feebc84')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('443074aa-9b4b-4318-88c6-ba004feebc84')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '4d60475a-4907-49c3-a22b-568b6e499849')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('4d60475a-4907-49c3-a22b-568b6e499849')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '02c319d7-c626-4ff6-87e7-3a7f126280c5')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('02c319d7-c626-4ff6-87e7-3a7f126280c5')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f6ccb061-ad1f-473d-aae1-c478d62e2b1a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f6ccb061-ad1f-473d-aae1-c478d62e2b1a')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'ef1d6b9b-e74f-46a2-a0ea-af3cbcd7dca1')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('ef1d6b9b-e74f-46a2-a0ea-af3cbcd7dca1')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '1a27b9cd-9807-40f8-9634-1e1ce06e7e07')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('1a27b9cd-9807-40f8-9634-1e1ce06e7e07')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '3c170019-09c4-435e-a23c-f07a013d14d1')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('3c170019-09c4-435e-a23c-f07a013d14d1')

GO

GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
IF '$(loadVar)' = 'true'

BEGIN

--Drop /Delete from tables 

DELETE FROM Orders;
DELETE FROM Customer;
DELETE FROM Product;
DELETE FROM Category;
DELETE FROM Shipping;
DELETE FROM Region;
DELETE FROM Segment;

--Insert table values into tables
INSERT INTO Segment(SegID, SegName) VALUES
(1,	'Consumer'),
(2,	'Corporate'),
(3,	'Home Office');


INSERT INTO Region(Region) VALUES
('South'),
('Central'),
('West'),
('East'),
('North');

INSERT INTO Shipping(ShipMode) VALUES
('Second Class'),
('Standard Class'),
('First Class'),
('Overnight Express');

INSERT INTO Category(CatID, CatName) VALUES
(1,	'Furniture'),
(2,	'Office Supplies'),
(3,	'Technology')
;

INSERT INTO Product(ProdID, CatID, Description, UnitPrice) VALUES
('FUR-BO-10001798',	1,	'Bush Somerset Collection Bookcase',	261.96),
('FUR-CH-10000454',	3,	'Mitel 5320 IP Phone VoIP phone',	731.94),
('OFF-LA-10000240',	2,	'Self-Adhesive Address Labels for Typewriters by Universal',	14.62)
;

--INSERT INTO Customer(CustID, ) VAUES();

--INSERT INTO Orders(OrderDate, ) VALUES();

END;

GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Customer] WITH CHECK CHECK CONSTRAINT [FK_CustomerSegment];

ALTER TABLE [dbo].[Customer] WITH CHECK CHECK CONSTRAINT [FK_CustomerRegion];

ALTER TABLE [dbo].[Orders] WITH CHECK CHECK CONSTRAINT [FK_OrdersCustomer];

ALTER TABLE [dbo].[Orders] WITH CHECK CHECK CONSTRAINT [FK_OrdersProduct];

ALTER TABLE [dbo].[Orders] WITH CHECK CHECK CONSTRAINT [FK_OrdersShipping];

ALTER TABLE [dbo].[Product] WITH CHECK CHECK CONSTRAINT [FK_ProductCategory];


GO
PRINT N'Update complete.';


GO
