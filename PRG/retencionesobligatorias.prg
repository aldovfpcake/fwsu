
SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET CLASSLIB TO C:\FWSU\CLASES\RH
SET EXCLUSIVE OFF
SET DELETED ON
CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
rh = CREATEOBJECT('legajoper')
x.Seteopat(1)
SELECT s.legajo,s.descuento,c.clase FROM 12018 s INNER JOIN codsuel c;
ON s.concepto = c.concepto where c.clase  = 1 order BY legajo into cursor retleg

SELECT LEGAJO,SUM(DESCUENTO) as desc FROM retleg group by legajo into cursor legaxret
SUM desc TO vv
?vv