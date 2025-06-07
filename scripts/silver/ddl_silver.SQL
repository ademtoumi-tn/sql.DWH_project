/*
    Project: DataWarehouse
    Goal: This script creates the foundational silver-layer tables for the DataWarehouse project.
    It includes CRM and ERP source tables that will serve as the basis for data integration,
    transformation, and analytical processing. These tables are categorized as:
    - CRM Customer, Product, and Sales Information
    - ERP Customer, Location, and Product Category Information
    Each table includes relevant fields and a 'created_at' timestamp for data lineage tracking.
*/

USE DataWarehouse;
GO

-- Create CRM Customer Info Table
IF OBJECT_ID('silver.crm_cust_info','U') IS NOT NULL
BEGIN
    DROP TABLE silver.crm_cust_info;
END;
CREATE TABLE silver.crm_cust_info (
    cst_id INT,
    cst_key NVARCHAR(50),
    cst_firstname NVARCHAR(50),
    cst_lastname NVARCHAR(50),
    cst_marital_status NVARCHAR(50),
    cst_gndr NVARCHAR(50),
    cst_create_date DATE,
    created_at DATETIME DEFAULT GETDATE()
);

-- Create CRM Product Info Table
IF OBJECT_ID('silver.crm_prd_info','U') IS NOT NULL
BEGIN
    DROP TABLE silver.crm_prd_info;
END;
CREATE TABLE silver.crm_prd_info (
    prd_id INT,
	cat_id NVARCHAR(50),
    prd_key NVARCHAR(50),
    prd_nm NVARCHAR(50),
    prd_cost INT,
    prd_line NVARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE,
    created_at DATETIME DEFAULT GETDATE()
);

-- Create CRM Sales Details Table
IF OBJECT_ID('silver.crm_sales_details','U') IS NOT NULL
BEGIN
    DROP TABLE silver.crm_sales_details;
END;
CREATE TABLE silver.crm_sales_details (
    sls_ord_num NVARCHAR(50),
    sls_prd_key NVARCHAR(50),
    sls_cust_id INT,
    sls_order_dt DATE, 
    sls_ship_dt DATE,
    sls_due_dt DATE,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT,
    created_at DATETIME DEFAULT GETDATE()
);

-- Create ERP Customer Table
IF OBJECT_ID('silver.erp_CUST_AZ12','U') IS NOT NULL
BEGIN
    DROP TABLE silver.erp_CUST_AZ12;
END;
CREATE TABLE silver.erp_CUST_AZ12 (
    CID NVARCHAR(50),
    BDATE DATE,
    GEN NVARCHAR(50),
    created_at DATETIME DEFAULT GETDATE()
);

-- Create ERP Location Table
IF OBJECT_ID('silver.erp_LOC_A101','U') IS NOT NULL
BEGIN
    DROP TABLE silver.erp_LOC_A101;
END;
CREATE TABLE silver.erp_LOC_A101 (
    CID NVARCHAR(50),
    CNTRY NVARCHAR(50),
    created_at DATETIME DEFAULT GETDATE()
);

-- Create ERP Product Category Table
IF OBJECT_ID('silver.erp_PX_CAT_G1V2','U') IS NOT NULL
BEGIN
    DROP TABLE silver.erp_PX_CAT_G1V2;
END;
CREATE TABLE silver.erp_PX_CAT_G1V2 (
    ID NVARCHAR(50),
    CAT NVARCHAR(50),
    SUBCAT NVARCHAR(50),
    MAINTENANCE NVARCHAR(50),
    created_at DATETIME DEFAULT GETDATE()
);
