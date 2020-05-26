SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET CLASSLIB TO C:\FWSU\CLASES\RH
SET EXCLUSIVE OFF
SET DELETED ON
CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
rh = CREATEOBJECT('legajoper')
x.Seteopat(1)

SELECT LEGAJO,NOMBRE,FECHAING,rh.calcuant(DATE(),fechaing)as antg,depart,rh.calcuant(DATE(),fechanaci)as edad ;
FROM personal WHERE CATEGORIA = "CONDUCTOR 1RAC" .AND. ACTIVO = "A"