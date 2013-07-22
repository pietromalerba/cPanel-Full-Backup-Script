cPanel Full Backup Script v1.0
==============================

Setup (2 steps)
-----

### config.php (for perform_cpanel_fullbackup.php)
Setup cPanel connect:

* Server adress
* Server Username
* Server Password

FTP server is optionally (for replicate the backup).



### Backup.sh
Control the number of backups and the dir for the backups:

* Max_Backups
* Backup_Folder (parameter)

With this method can manage various types of backup while (weekly, monthly,...)


### How to run it 

1. Unzip and upload on your FTP server
2. Run backup.sh for Cron with parameter for the backup folder


#### Example

File setup:

	/backups
		../backup_daily/
		../backups_monthly/
		../xmlapi-php/
		config.php
		perform_cpanel_fullbackup.php
		worpit_cpanel_base.php
		
Crontab:

``backup.sh backup_daily``  

``backup.sh backup_monthly``



