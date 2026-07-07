-- EXEC bronze.load_bronze

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @start_time_batch DATETIME, @end_time_batch DATETIME
    BEGIN TRY
    SET @start_time_batch = GETDATE() 
   -- 1. lOAD crm_custom_info
        PRINT('======================')
        PRINT('Load Bronze Layer')
        PRINT('======================')
        PRINT '---------------'
        PRINT 'LOAD CRM TABLES'
        PRINT '---------------'
        SET @start_time =GETDATE()

        PRINT '>>Truncating Table: bronze.crm_custom_info'
        TRUNCATE TABLE bronze.crm_custom_info
        PRINT '>>Inserting Data into: bronze.crm_custom_info'
        BULK INSERT bronze.crm_custom_info
        from 'C:\Users\wlady_PC\Documents\Data-engineering\DWH_project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK -- improve performance
        );
        SET @end_time = GETDATE();
        PRINT '>>Load Duration:' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'secs'
        PRINT '---------------'

        --- 2. Load crm_prd_info

        SET @start_time = GETDATE()
        PRINT '>>Truncating Table: bronze.crm_prd_info'
        TRUNCATE TABLE bronze.crm_prd_info

        PRINT '>>Inserting Data into: bronze.crm_prd_info'
        BULK INSERT bronze.crm_prd_info

        from 'C:\Users\wlady_PC\Documents\Data-engineering\DWH_project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK -- improve performance
        );
        SET @end_time = GETDATE()
        PRINT '>>Load Duration:' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'secs'
        PRINT '---------------'


        --- 3. Load crm_sales_details
        SET @start_time = GETDATE()
        PRINT '>>Truncating Table: bronze.crm_sales_details'

        TRUNCATE TABLE bronze.crm_sales_details
        PRINT '>>Inserting Data into: bronze.crm_sales_details'

        BULK INSERT bronze.crm_sales_details
        from 'C:\Users\wlady_PC\Documents\Data-engineering\DWH_project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK -- improve performance
        );
        SET @end_time = GETDATE()
        PRINT 'Load duration: ' + CAST (DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'secs'
        PRINT '---------------'

        PRINT '---------------'
        PRINT 'LOAD ERP TABLES'
        PRINT '---------------'
        ---4. Load erp_cust_az12

        PRINT '>>Truncating Table: bronze.erp_cust_az12'

        TRUNCATE TABLE bronze.erp_cust_az12
        PRINT '>>Inserting Data into: bronze.erp_cust_az12'

        BULK INSERT bronze.erp_cust_az12
        from 'C:\Users\wlady_PC\Documents\Data-engineering\DWH_project\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK -- improve performance
        );



        --- 5. Load erp_loc_a101
        PRINT '>>Truncating Table: bronze.erp_loc_a101'

        TRUNCATE TABLE bronze.erp_loc_a101
        PRINT '>>Inserting Data into: bronze.erp_loc_a101'
        BULK INSERT bronze.erp_loc_a101
        from 'C:\Users\wlady_PC\Documents\Data-engineering\DWH_project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK -- improve performance
        );



        --- 6. load erp_px_cat_g1v2
        PRINT '>>Truncating Table: bronze.erp_px_cat_g1v2'
        TRUNCATE TABLE bronze.erp_px_cat_g1v2
        PRINT '>>Inserting Data into: bronze.erp_px_cat_g1v2'
        BULK INSERT bronze.erp_px_cat_g1v2
        from 'C:\Users\wlady_PC\Documents\Data-engineering\DWH_project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK -- improve performance
    );
    SET @end_time_batch = GETDATE()
    PRINT '=============='
    PRINT 'TOTAL BRONZE DURATION: ' + CAST( DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR )
    PRINT '=============='

    END TRY
    BEGIN CATCH
        PRINT '==============================';
        PRINT 'ERROR OCCURED DURING BRONZE LOAD';
        PRINT 'Error Message' + ERROR_MESSAGE();
        PRINT 'Error Meesage' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error Meesage' + CAST(ERROR_STATE() AS NVARCHAR);


        PRINT '=============================='


    END CATCH

END
