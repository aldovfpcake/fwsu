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

*SELECT  legajo,calcedad(fechanaci) as edad ,sexo, estudios ;
FROM PERSONAL WHERE ACTIVO ="A" .AND. DEPART = "LA BOCA" .AND. BETWEEN(calcedad(fechanaci),16,24)ORDER BY edad,estudios INTO CURSOR lis;



SELECT  legajo,calcedad(fechanaci) as edad ,sexo, estudios ;
FROM PERSONAL WHERE ACTIVO ="A" .AND. DEPART = "LA BOCA" ORDER BY edad,estudios INTO CURSOR lis;

*select COUNT(legajo),estudios,sexo FROM lis GROUP BY estudios,sexo



FUNCTION Calcedad
PARAMETERS fechanaci
ed = rh.calcuant(DATE(),fechanaci)
 

RETURN ed