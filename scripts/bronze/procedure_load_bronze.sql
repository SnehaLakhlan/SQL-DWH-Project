/* 
======================================================================
Creation of stored procedure: Loads data into the 'bronze' schema from external CSV files. 
  It performs the following actions:
   - Truncates the bronze tables before loading data.
   - Uses the `BULK INSERT` command to load data from csv Files.
     
For Execution: EXEC bronze.load_bronze;  
=========================================================================
*/

CREATE OR ALTER PROCEDURE load_bronze AS
BEGIN 
   DECLARE @load_start_time DATETIME, @load_end_time DATETIME;
   BEGIN TRY
     SET @load_start_time = GETDATE();
     PRINT'---------------------------------------';
     PRINT'LOADING CRM TABLES';
     PRINT'---------------------------------------';

     PRINT'>> Truncating Table: bronze.crm_cust_info';
     TRUNCATE TABLE bronze.crm_cust_info;
     PRINT'>> Inserting Data: bronze.crm_cust_info';
     BULK INSERT bronze.crm_cust_info
     FROM 'D:\SQL_1\Data\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
     WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
     );

     PRINT'>> Truncating Table: bronze.crm_prd_info';
     TRUNCATE TABLE bronze.crm_prd_info;
     PRINT'>> Inserting Data: bronze.crm_prd_info';
     BULK INSERT bronze.crm_prd_info
     FROM 'D:\SQL_1\Data\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
     WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
     );

     PRINT'>> Truncating Table: bronze.crm_sales_details';
     TRUNCATE TABLE bronze.crm_sales_details;
     PRINT'>> Inserting Data: bronze.crm_sales_details';
     BULK INSERT bronze.crm_sales_details
     FROM 'D:\SQL_1\Data\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
     WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
     );
     SET @load_end_time = GETDATE();

     PRINT'TIME TAKEN TO LOAD CRM TABLES: ' + CAST(DATEDIFF(second,@load_start_time,@load_end_time) AS NVARCHAR) + 'seconds'

     PRINT'-------------------------------------------';
     PRINT'LOADING ERP TABLES';
     PRINT'-------------------------------------------';

     SET @load_start_time = GETDATE();
     PRINT'>> Truncating Table: bronze.erp_cust_az12';
     TRUNCATE TABLE bronze.erp_cust_az12;
     PRINT'>> Inserting Data: bronze.erp_cust_az12';
     BULK INSERT bronze.erp_cust_az12
     FROM 'D:\SQL_1\Data\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
     WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
     );

     PRINT'>> Truncating Table: bronze.erp_loc_a101';
     TRUNCATE TABLE bronze.erp_loc_a101;
     PRINT'>> Inserting Data: bronze.erp_loc_a101';
     BULK INSERT bronze.erp_loc_a101
     FROM 'D:\SQL_1\Data\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
     WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
     );
     
     PRINT'>> Truncating Table: bronze.erp_px_cat_g1v2';
     TRUNCATE TABLE bronze.erp_px_cat_g1v2;
     PRINT'>> Inserting Data: bronze.erp_px_cat_g1v2';
     BULK INSERT bronze.erp_px_cat_g1v2
     FROM 'D:\SQL_1\Data\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
     WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
     );
     SET @load_end_time = GETDATE();
     PRINT'TIME TAKEN TO LOAD ERP TABLES: ' + CAST(DATEDIFF(second,@load_start_time,@load_end_time) AS NVARCHAR) + 'seconds'

   END TRY
   BEGIN CATCH
     PRINT'---------------------------------------------';
     PRINT'ERROR OCCURED DURING LOADING TABLES';
     PRINT'ERROR MESSAGE:' + ERROR_MESSAGE();
     PRINT'ERROR MESSAGE:' + CAST(ERROR_NUMBER() AS NVARCHAR);
   END CATCH
END
