sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO

sp_configure 'Database Mail XPs', 1;
GO
RECONFIGURE
GO

-- Create a Database Mail profile  
EXECUTE msdb.dbo.sysmail_add_profile_sp  
    @profile_name = 'Neylis M',  
    @description = 'Administrador SQL SERVER' ;  
GO

-- Grant access to the profile to the DBMailUsers role  
EXECUTE msdb.dbo.sysmail_add_principalprofile_sp  
    @profile_name = 'Neylis M',  
    @principal_name = 'public',  
    @is_default = 1 ;
GO

-- Create a Database Mail account  
EXECUTE msdb.dbo.sysmail_add_account_sp  
    @account_name = 'Neylis M',  
    @description = 'Correo',  
    @email_address = 'ney13madriz@outlook.es',  
    @display_name = 'Administrador',  
    @mailserver_name = 'smtp-mail.outlook.com',
    @port = 587,
    @enable_ssl = 1,
    @username = 'ney13madriz@outlook.es',
    @password = '********' ;  
GO

-- Add the account to the profile  
EXECUTE msdb.dbo.sysmail_add_profileaccount_sp  
    @profile_name = 'Neylis M',  
    @account_name = 'Neylis M',  
    @sequence_number =1 ;  
GO


--PARA ELIMINAR UNA CUENTA
EXECUTE msdb.dbo.sysmail_delete_profileaccount_sp @profile_name = 'Neyli Arlette Madriz'
EXECUTE msdb.dbo.sysmail_delete_principalprofile_sp @profile_name = 'Neyli Arlette Madriz'
EXECUTE msdb.dbo.sysmail_delete_account_sp @account_name = 'Neyli Arlette Madriz'
EXECUTE msdb.dbo.sysmail_delete_profile_sp @profile_name = 'Neyli Arlette Madriz'




EXEC msdb.dbo.sp_send_dbmail
     @profile_name = 'Neylis M',
     @recipients = 'ney13madriz@outlook.es',
     @body = 'Esta es una prueba que no esta fallida',
     @subject = 'La prueba no fue inexitosa';
GO

SELECT * FROM msdb.dbo.sysmail_event_log;