USE RetailAnalysis;
GO

CREATE NONCLUSTERED INDEX IX_CustomerID_RFM
ON RetailData(CustomerID)
INCLUDE (InvoiceDate, Quantity, UnitPrice);

CREATE NONCLUSTERED INDEX IX_InvoiceDate
ON RetailData(InvoiceDate);

CREATE NONCLUSTERED INDEX IX_StockCode
ON RetailData(StockCode);
GO