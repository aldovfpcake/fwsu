SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET CLASSLIB TO C:\FWSU\CLASES\RH
SET EXCLUSIVE OFF
SET DELETED ON
CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
rh = CREATEOBJECT('legajoper')
x.Seteopat(1)
*SELECT COUNT(LEGAJO),PROVINCIA FROM PERSONAL WHERE ACTIVO ="A";
.AND. DEPART  = "LA BOCA" GROUP BY PROVINCIA ORDER BY PROVINCIA

SELECT  legajo,calcedad(fechanaci) as edad ,sexo, estudios ;
FROM PERSONAL WHERE ACTIVO ="A" .AND. DEPART = "LA BOCA" .AND. BETWEEN(calcedad(fechanaci),25,45)ORDER BY edad,estudios INTO CURSOR lis;

select COUNT(legajo),estudios FROM lis GROUP BY estudios



FUNCTION Calcedad
PARAMETERS fechanaci
ed = rh.calcuant(DATE(),fechanaci)
 

RETURN ed