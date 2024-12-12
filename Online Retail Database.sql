-- Create database with appropriate size settings for your data
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
GO

-- Set recovery model to simple for better performance
ALTER DATABASE RetailAnalysis SET RECOVERY SIMPLE;
GO

-- Use the new database
USE RetailAnalysis;
GO

-- Create table for the retail data
CREATE TABLE RetailData
(
    StockCode NVARCHAR(50),
    Description NVARCHAR(MAX),
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10,2),
    CustomerID FLOAT,
    Country NVARCHAR(100)
);