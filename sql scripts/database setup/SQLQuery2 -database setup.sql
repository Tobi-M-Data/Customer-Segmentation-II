USE RetailAnalysis;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RetailData]') AND type in (N'U'))
BEGIN
    DROP TABLE [dbo].[RetailData]
END
GO

CREATE TABLE RetailData (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    StockCode NVARCHAR(50) NOT NULL,
    Description NVARCHAR(MAX),
    Quantity INT CHECK (Quantity > 0),
    InvoiceDate DATETIME NOT NULL,
    UnitPrice DECIMAL(10,2) CHECK (UnitPrice >= 0),
    CustomerID FLOAT,
    Country NVARCHAR(100),
    TotalAmount AS (Quantity * UnitPrice) PERSISTED
);
GO