SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET EXCLUSIVE OFF
SET DELETED ON
CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
x.Seteopat(5)
SET CLASSLIB TO rh 
ms = 10
an = 2020
op= CREATEOBJECT('abretabla')
op.optabla(ms,an)
rp = CREATEOBJECT('reportesueldo')
 UPDATE repcab SET mes = op.nombres(ms),;
                      ano = an
*rp.distinta = 4
*rp.filtro = 4
rp.distinta =6
*rp.reporteportipo
*rp.sindistincion
*rp.vistapre = 10
*SET STEP ON 
*rp.reporte
*rp.descuentolegal
obas= CREATEOBJECT('asiento')
*obas.validar
obas.generar
DO FOXYPREVIEWER.APP 
SELECT * FROM sue3 ORDER BY seccion,chapa INTO CURSOR sue3
REPORT FORM detalleasiento PREVIEW