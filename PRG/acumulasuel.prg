SET CLASSLIB TO c:\fwsu\clases\rh.vcx
SET EXCLUSIVE OFF
SET PATH TO F:\empre1
*SET PATH TO C:\SUERUT\EMPRE3
SET DELETED ON
ws = CREATEOBJECT("abretabla")
ws.optabla(4,2021)
*ws.acumulasuel()
ws.acumulasinvacaciones()
ws.optabla(4,2021)
ws.acumulasinenfermedad()
USE SBR21
*REPLACE JULIO WITH ACUMULA.IMPORTE FOR LEGAJO = 858
*replace ALL octubre WITH 0
BROWSE 
CLOSE TABLES all

