USE RetailAnalysis;
GO

-- 1. Calculate Customer Lifetime Value
WITH Customer_Value AS (
    SELECT 
        r.CustomerID,
        r.Recency,
        r.Frequency,
        r.Monetary,
        r.ClusterID,
        (r.Frequency * r.Monetary) / NULLIF(r.Recency, 0) as CLV,
        DATEDIFF(day, r.First_Purchase_Date, r.Last_Purchase_Date) as Customer_Lifespan
    FROM RFM_Results r
)
-- 2. Save CLV Results
SELECT *
INTO CLV_Results
FROM Customer_Value;

-- 3. View Top Customers by CLV
SELECT TOP 10 *
FROM CLV_Results
ORDER BY CLV DESC;

-- 4. CLV Statistics by Segment
SELECT 
    ClusterID,
    COUNT(*) as Customer_Count,
    AVG(CLV) as Avg_CLV,
    MAX(CLV) as Max_CLV,
    MIN(CLV) as Min_CLV,
    AVG(Customer_Lifespan) as Avg_Lifespan
FROM CLV_Results
GROUP BY ClusterID;