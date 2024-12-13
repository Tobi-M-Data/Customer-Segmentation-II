USE RetailAnalysis;
GO

-- 1. First create RFM base calculations
WITH RFM_Base AS (
    SELECT 
        CustomerID,
        DATEDIFF(day, MAX(InvoiceDate), '2011-12-31') as Recency,
        COUNT(DISTINCT InvoiceDate) as Frequency,
        SUM(TotalAmount) as Monetary,
        MAX(InvoiceDate) as Last_Purchase_Date,
        MIN(InvoiceDate) as First_Purchase_Date
    FROM RetailData
    WHERE 
        CustomerID IS NOT NULL 
        AND TotalAmount > 0
    GROUP BY CustomerID
),
-- 2. Calculate RFM Scores
RFM_Scores AS (
    SELECT 
        *,
        NTILE(5) OVER (ORDER BY Recency DESC) as R_Score,
        NTILE(5) OVER (ORDER BY Frequency) as F_Score,
        NTILE(5) OVER (ORDER BY Monetary) as M_Score
    FROM RFM_Base
),
-- 3. Add Cluster Analysis
Customer_Segments AS (
    SELECT 
        *,
        CASE 
            WHEN (R_Score >= 4 AND F_Score >= 4 AND M_Score >= 4) THEN 1  -- High-value active customers
            ELSE 0  -- Low-value inactive customers
        END as ClusterID
    FROM RFM_Scores
)
-- 4. Save results for further analysis
SELECT *
INTO RFM_Results
FROM Customer_Segments;

-- 5. View segment profiles
SELECT 
    ClusterID,
    COUNT(*) as CustomerCount,
    AVG(Recency) as Avg_Recency,
    AVG(Frequency) as Avg_Frequency,
    AVG(Monetary) as Avg_Monetary,
    MAX(Monetary) as Max_Monetary,
    MIN(Monetary) as Min_Monetary
FROM RFM_Results
GROUP BY ClusterID;