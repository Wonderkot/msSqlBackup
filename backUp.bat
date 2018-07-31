:: ###### BACK-UP JOB ######
@ECHO OFF

:: Set the constants
SET BACKUP_DIR=C:\db
SET TEMP_DIR=%BACKUP_DIR%\TEMP
SET TODAY=%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%
SET ARCHIVE_DIR=%BACKUP_DIR%\%TODAY%
SET /P MSSQL_NAME= Input Database Name: 
SET MSSQL_TEMP=%TEMP_DIR%\%MSSQL_NAME%.bak


:: Create a new archive/back-up folder
ECHO Creating the backup folder '%BACKUP_DIR%'
ECHO.
MKDIR %BACKUP_DIR%
ECHO Done.
ECHO.

ECHO Creating temp folder '%TEMP_DIR%'
ECHO.
MKDIR %TEMP_DIR%
ECHO Done.
ECHO.


::
:: ###### MS-SQL BACK-UP #####
::

:: Back-up the MS-SQL database to the temporary folder
ECHO Backing-up the MS-SQL database to '%MSSQL_TEMP%'
ECHO.
sqlcmd -S localhost -Q "BACKUP DATABASE %MSSQL_NAME% TO DISK='%MSSQL_TEMP%' WITH FORMAT"
:: TODO: The other MS-SQL databases
ECHO Done.
ECHO.

:: 7z the MS-SQL back-up file in the archive folder
ECHO Using 7-Zip to compress the MS-SQL database '%MSSQL_TEMP%'
ECHO.
"C:\Program Files\7-Zip\7z.exe" a -t7z %BACKUP_DIR%\%MSSQL_NAME%.7z %MSSQL_TEMP%
ECHO Done.
ECHO.

:: Delete the MS-SQL back-up file from the temporary folder
ECHO Deleting the MS-SQL back-up file '%MSSQL_TEMP%'
ECHO.
DEL /Q %MSSQL_TEMP%
ECHO Done.
ECHO.



::
:: ###### HOUSE-CLEANING #####
::

:: Delete the temporary folder
ECHO Deleting the temporary folder '%TEMP_DIR%'
ECHO.
DEL /Q %TEMP_DIR%
ECHO Done.
ECHO.



ECHO.
PAUSE
