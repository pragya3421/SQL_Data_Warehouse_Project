CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    v_table_start timestamptz;
    v_table_sec   numeric;

    v_batch_start timestamptz;
    v_batch_sec   numeric;
BEGIN 

    -- Batch Start Time
    v_batch_start := clock_timestamp();

    RAISE NOTICE '=======================================================';
    RAISE NOTICE 'Loading Bronze Layer';
    RAISE NOTICE '=======================================================';


    ------------------------------------------------------------------
    -- TABLE 1
    ------------------------------------------------------------------
    v_table_start := clock_timestamp();

    RAISE NOTICE '-------------------------------------------------------';
    RAISE NOTICE 'Loading CRM Tables';
    RAISE NOTICE '-------------------------------------------------------';

    RAISE NOTICE '>>Truncating Table: bronze.crm_cust_info';
    TRUNCATE TABLE bronze.crm_cust_info;

    RAISE NOTICE '>>Inserting Data into: bronze.crm_cust_info';
    COPY bronze.crm_cust_info
    FROM 'C:\Users\pragy\Downloads\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
    DELIMITER ',' CSV HEADER;

    RAISE NOTICE '>>bronze.crm_cust_info loaded successfully.';
    v_table_sec := extract(epoch FROM (clock_timestamp() - v_table_start));
    RAISE NOTICE 'Time Taken (seconds): %', v_table_sec;

    RAISE NOTICE '.......................................................';


    ------------------------------------------------------------------
    -- TABLE 2
    ------------------------------------------------------------------
    v_table_start := clock_timestamp();

    RAISE NOTICE '>>Truncating Table: bronze.crm_prd_info';
    TRUNCATE TABLE bronze.crm_prd_info;

    RAISE NOTICE '>>Inserting Data into: bronze.crm_prd_info';
    COPY bronze.crm_prd_info
    FROM 'C:\Users\pragy\Downloads\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
    DELIMITER ',' CSV HEADER;

    RAISE NOTICE '>>bronze.crm_prd_info loaded successfully.';
    v_table_sec := extract(epoch FROM (clock_timestamp() - v_table_start));
    RAISE NOTICE 'Time Taken (seconds): %', v_table_sec;

    RAISE NOTICE '.......................................................';


    ------------------------------------------------------------------
    -- TABLE 3
    ------------------------------------------------------------------
    v_table_start := clock_timestamp();

    RAISE NOTICE '>>Truncating Table: bronze.crm_sales_details';
    TRUNCATE TABLE bronze.crm_sales_details;

    RAISE NOTICE '>>Inserting Data into: bronze.crm_sales_details';
    COPY bronze.crm_sales_details
    FROM 'C:\Users\pragy\Downloads\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
    DELIMITER ',' CSV HEADER;

    RAISE NOTICE '>>bronze.crm_sales_details loaded successfully.';
    v_table_sec := extract(epoch FROM (clock_timestamp() - v_table_start));
    RAISE NOTICE 'Time Taken (seconds): %', v_table_sec;



    ------------------------------------------------------------------
    -- TABLE 4
    ------------------------------------------------------------------
    v_table_start := clock_timestamp();

    RAISE NOTICE '-------------------------------------------------------';
    RAISE NOTICE 'Loading ERP Tables';
    RAISE NOTICE '-------------------------------------------------------';

    RAISE NOTICE '>>Truncating Table: bronze.erp_cust_az12';
    TRUNCATE TABLE bronze.erp_cust_az12;

    RAISE NOTICE '>>Inserting Data into: bronze.erp_cust_az12';
    COPY bronze.erp_cust_az12
    FROM 'C:\Users\pragy\Downloads\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
    DELIMITER ',' CSV HEADER;

    RAISE NOTICE '>>bronze.erp_cust_az12 loaded successfully.';
    v_table_sec := extract(epoch FROM (clock_timestamp() - v_table_start));
    RAISE NOTICE 'Time Taken (seconds): %', v_table_sec;

    RAISE NOTICE '.......................................................';


    ------------------------------------------------------------------
    -- TABLE 5
    ------------------------------------------------------------------
    v_table_start := clock_timestamp();

    RAISE NOTICE '>>Truncating Table: bronze.erp_loc_a101';
    TRUNCATE TABLE bronze.erp_loc_a101;

    RAISE NOTICE '>>Inserting Data into: bronze.erp_loc_a101';
    COPY bronze.erp_loc_a101
    FROM 'C:\Users\pragy\Downloads\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
    DELIMITER ',' CSV HEADER;

    RAISE NOTICE '>>bronze.erp_loc_a101 loaded successfully.';
    v_table_sec := extract(epoch FROM (clock_timestamp() - v_table_start));
    RAISE NOTICE 'Time Taken (seconds): %', v_table_sec;

    RAISE NOTICE '.......................................................';


    ------------------------------------------------------------------
    -- TABLE 6
    ------------------------------------------------------------------
    v_table_start := clock_timestamp();

    RAISE NOTICE '>>Truncating Table: bronze.erp_px_cat_g1v2';
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;

    RAISE NOTICE '>>Inserting Data into: bronze.erp_px_cat_g1v2';
    COPY bronze.erp_px_cat_g1v2
    FROM 'C:\Users\pragy\Downloads\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
    DELIMITER ',' CSV HEADER;

    RAISE NOTICE '>>bronze.erp_px_cat_g1v2 loaded successfully.';
    v_table_sec := extract(epoch FROM (clock_timestamp() - v_table_start));
    RAISE NOTICE 'Time Taken (seconds): %', v_table_sec;



    ------------------------------------------------------------------
    -- BATCH TOTAL DURATION
    ------------------------------------------------------------------
    v_batch_sec := extract(epoch FROM (clock_timestamp() - v_batch_start));


    RAISE NOTICE '=======================================================';
    RAISE NOTICE 'Bronze Layer Load Completed Successfully!';
    RAISE NOTICE 'Total Batch Load Duration (seconds): %', v_batch_sec;
    RAISE NOTICE '=======================================================';

END;
$$;
