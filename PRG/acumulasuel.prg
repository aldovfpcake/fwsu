SET CLASSLIB TO c:\suerut\clasesclx\rh.vcx
SET EXCLUSIVE OFF
*SET PATH TO F:\sueldos\empre1
SET PATH TO C:\SUERUT\EMPRE3
SET DELETED ON
ws = CREATEOBJECT("abretabla")
ws.optabla(7,2015)
*ws.acumulasuel()
ws.acumulasinvacaciones()
USE sbr15
browse
CLOSE TABLES all