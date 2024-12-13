USE RetailAnalysis;
GO

-- Create filtered view for Power BI
CREATE OR ALTER VIEW vw_CleanRetailData AS
SELECT 
    TransactionID,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    TotalAmount
FROM RetailData
WHERE CustomerID IS NOT NULL;
GO

-- Create view for customer metrics
CREATE OR ALTER VIEW vw_CustomerMetrics AS
SELECT 
    rd.CustomerID,
    rfm.ClusterID,
    rfm.R_Score,
    rfm.F_Score,
    rfm.M_Score,
    clv.CLV,
    clv.Customer_Lifespan
FROM vw_CleanRetailData rd
JOIN RFM_Results rfm ON rd.CustomerID = rfm.CustomerID
JOIN CLV_Results clv ON rd.CustomerID = clv.CustomerID;
GO