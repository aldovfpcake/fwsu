SET EXCLUSIVE OFF
SET DELETED ON
SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET CLASSLIB TO C:\FWSU\CLASES\RH

*SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
x.Seteopat(1)

SELECT tabhoras

SCAN

   DO liquidacion-automatica
   SELECT tabhoras


ENDSCAN