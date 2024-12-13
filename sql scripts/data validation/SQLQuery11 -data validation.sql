-- Check for null CustomerIDs
SELECT 
    COUNT(*) as TotalRows,
    COUNT(CustomerID) as RowsWithCustomerID,
    COUNT(*) - COUNT(CustomerID) as NullCustomerIDs
FROM RetailData;

-- Check a sample of rows with null CustomerIDs
SELECT TOP 100 *
FROM RetailData
WHERE CustomerID IS NULL;