SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET EXCLUSIVE OFF
SET DELETED ON
CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
Varmes = 6
Varano = 2020
x.Seteopat(1)
*7 Ester
SET CLASSLIB TO rh 
Obtabla = CREATEOBJECT("abretabla")
Obtabla.optabla(Varmes,Varano)
Obreporte = CREATEOBJECT("reportesueldo")
Obreporte.sindicato
