SET CLASSLIB TO c:\fwsu\clases\rh.vcx
SET EXCLUSIVE OFF
SET PATH TO F:\sueldos\empre2
*SET PATH TO C:\SUERUT\EMPRE3
SET DELETED ON
ws = CREATEOBJECT("abretabla")
ws.optabla(8,2020)
*ws.acumulasuel()
ws.acumulasinvacaciones()
ws.optabla(8,2020)
ws.acumulasinenfermedad()
USE SBR20
*REPLACE JULIO WITH ACUMULA.IMPORTE FOR LEGAJO = 858
*replace ALL octubre WITH 0
BROWSE 
CLOSE TABLES all

