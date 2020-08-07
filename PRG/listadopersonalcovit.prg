SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET CLASSLIB TO C:\FWSU\CLASES\RH
SET EXCLUSIVE OFF
SET DELETED ON
CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
rh = CREATEOBJECT('legajoper')
x.Seteopat(1)

SELECT p.LEGAJO,p.NOMBRE,p.FECHAING,rh.calcuant(DATE(),p.fechaing)as antg,p.depart,rh.calcuant(DATE(),p.fechanaci)as edad ;
FROM personal p INNER JOIN 42020 liquida ON p.legajo = liquida.legajo WHERE liquida.concepto=308