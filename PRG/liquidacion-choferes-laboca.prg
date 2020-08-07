SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET CLASSLIB TO C:\FWSU\CLASES\RH
SET EXCLUSIVE OFF
SET DELETED ON
*CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
* 750 pedraza pablo
*
x=CREATEOBJECT('configurar')
x.Seteopat(1)
*borrar()
*ver()

*USE f:\sueldos\empre1\lagardi again
*SET FILTER TO LEGAJO = 816
*BROWSE
SELECT legajo,nombre FROM personal WHERE depart = "LA BOCA" .AND. CATEGORIA = "COND" .AND. ACTIVO = "A";
INTO CURSOR LISTA
SCAN
    ?STR(legajo,4) + " " + nombre
    DO lqautom-larga-la-boca WITH lista.legajo
ENDSCAN

***************
FUNCTION borrar
*****************
replace ALL knm    		WITH 0
replace ALL kmcien 		WITH 0
replace ALL ctrld  		WITH 0
replace ALL cruce  		WITH 0
replace ALL cargapel    WITH 0


*****************
FUNCTION ver
***************
SELECT p.legajo,p.nombre,l.knm,l.kmcien,l.ctrld,l.cruce,l.cargapel;
from personal p INNER JOIN lagardi l ON p.legajo = l.legajo
browse



