SET CLASSLIB TO c:\fwsu\clases\rh.vcx
SET EXCLUSIVE OFF
*SET PATH TO F:\sueldos\empre1
SET PATH TO C:\SUERUT\EMPRE3
SET DELETED ON
ws = CREATEOBJECT("abretabla")
ws.optabla(1,2020)
*ws.acumulasuel()
ws.acumulasinvacaciones()
ws.optabla(1,2020)
ws.acumulasinenfermedad()
USE SBR20
*replace ALL octubre WITH 0
browse
CLOSE TABLES all

