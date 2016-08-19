SET CLASSLIB TO u:\fwsu\clases\rh.vcx
SET EXCLUSIVE OFF
SET PATH TO F:\sueldos\empre1
**ET PATH TO C:\SUERUT\EMPRE1
SET DELETED ON
ws = CREATEOBJECT("abretabla")
ws.optabla(7,2016)
*ws.acumulasuel()
ws.acumulasinvacaciones()
*ws.acumulasinenfermedad()
USE sbr16
browse
CLOSE TABLES all