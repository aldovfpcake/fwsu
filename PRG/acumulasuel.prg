SET CLASSLIB TO u:\fwsu\clases\rh.vcx
SET EXCLUSIVE OFF
SET PATH TO F:\sueldos\empre1
*SET PATH TO C:\SUERUT\EMPRE1
SET DELETED ON
ws = CREATEOBJECT("abretabla")
ws.optabla(2,2017)
*ws.acumulasuel()
*ws.acumulasinvacaciones()
ws.acumulasinenfermedad()
USE SBR17
*replace ALL octubre WITH 0
BROWSE
CLOSE TABLES all