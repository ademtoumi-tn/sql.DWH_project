/*
=======================================
SQL Script: Bronze Layer Table Creation
Purpose:
This script is intended for initializing the "bronze" layer in a Data Warehouse environment.
It checks for the existence of staging tables used for CRM and ERP data ingestion. 
If the tables already exist, it drops and recreates them with defined schemas. 

Target: GitHub publication and community sharing
=======================================
*/

USE DataWarehouse;
GO

-- Create CRM Customer Info Table
IF OBJECT_ID('bronze.crm_cust_info','U') IS NOT NULL
BEGIN
    DROP TABLE bronze.crm_cust_info;
END;
CREATE TABLE bronze.crm_cust_info (
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE
);

-- Create CRM Product Info Table
IF OBJECT_ID('bronze.crm_prd_info','U') IS NOT NULL
BEGIN
    DROP TABLE bronze.crm_prd_info;
END;
CREATE TABLE bronze.crm_prd_info (
    prd_id INT,
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE
);

-- Create CRM Sales Details Table
IF OBJECT_ID('bronze.crm_sales_details','U') IS NOT NULL
BEGIN
    DROP TABLE bronze.crm_sales_details;
END;
CREATE TABLE bronze.crm_sales_details (
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
    sls_order_dt INT,  -- Dates stored as INT (e.g., yyyymmdd)
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);

-- Create ERP Customer Table
IF OBJECT_ID('bronze.erp_CUST_AZ12','U') IS NOT NULL
BEGIN
    DROP TABLE bronze.erp_CUST_AZ12;
END;
CREATE TABLE bronze.erp_CUST_AZ12 (
    CID NVARCHAR(50),
    BDATE DATE,
    GEN NVARCHAR(50)
);

-- Create ERP Location Table
IF OBJECT_ID('bronze.erp_LOC_CUST_A101','U') IS NOT NULL
BEGIN
    DROP TABLE bronze.erp_LOC_CUST_A101;
END;
CREATE TABLE bronze.erp_LOC_CUST_A101 (
    CID NVARCHAR(50),
    CNTRY NVARCHAR(50)
);

-- Create ERP Product Category Table
IF OBJECT_ID('bronze.erp_PX_CAT_G1V2','U') IS NOT NULL
BEGIN
    DROP TABLE bronze.erp_PX_CAT_G1V2;
END;
CREATE TABLE bronze.erp_PX_CAT_G1V2 (
    ID NVARCHAR(50),
    CAT NVARCHAR(50),
    SUBCAT NVARCHAR(50),
    MAINNTENANCE NVARCHAR(50)
);
