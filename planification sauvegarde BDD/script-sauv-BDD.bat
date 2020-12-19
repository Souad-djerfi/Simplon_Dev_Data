SET JOUR=%date:~-10,2%
SET ANNEE=%date:~-4%
SET MOIS=%date:~-7,2%
SET HEURE=%time:~0,2%
SET MINUTE=%time:~3,2%
SET SECOND=%time:~-5,2%
 
if "%time:~0,1%"==" " SET HEURE=0%HEURE:~1,1%
 
SET REPERTOIR=D:\backup_BDD
 
SET FICHIER_sak=%REPERTOIR%\Sauvegarde_sakila_du_%JOUR%_%MOIS%_%ANNEE%_A_%HEURE%_%MINUTE%.sql
SET FICHIER_allBDD=%REPERTOIR%\Sauvegarde_all_BDD_du_%JOUR%_%MOIS%_%ANNEE%_A_%HEURE%_%MINUTE%.sql
 
if not exist "%REPERTOIR%" md "%REPERTOIR%"
 cd C:\Program Files\MySQL\MySQL Workbench 8.0 CE 
 mysqldump -u simplon -pSimplon2020 --databases sakila > %FICHIER_sak%
 mysqldump -u simplon -pSimplon2020 --all databases > %FICHIER_allBDD%
  
 cd C:\Program Files\MySQL\MySQL Server 8.0\bin 
 mysqlcheck -u simplon -pSimplon2020 --check sakila
 mysqlcheck -u simplon -pSimplon2020 --check --all databases  

 cd C:\Program Files\MySQL\MySQL Workbench 8.0 CE
mysqldump -u simplon -pSimplon2020 sakila_restore < %FICHIER_sak%


