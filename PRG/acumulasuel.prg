SET CLASSLIB TO c:\fwsu\clases\rh.vcx
SET EXCLUSIVE OFF
*SET PATH TO F:\sueldos\empre1
SET PATH TO C:\SUERUT\EMPRE1
SET DELETED ON
ws = CREATEOBJECT("abretabla")
ws.optabla(4,2019)
*ws.acumulasuel()
ws.acumulasinvacaciones()
ws.optabla(4,2019)
ws.acumulasinenfermedad()
USE SBR19
*replace ALL octubre WITH 0
browse
CLOSE TABLES all