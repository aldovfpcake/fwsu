SET CLASSLIB TO c:\suerut\clasesclx\rh.vcx
SET EXCLUSIVE OFF
SET PATH TO F:\sueldos\empre1
*SET PATH TO C:\SUERUT\EMPRE1
SET DELETED ON
ws = CREATEOBJECT("abretabla")
ws.optabla(3,2016)
*ws.acumulasuel()
ws.acumulasinvacaciones()
USE sbr16
browse
CLOSE TABLES all