SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET EXCLUSIVE OFF
SET DELETED ON
CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
x.Seteopat(1)
SET CLASSLIB TO rh 
ms = 10
an = 2017
op= CREATEOBJECT('abretabla')
op.optabla(ms,an)
rp = CREATEOBJECT('reportesueldo')
 UPDATE repcab SET mes = op.nombres(ms),;
                      ano = an
rp.distinta = 6
rp.vistapre = 10
rp.reporte
obas= CREATEOBJECT('asiento')
*obas.validar
obas.generar
SELECT * FROM sue3 ORDER BY seccion INTO CURSOR sue3