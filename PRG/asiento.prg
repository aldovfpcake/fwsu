SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET EXCLUSIVE OFF
SET DELETED ON
CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
x.Seteopat(1)
SET CLASSLIB TO rh 
ms = 3
an = 2019
op= CREATEOBJECT('abretabla')
op.optabla(ms,an)
rp = CREATEOBJECT('reportesueldo')
 UPDATE repcab SET mes = op.nombres(ms),;
                      ano = an
rp.distinta = 0
rp.filtro = 0
rp.vistapre = 10
rp.reporte
*rp.descuentolegal
obas= CREATEOBJECT('asiento')
obas.validar
obas.generar
DO FOXYPREVIEWER.APP 
SELECT * FROM sue3 ORDER BY seccion,chapa INTO CURSOR sue3
REPORT FORM detalleasiento PREVIEW