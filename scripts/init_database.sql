use master;
GO
/*
	Running this script will drop the entire 'Datawarehouse' db if exists 
*/
--- Drop and rereate schemas
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWareHouse')
BEGIN
	ALTER DATABASE DataWareHouse SET SINGLE_USER WITH ROLLBACK INMEDIATE;
	DROP DATABASE DataWareHouse;
END;
GO
CREATE DATABASE DataWareHouse;
---
GO
USE DataWareHouse;
-- create schemas
GO
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO 
CREATE SCHEMA gold;
GO