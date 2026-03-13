

/*
Set up a stored procedure to load data into the bronze layer/schema:
	When the script is ran, the bronze tables are first truncated before loading in the data
	Uses BULK INSERT to load data from the csv into the table

	Parameters:
		None. The stored procedures do not accept any parameters or return any values
	When you run the command:
		EXEC bronze.load_bronze
	The nested code will be ran

*/

/*USE DataWarehouse*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS	
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME,  @batch_end_time DATETIME ;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '==============================================';
		PRINT 'Loading Bronze Layer';
		PRINT '==============================================';
		PRINT '----------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '----------------------------------------------';

		SET @start_time = GETDATE();
		PRINT'>> Truncating Table:bronze.crm_cust_info';
				/*Perform Full Load to insert the data */
			TRUNCATE TABLE bronze.crm_cust_info;
			PRINT'>> Inserting Data into Table:bronze.crm_cust_info';

			BULK INSERT bronze.crm_cust_info
				FROM 'C:\Users\dnewt\Downloads\DWH DATA\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
				);	
			SET @end_time = GETDATE();
			PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';  
			PRINT'-------------'
			--SELECT COUNT(*) FROM bronze.crm_cust_info;



		SET @start_time = GETDATE();
		PRINT'>> Truncating Table:bronze.crm_prd_info';

			TRUNCATE TABLE bronze.crm_prd_info;
			PRINT'>> Inserting Data into Table:bronze.crm_prd_info';

			BULK INSERT bronze.crm_prd_info
				FROM 'C:\Users\dnewt\Downloads\DWH DATA\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
				);	
			SET @end_time = GETDATE();
				PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';  
				PRINT'-------------'
			--SELECT COUNT(*) FROM bronze.crm_prd_info;


		SET @start_time = GETDATE();
		PRINT'>> Truncating Table:bronze.crm_sales_details';

			TRUNCATE TABLE bronze.crm_sales_details;
			PRINT'>> Inserting Data into Table:bronze.crm_sales_details';

			BULK INSERT bronze.crm_sales_details
				FROM 'C:\Users\dnewt\Downloads\DWH DATA\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
				);	
			SET @end_time = GETDATE();
					PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';  
					PRINT'-------------'
			--SELECT COUNT(*) FROM bronze.crm_sales_details;



		SET @start_time = GETDATE();
		PRINT'>> Truncating Table:bronze.erp_cust_az12';

			TRUNCATE TABLE bronze.erp_cust_az12;
			PRINT'>> Inserting Data into Table:bronze.erp_cust_az12';

			BULK INSERT bronze.erp_cust_az12
				FROM 'C:\Users\dnewt\Downloads\DWH DATA\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
				);	
			SET @end_time = GETDATE();
						PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';  
						PRINT'-------------'
			--SELECT COUNT(*) FROM bronze.erp_cust_az12;


		SET @start_time = GETDATE();
		PRINT'>> Truncating Table:bronze.erp_loc_a101';
			TRUNCATE TABLE bronze.erp_loc_a101;
			PRINT'>> Inserting Data into Table:bronze.erp_loc_a101';
			BULK INSERT bronze.erp_loc_a101
				FROM 'C:\Users\dnewt\Downloads\DWH DATA\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
				);	
			SET @end_time = GETDATE();
						PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';  
						PRINT'-------------'
		--	SELECT COUNT(*) FROM bronze.erp_loc_a101;
	


		SET @start_time = GETDATE();
		PRINT'>> Truncating Table:bronze.erp_px_cat_g1v2';
			TRUNCATE TABLE bronze.erp_px_cat_g1v2;
			PRINT'>> Inserting Data into Table:bronze.erp_px_cat_g1v2';
			BULK INSERT bronze.erp_px_cat_g1v2
				FROM 'C:\Users\dnewt\Downloads\DWH DATA\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
				WITH (
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
				);	
			SET @end_time = GETDATE();
						PRINT '>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';  
						PRINT'-------------'


	--	SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2;
		SET @batch_end_time = GETDATE();
		PRINT '=======================================';
		PRINT 'Loading Bronze Layer is Complete';
		PRINT '   - Total Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAr) + ' Seconds';
		PRINT '=======================================';
	END TRY
	BEGIN CATCH
		PRINT '=======================================';
		PRINT 'ERROR OCCURED DURING LOADING OF BRONZE LAYER';
		PRINT 'Error Message:' + ERROR_MESSAGE();
		PRINT 'Error Message:' + CAST(ERROR_NUMBER() as NVARCHAR);
		PRINT 'Error Message:' + CAST(ERROR_STATE() as NVARCHAR);

		PRINT '=======================================';
	END CATCH
END
