SET TALK OFF
SET EXCLUSIVE OFF
SET DATE ITALIAN
SET REPROCESS TO AUTOMATIC
SET MULTILOCKS ON
SET DELETED ON
*SET PATH TO t:\FWSU\FORMS;t:\FWSU\PRG;F:\FWSU\CLASES;F:\SUELDOS\EMPRE1;F:\SUELDOS
SET PROCEDURE TO T:\fwsu\prg\classliq
ob = CREATEOBJECT("configurar")
ob.Seteo
ob.Seteopat(1)
USE viewbaseliq nodata
DO FORM formlqbase WITH 14,3
