# Customer Segmentation II - Complete Project Documentation

**AUTHOR: TOBI MAUTIN**  
**DATE: DECEMBER 2024**

## Executive Summary

This document offers an in-depth overview of the Customer Segmentation II project, which implements a sophisticated customer analysis system using SQL Server database engineering and Power BI analytics. The project transforms retail transaction data into actionable business intelligence through Recency, Frequency, Monetary (RFM) analysis, Customer Lifetime Value (CLV) calculations, and interactive visualizations.

## Table of Contents
- [1. Project Overview](#1-project-overview)
  - [1.1 Project Context](#11-project-context)
  - [1.2 Dataset Justification](#12-dataset-justification)
  - [1.3 Core Business Questions](#13-core-business-questions)
- [2. Business Requirements and Objectives](#2-business-requirements-and-objectives)
- [3. Technical Implementation](#3-technical-implementation)
- [4. Data Analysis Methodology](#4-data-analysis-methodology)
- [5. Analysis Implementation](#5-analysis-implementation)
- [6. Power BI Development](#6-power-bi-development)
- [7. Testing and Validation](#7-testing-and-validation)
- [8. Results and Findings](#8-results-and-findings)
- [Appendix](#appendix)

## 1. Project Overview

### 1.1 Project Context

The project addresses the need for sophisticated customer segmentation in retail business intelligence. It builds upon traditional segmentation methodologies by implementing enterprise-grade data infrastructure for scalable, production-ready analytics.

### 1.2 Dataset Justification

The analysis utilizes the 2010-2011 Online Retail dataset, chosen for its strategic value across multiple dimensions:

**Economic Context:**
- Captures consumer behavior during the post-2008 financial crisis recovery
- Provides insights into spending patterns during economic stabilization

**E-commerce Evolution:**
- Represents a crucial transition period in online retail
- Documents the emergence of multi-channel retail strategies

**Data Quality:**
- Offers a complete annual cycle with additional months
- Provides comprehensive transactional history
- Ensures statistical significance for analysis

**Market Representation:**
- Features a mid-sized UK retailer
- Includes international transactions representing a diverse customer base

### 1.3 Core Business Questions

1. **Customer Value Identification**
   - "Who are the most valuable customers and what makes them different?"
   - "What distinguishes high-value customers from others?"

2. **Customer Retention Analysis**
   - "How well are is the customer retention and who is at risk?"
   - "What are the customer retention rates across segments?"

3. **Geographic Growth Opportunities**
   - "Where should we focus the growth efforts geographically?"
   - "Which markets show the highest potential?"

4. **Customer Lifetime Value**
   - "What is the customers' lifetime value and how to improve it?"
   - "What factors influence CLV the most?"

5. **Behavioral Pattern Analysis**
   - "How do customer behaviors change over time?"
   - "What are the key purchasing patterns?"

## 2. Business Requirements and Objectives

### 2.1 Core Requirements

#### 2.1.1 Data Infrastructure

The foundation of this project rests on a robust SQL Server database implementation that ensures scalability and performance. This data infrastructure is designed with optimized storage and retrieval systems, capable of handling large volumes of transactional data while maintaining quick response times.

#### 2.1.2 Analytics Capabilities

The system implements advanced algorithms for RFM analysis and lifetime value calculations, while maintaining flexible segmentation rules that can adapt to changing business needs.

#### 2.1.3 Visualization Requirements

The visualization layer transforms complex data analyses into clear, actionable insights through interactive dashboards. These dashboards provide:
- Real-time metric updates
- Multi-dimensional analysis views
- Dynamic filtering capabilities
- Drill-down functionality

### 2.2 Project Objectives

#### 2.2.1 Primary Objectives

1. **Customer Understanding**
   - Develop deep understanding through RFM analysis
   - Track complete customer lifecycle
   - Understand value evolution factors

2. **Value Optimization**
   - Calculate and monitor customer lifetime value
   - Identify growth opportunities
   - Track segment transitions

3. **Business Intelligence**
   - Deliver actionable insights
   - Enable data-driven decision-making
   - Provide automated reporting systems

#### 2.2.2 Success Metrics

1. **Customer Metrics**
   - Total customer base: 4,338 individuals
   - Comprehensive segment distribution
   - CLV variations by segment

2. **Revenue Metrics**
   - Total revenue: £8.91M
   - Average transaction value: £22.40
   - Geographic revenue distribution

3. **Engagement Metrics**
   - 398K transactions analyzed
   - Retention rates by segment
   - Segment transition patterns

## 3. Technical Implementation

### 3.1 Database Architecture

#### 3.1.1 Database Configuration

```sql
CREATE DATABASE RetailAnalysis
ON PRIMARY
(
    NAME = RetailData,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\RetailData.mdf',
    SIZE = 2GB,
    FILEGROWTH = 512MB
)
LOG ON
(
    NAME = RetailLog,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\RetailLog.ldf',
    SIZE = 1GB,
    FILEGROWTH = 256MB
);
```

#### 3.1.2 Table Structure

The database centers around a main RetailData table with fields for:
- Primary Identifiers (TransactionID, CustomerID)
- Transaction Details (StockCode, Description, Quantity, UnitPrice)
- Temporal Data (InvoiceDate)
- Geographic Information (Country)
- Derived Metrics (TotalAmount)

#### 3.1.3 Indexing Strategy

```sql
CREATE NONCLUSTERED INDEX IX_CustomerID_RFM
ON RetailData(CustomerID)
INCLUDE (InvoiceDate, Quantity, UnitPrice);

CREATE NONCLUSTERED INDEX IX_InvoiceDate
ON RetailData(InvoiceDate);

CREATE NONCLUSTERED INDEX IX_StockCode
ON RetailData(StockCode);
```

### 3.2 Data Processing Pipeline

#### 3.2.1 Data Import Process

- Staging table implementation
- BULK INSERT procedures
- Data validation
- Error handling

#### 3.2.2 Data Cleaning Rules

- Quantity validation
- Price verification
- CustomerID management
- Date standardization

## 4. Data Analysis Methodology

### 4.1 RFM Analysis Implementation

#### 4.1.1 Base Metrics Calculation

```sql
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
)
```

#### 4.1.2 Segmentation Logic

Five distinct customer segments identified:

1. **Family Segment (21.14%)**
   - Recency Score: 4.60
   - Frequency Score: 4.72
   - Monetary Score: 4.65

2. **Loyal Customers (17.57%)**
   - Recency Score: 3.63
   - Frequency Score: 3.82
   - Monetary Score: 3.74

3. **Potential Loyalists (18.72%)**
   - Recency Score: 2.75
   - Frequency Score: 3.14
   - Monetary Score: 3.06

4. **Need Attention (24.00%)**
   - Recency Score: 2.63
   - Frequency Score: 1.78
   - Monetary Score: 2.19

5. **At Risk (18.58%)**
   - Recency Score: 1.31
   - Frequency Score: 1.69
   - Monetary Score: 1.40

### 4.2 CLV Analysis

#### 4.2.1 Calculation Method

```sql
SELECT 
    r.CustomerID,
    r.Recency,
    r.Frequency,
    r.Monetary,
    r.ClusterID,
    (r.Frequency * r.Monetary) / NULLIF(r.Recency, 0) as CLV,
    DATEDIFF(day, r.First_Purchase_Date, r.Last_Purchase_Date) as Customer_Lifespan
FROM RFM_Results r
```

#### 4.2.2 Segment Analysis

Two strategic categories identified:

**Elite Customers:**
- Average CLV: £7,948
- High retention rates
- Premium engagement levels

**Regular Customers:**
- Average CLV: £75
- Variable engagement patterns
- Growth potential

## 5. Analysis Implementation

### 5.1 RFM Analysis Implementation

Detailed SQL implementation following a multi-step approach:
1. Base metrics calculation
2. Score computation
3. Segment assignment
4. Results storage

### 5.2 CLV Calculation Implementation

Comprehensive CLV calculation incorporating:
- Purchase frequency
- Monetary value
- Customer lifespan
- Engagement recency

### 5.3 Cohort Analysis Implementation

```sql
WITH Cohorts AS (
    SELECT 
        CustomerID,
        FORMAT(MIN(InvoiceDate), 'yyyy-MM') as Cohort_Month,
        FORMAT(InvoiceDate, 'yyyy-MM') as Purchase_Month
    FROM RetailData
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID, FORMAT(InvoiceDate, 'yyyy-MM')
)
```

## 6. Power BI Development

### 6.1 Data Model

#### 6.1.1 Clean Retail Data View
```sql
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
```

#### 6.1.2 Customer Metrics View
```sql
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
```

### 6.2 Dashboard Design and Metrics

#### 6.2.1 Key Performance Indicators
- Total Transactions: 398K
- Total Revenue: £8.91M
- Average Transaction Value: £22.40
- Total Customers: 4,338

#### 6.2.2 Customer Value Analysis
- Elite Customers (21%): 917 customers, £7,948 avg CLV
- Regular Customers (79%): 3,421 customers, £75 avg CLV

### 6.3 Geographic Analysis

#### 6.3.1 Revenue Distribution
1. United Kingdom: £7,308,391.55
2. Netherlands: £285,446.34
3. EIRE: £265,545.90
4. Germany: £228,867.14
5. France: £209,024.05

#### 6.3.2 Customer Distribution
1. United Kingdom: 3,920 customers
2. Germany: 94 customers
3. France: 87 customers
4. Spain: 30 customers
5. Belgium: 25 customers

## 7. Testing and Validation

### 7.1 Data Validation
- Transaction value validation
- Segment calculation verification
- Date range consistency checks
- Geographic data validation

### 7.2 Performance Testing
- Query optimization assessment
- Dashboard performance monitoring
- Real-time update validation
- Resource utilization tracking

## 8. Results and Findings

### 8.1 Customer Segmentation Results

**Elite Customers (21% of Customer Base):**
- 917 customers
- £7,948 average CLV
- High retention rates
- Premium engagement metrics

**Regular Customers (79% of Customer Base):**
- 3,421 customers
- £75 average CLV
- Varied engagement patterns
- Growth potential

### 8.2 Geographic Analysis

**Primary Market (UK):**
- Revenue: £7,308,391.55 (82% of total)
- Customer Base: 3,920 (90% of total)
- Highest average transaction value

**Growth Markets:**
- Netherlands: £285,446.34
- EIRE: £265,545.90
- Germany: £228,867.14
- France: £209,024.05

### 8.3 Strategic Recommendations

1. **Elite Customer Retention**
   - Personalized engagement programs
   - Predictive analytics implementation
   - Exclusive service tiers
   - Direct feedback channels

2. **Regular Customer Development**
   - Targeted value enhancement programs
   - Segment transition pathways
   - Engagement acceleration initiatives
   - Automated trigger-based campaigns

3. **Geographic Expansion**
   - Strengthen UK market dominance
   - Develop Netherlands and EIRE strategies
   - Create localized marketing approaches
   - Establish regional customer service

## Appendix

### A. Technical Implementation Guide

**SQL Scripts Execution Order:**
1. Database Setup Scripts
2. Data Import Scripts
3. Analysis Scripts
4. View Creation Scripts

### B. Power BI Configuration Guide

**Connection Setup:**
1. SQL Server Connection
2. Data Model Configuration
3. Report Configuration

### C. System Maintenance Procedures

**Database Maintenance:**
- Regular index maintenance
- Performance monitoring
- Data refresh procedures
- System optimization
