USE RetailAnalysis;
GO

-- Drop the temp table if it exists
IF OBJECT_ID('tempdb..##StagingRetail') IS NOT NULL
    DROP TABLE ##StagingRetail;

-- Create staging table with InvoiceDate as string
CREATE TABLE ##StagingRetail
(
    InvoiceNo NVARCHAR(50),
    StockCode NVARCHAR(50),
    Description NVARCHAR(MAX),
    Quantity INT,
    InvoiceDate NVARCHAR(50),  -- Changed to NVARCHAR temporarily
    UnitPrice DECIMAL(10,2),
    CustomerID FLOAT,
    Country NVARCHAR(100)
);

-- Import using BULK INSERT
BULK INSERT ##StagingRetail
FROM 'C:\Users\Tobi\Customer Segmentation Project\Online Retail.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    CODEPAGE = '65001',
    FORMAT = 'CSV',
    MAXERRORS = 0
);

-- Insert into final RetailData table with date conversion
INSERT INTO RetailData
(
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country
)
SELECT 
    StockCode,
    Description,
    Quantity,
    TRY_CONVERT(DATETIME, InvoiceDate, 103),  -- 103 is the format for dd/mm/yyyy
    UnitPrice,
    CustomerID,
    Country
FROM ##StagingRetail
WHERE Quantity > 0 
AND UnitPrice > 0
AND TRY_CONVERT(DATETIME, InvoiceDate, 103) IS NOT NULL;

-- Verify the import
SELECT TOP 100 * FROM RetailData;
SELECT COUNT(*) as TotalRows FROM RetailData;

-- Show any rows where date conversion failed
SELECT DISTINCT InvoiceDate
FROM ##StagingRetail
WHERE TRY_CONVERT(DATETIME, InvoiceDate, 103) IS NULL;

-- Clean up
DROP TABLE ##StagingRetail;