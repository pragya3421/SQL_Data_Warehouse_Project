----Creating SQL DDL Scripts for ALL CSV Files in the CRM & ERP Systems.

/*
===========================================
Bronze Rules
===========================================

- All names must start with the source system name.
- Table names must match their original names (no renaming).

Naming Convention:
    <sourcesystem>_<entity>

    <sourcesystem> : Name of the source system (e.g., crm, erp)
    <entity>       : Exact table name from the source system

Example:
    crm_customer_info → Customer information from the CRM system

Notes:
- Bronze layer stores raw data
- No transformations should be applied
- Maintains source system lineage

===========================================
*/



--------------------------------------------------
-- Bronze Tables (RAW LAYER)
--------------------------------------------------

IF OBJECT_ID ('bronze.crm_cust_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info
(
cst_id INT,
cst_key NVARCHAR(50),
cst_firstname NVARCHAR(50),
cst_lastname NVARCHAR(50),
cst_marital_status NVARCHAR(50),
cst_gndr NVARCHAR(50),
cst_create_date DATE
);


IF OBJECT_ID ('bronze.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info
(
prd_id INT,
prd_key NVARCHAR(50),
prd_nm NVARCHAR(50),
prd_cost INT,
prd_line NVARCHAR(50),
prd_start_dt DATETIME,
prd_end_dt DATETIME
);


IF OBJECT_ID ('bronze.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details
(
sls_ord_num NVARCHAR(50),
sls_prd_key NVARCHAR(50),
sls_cust_id INT,
sls_order_dt INT,
sls_ship_dt INT,
sls_due_dt INT,
sls_sales INT,
sls_quantity INT,
sls_price INT
);


IF OBJECT_ID ('bronze.erp_LOC_A101', 'U') IS NOT NULL
	DROP TABLE bronze.erp_LOC_A101;
CREATE TABLE bronze.erp_LOC_A101
(
CID NVARCHAR(50),
CNTRY NVARCHAR(50)
);



IF OBJECT_ID ('bronze.erp_CUST_AZ12', 'U') IS NOT NULL
	DROP TABLE bronze.erp_CUST_AZ12;
CREATE TABLE bronze.erp_CUST_AZ12
(
CID NVARCHAR(50),
BDATE DATE,
GEN NVARCHAR(50)
);



IF OBJECT_ID ('bronze.erp_PX_CAT_G1V2', 'U') IS NOT NULL
	DROP TABLE bronze.erp_PX_CAT_G1V2;
CREATE TABLE bronze.erp_PX_CAT_G1V2
(
ID NVARCHAR(50),
CAT NVARCHAR(50),
SUBCAT NVARCHAR(50),
MAINTENANCE NVARCHAR(50)
);

GO


/*
========================
BULK INSERT - CRM TABLE
========================
*/

--
TRUNCATE TABLE  bronze.crm_cust_info
BULK INSERT bronze.crm_cust_info
FROM '/var/opt/mssql/data/source_crm/cust_info.csv'
WITH 
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);


--

TRUNCATE TABLE  bronze.crm_prd_info
BULK INSERT bronze.crm_prd_info
FROM '/var/opt/mssql/data/source_crm/prd_info.csv'
WITH 
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);


--

TRUNCATE TABLE  bronze.crm_sales_details
BULK INSERT bronze.crm_sales_details
FROM '/var/opt/mssql/data/source_crm/sales_details.csv'
WITH 
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);



/*
========================
BULK INSERT - ERP TABLE
========================
*/

--

TRUNCATE TABLE  bronze.erp_CUST_AZ12
BULK INSERT bronze.erp_CUST_AZ12
FROM '/var/opt/mssql/data/source_erp/CUST_AZ12.csv'
WITH 
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);


--

TRUNCATE TABLE  bronze.erp_LOC_A101
BULK INSERT bronze.erp_LOC_A101
FROM '/var/opt/mssql/data/source_erp/LOC_A101.csv'
WITH 
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);



--

TRUNCATE TABLE  bronze.erp_PX_CAT_G1V2
BULK INSERT bronze.erp_PX_CAT_G1V2
FROM '/var/opt/mssql/data/source_erp/PX_CAT_G1V2.csv'
WITH 
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);

