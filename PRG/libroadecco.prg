SET DATE ITALIAN
SET CENTURY ON
SET DELETED ON
SET  EXCLUSIVE OFF
PUBLIC PERIODO AS String
SET PATH TO c:\FWSU\FORMS;c:\FWSU\PRG;F:\SUELDOS\EMPRE1;F:\SUELDOS
OPEN DATABASE SUELDOS SHARED
SELECT 0
USE REPCAB AGAIN
REPLACE REPCAB.MES WITH "SETIEMBRE"
SELECT 0
USE PERSOEVENTUAL AGAIN
PERIODO = " 2019"
*REPLACE ALL FECHAING WITH CTOD("01-11-2017")
*REPLACE ALL FECHAEGRESO WITH CTOD("30-11-2017")
DO FOXYPREVIEWER.APP 
MODIFY REPORT LIBROADECCO
REPORT FORM LIBROADECCO NOCONSOLE PREVIEW

