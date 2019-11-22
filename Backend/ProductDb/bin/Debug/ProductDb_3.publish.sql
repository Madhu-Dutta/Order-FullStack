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
/*
The column [dbo].[Shipping].[OrderID] is being dropped, data loss could occur.
*/

IF EXISTS (select top 1 1 from [dbo].[Shipping])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Altering [dbo].[Shipping]...';


GO
ALTER TABLE [dbo].[Shipping] DROP COLUMN [OrderID];


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
PRINT N'Update complete.';


GO
