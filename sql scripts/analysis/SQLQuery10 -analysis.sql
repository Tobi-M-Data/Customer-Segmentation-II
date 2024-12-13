USE RetailAnalysis;
GO

WITH Cohorts AS (
    SELECT 
        CustomerID,
        FORMAT(MIN(InvoiceDate), 'yyyy-MM') as Cohort_Month,
        FORMAT(InvoiceDate, 'yyyy-MM') as Purchase_Month
    FROM RetailData
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID, FORMAT(InvoiceDate, 'yyyy-MM')
),
Cohort_Sizes AS (
    SELECT 
        Cohort_Month,
        COUNT(DISTINCT CustomerID) as Cohort_Size
    FROM Cohorts
    GROUP BY Cohort_Month
)
SELECT 
    c.Cohort_Month,
    c.Purchase_Month,
    COUNT(DISTINCT c.CustomerID) as Active_Customers,
    cs.Cohort_Size,
    CAST(COUNT(DISTINCT c.CustomerID) AS FLOAT) / cs.Cohort_Size * 100 as Retention_Rate
INTO Cohort_Analysis
FROM Cohorts c
JOIN Cohort_Sizes cs ON c.Cohort_Month = cs.Cohort_Month
GROUP BY 
    c.Cohort_Month,
    c.Purchase_Month,
    cs.Cohort_Size
ORDER BY 
    c.Cohort_Month,
    c.Purchase_Month;