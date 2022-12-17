use AdventureWorks2019
go 

/*1- Crear dispositivo de backups para adventureworks2019 */

use master
go

EXEC sp_addumpdevice 'Disk', 'AwDv_nmadrizs',
'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\AwDv_nmadrizs.bak';
GO

SELECT * FROM sys.backup_devices
GO

BACKUP DATABASE AdventureWorks2019
TO AwDv_nmadrizs
WITH FORMAT, INIT, NAME = N'AdventureWorks Full Backup'

RESTORE HEADERONLY FROM AwDv_nmadrizs

EXEC sp_dropdevice 'AwDv_nmadrizs', 'delfile' 
 GO

 create procedure copiaBD @bd varchar(30), @nombrecopia varchar(30)
as 
declare @sql varchar (100)
set @sql = 'backup database ' + @bd + 'to disk=' + char(39)+'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\'+@nombrecopia+'.bak'+char(39)
exec (@sql)
go

copiaBD 'AdventureWorks2019', 'AwBk_20221317'
