/*
==========================================================================================
Stored Procedure: Load Bronze Layer (Source --> Bronze)
==========================================================================================

Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    Performs below actions:
        -Truncate the bronze tables before loading data.
        -Use the 'BULK INSERT' command to load data from CSV files to bronze tables.

Parameters: 
    None. This stored procedure does not accept any parameters or return any values.

Example:
    EXEC bronze.load_bronze
==========================================================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME , @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
/*
========================
BULK INSERT - CRM TABLE
========================
*/
		SET @batch_start_time = GETDATE();
		PRINT '=================================================';
		PRINT 'Loading Bronze layer';
		PRINT '=================================================';


		PRINT '-------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '-------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>>>Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE  bronze.crm_cust_info

		PRINT '>>>Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM '/var/opt/mssql/data/source_crm/cust_info.csv'
		WITH 
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();
		PRINT '>>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR) + ' Seconds';
		PRINT '>>>--------------------------';


		--
		SET @start_time = GETDATE();
		PRINT '>>>Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE  bronze.crm_prd_info

		PRINT '>>>Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM '/var/opt/mssql/data/source_crm/prd_info.csv'
		WITH 
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>>Load Duration:  ' + CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR) + ' Seconds';
		PRINT '>>>--------------------------';

		--
		SET @start_time = GETDATE();
		PRINT '>>>Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE  bronze.crm_sales_details

		PRINT '>>>Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM '/var/opt/mssql/data/source_crm/sales_details.csv'
		WITH 
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>>Load Duration:  ' + CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR) + ' Seconds';
		PRINT '>>>--------------------------';


		/*
		========================
		BULK INSERT - ERP TABLE
		========================
		*/

		PRINT '-------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '-------------------------------------------------';


		SET @start_time = GETDATE();
		PRINT '>>>Truncating Table: bronze.erp_CUST_AZ12';
		TRUNCATE TABLE  bronze.erp_CUST_AZ12

		PRINT '>>>Inserting Data Into: bronze.erp_CUST_AZ12';
		BULK INSERT bronze.erp_CUST_AZ12
		FROM '/var/opt/mssql/data/source_erp/CUST_AZ12.csv'
		WITH 
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>>Load Duration:  ' + CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR) + ' Seconds';
		PRINT '>>>--------------------------';

		--
		SET @start_time = GETDATE();
		PRINT '>>>Truncating Table: bronze.erp_LOC_A101';
		TRUNCATE TABLE  bronze.erp_LOC_A101

		PRINT '>>>Inserting Data Into: bronze.erp_LOC_A101';
		BULK INSERT bronze.erp_LOC_A101
		FROM '/var/opt/mssql/data/source_erp/LOC_A101.csv'
		WITH 
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>>Load Duration:  ' + CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR) + ' Seconds';
		PRINT '>>>--------------------------';

		--
		SET @start_time = GETDATE();
		PRINT '>>>Truncating Table: bronze.erp_PX_CAT_G1V2';
		TRUNCATE TABLE  bronze.erp_PX_CAT_G1V2

		PRINT '>>>Inserting Data Into: bronze.erp_PX_CAT_G1V2';
		BULK INSERT bronze.erp_PX_CAT_G1V2
		FROM '/var/opt/mssql/data/source_erp/PX_CAT_G1V2.csv'
		WITH 
		(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>>Load Duration:  ' + CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR) + ' Seconds';
		PRINT '>>>--------------------------';


		SET @batch_end_time = GETDATE(); 
		PRINT '==========================================================';
		PRINT 'Loading Bronze Layer is Complete.';
		PRINT '		- Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' Seconds';
		PRINT '==========================================================';

	END TRY
	BEGIN CATCH
		PRINT '==========================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'ERROR Message' + ERROR_MESSAGE();
		PRINT 'ERROR Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================================='
	END CATCH
END

