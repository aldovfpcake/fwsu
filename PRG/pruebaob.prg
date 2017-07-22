SET PATH TO F:\SUELDOS\EMPRE1
SET DELETED ON
SET EXCLUSIVE OFF  
SET PROCEDURE TO c:\fwsu\prg\informelargad.prg 
x = CREATEOBJECT("reportesueldo")
x.reporte
SELECT sue3
browse