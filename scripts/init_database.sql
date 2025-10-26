/*

============================
CREATE DATABASE AND SCHEMAS
============================

PURPOSE:

This script helps you create a fresh DataWareHouse database in PostgreSQL from scratch.
It first connects to the default postgres database because PostgreSQL doesn’t allow dropping or recreating a database we’re currently connected to.

Once connected, it safely terminates any active sessions using the DataWareHouse database (if it already exists), drops it, and then recreates a new one.
After that, it connects to the newly created DataWareHouse database and sets up the three standard schemas — bronze, silver and gold which represent different data layers in our data warehouse design.

NOTE: 

Running this script will permanently delete the existing DataWareHouse database along with all its data, tables and schemas. 
Make sure you have proper backups before executing it.
Double check that you are connected to the postgres database (and not DataWareHouse) before running the script. Otherwise, it won’t work.

*/

========================================================================================================================================================================
========================================================================================================================================================================


-- ============================
-- CONNECT TO POSTGRES DATABASE
-- ============================
-- We cannot drop or create a database while connected to the same one.
-- So always connect to a different database (postgres) first in PostgreSQL.
-- pgAdmin: Object Explorer → PostgreSQL 15 → Databases → postgres → Connect → Query Tool.
    

-- =========================================================
-- TERMINATE ACTIVE SESSIONS IF ANY (from postgres database)
-- =========================================================

DO
$$
BEGIN
    PERFORM pg_terminate_backend(pid)
    FROM pg_stat_activity
    WHERE datname = 'DataWareHouse'
      AND pid <> pg_backend_pid();  -- exclude current connection
END
$$;

-- ===================================================
-- DROP AND RECREATE DATABASE (from postgres database)
-- ===================================================

DROP DATABASE IF EXISTS DataWareHouse;
CREATE DATABASE DataWareHouse;


-- ========================
-- VERIFY DATABASE CREATION
-- ========================
-- pgAdmin: Object Explorer → PostgreSQL 15 → Databases → Right-click → Refresh
-- Then connect to 'DataWareHouse' → Open Query Tool

-- Check the current database
SELECT current_database();


-- =====================================
-- CREATE SCHEMAS (Bronze, Silver, Gold)
-- =====================================

CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;







