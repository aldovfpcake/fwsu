SET PATH TO F:\SUELDOS\EMPRE1
SET DELETED ON
SET EXCLUSIVE OFF  
SET CLASSLIB TO c:\fwsu\clases\rh
x  = CREATEOBJECT("legajoper")
tb = CREATEOBJECT("abretabla")
sl = CREATEOBJECT("sueldosfijos")
tb.optabla(1,2019)
*SELECT 0
*USE SUELDOSFIJOS 
SELECT sueldosfijos
clear
SCAN
   ?sueldosfijos.legajo
   SELECT nombre FROM personal WHERE legajo = sueldosfijos.legajo;
   INTO CURSOR legnom

   x.sueldoneto(sueldosfijos.legajo,3)

   dif = 0
   *dif = (sueldosfijos.sueldo)/2 - x.sneto
   dif = sueldosfijos.sueldo - x.sneto
   IF dif > 100
      ? SUBSTR(legnom.nombre,1,20)+CHR(9)+STR(sueldosfijos.legajo,4) +" "+ STR(x.sneto)+ CHR(9)+STR(dif,10,2) 
   ENDIF
   SELECT sueldosfijos

ENDSCAN

CLOSE TABLES ALL
