SET CLASSLIB TO u:\fwsu\clases\rh.vcx
SET EXCLUSIVE OFF
SET PATH TO F:\sueldos\empre1
*SET PATH TO C:\SUERUT\EMPRE3
SET DELETED ON
ws = CREATEOBJECT("abretabla")
ws.optabla(12,2016)
*ws.acumulasuel()
*ws.acumulasinvacaciones()

ws.acumulasinenfermedad()
USE SBR16
*replace ALL octubre WITH 0
BROWSE
CLOSE TABLES all