Customer Segmentation II
Introduction
This project represents an advanced implementation of customer segmentation analysis using SQL Server database engineering and Power BI visualization. Building upon traditional segmentation methodologies, this version leverages enterprise-grade data infrastructure to provide scalable, production-ready customer analytics. The project aims to transform raw transactional data into actionable business intelligence through sophisticated RFM analysis, customer lifetime value calculations, and interactive dashboards.

Dataset Justification
The project utilizes the "Online Retail" dataset spanning 2010-2011 from a UK-based online retail company. This specific dataset was chosen for several strategic reasons:

Economic Context: This period captures consumer behavior during the post-2008 financial crisis recovery, providing valuable insights into customer spending patterns during economic stabilization.
E-commerce Evolution: 2010-2011 marked a significant transition in online retail, as businesses were adopting multi-channel strategies. This dataset captures customer behavior during this crucial evolutionary period.
Data Quality: The dataset provides a complete annual cycle plus additional months, allowing for:

Full year-over-year comparisons
Holiday season analysis
Seasonal trend identification
Sufficient time span for meaningful customer lifetime value calculations


Market Representation: The data comes from a mid-sized UK retailer with international transactions, making it relevant for both local and global market analysis.

Technical Architecture
Database Infrastructure

SQL Server implementation with optimized storage configuration
Structured tables with appropriate constraints and computed columns
Strategic indexing for performance optimization
Views for streamlined Power BI integration

Analytics Pipeline

Data Ingestion & Cleaning

Bulk import procedures
Data validation and quality checks
Null handling and data standardization


Customer Analytics

RFM (Recency, Frequency, Monetary) analysis
Customer Lifetime Value calculations
Cohort analysis and retention metrics


Business Intelligence

Interactive Power BI dashboards
Geographic revenue analysis
Customer segment visualization
Performance metrics tracking



Implementation Components
Database Design

Optimized table structures
Computed columns for derived metrics
Indexed views for reporting efficiency
Data quality constraints

Analysis Features

RFM Analysis

Recency scoring
Frequency calculation
Monetary value assessment
Customer segmentation logic


CLV Implementation

Customer lifetime tracking
Value calculation algorithms
Segment-based analysis


Cohort Analysis

Monthly cohort tracking
Retention rate calculations
Customer activity monitoring



Power BI Dashboard

Customer segment distribution
Geographic revenue mapping
Key performance metrics
Trend analysis visualizations

Key Metrics

Total Customers: 4,338
Total Revenue: £8.91M
Average Transaction Value: £22.40
Total Transactions: 398K

Customer Segments

Elite Customers (21%)

Average CLV: £7,948
High retention rate
Premium engagement metrics


Regular Customers (79%)

Average CLV: £75
Varied engagement levels
Growth potential identification



Installation Requirements
Database Setup

SQL Server 2016 or later
Minimum 4GB storage
SQL Server Management Studio

Visualization Tools

Power BI Desktop
Latest updates installed

Setup Instructions

Database Creation

sqlCopy-- Execute scripts in order:
1. database_setup/
2. data_import/
3. analysis/
4. views/

Power BI Configuration


Connect to SQL views
Refresh data model
Configure parameters

Usage Guide

Execute SQL scripts in specified order
Import Power BI template
Connect to database
Refresh visualizations

Contributing
Contributions are welcome. Please fork the repository and submit pull requests for any enhancements.
License
MIT License
Copyright (c) 2024 Tobi-M-Data
Contact
tobimautin@gmail.com
