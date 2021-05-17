
SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET EXCLUSIVE OFF
SET DELETED ON
CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
x.Seteopat(1)
SET CLASSLIB TO rh 
archivo = "32021"

**sql****
SELECT p.legajo,p.nombre,p.depart,s.cantidad,s.aporte-s.aporte des  FROM personal p INNER JOIN &archivo s;
ON s.legajo = p.legajo WHERE s.concepto = 20 INTO CURSOR vac READWRITE

SELECT vac
SCAN
    SELECT concepto,cantidad FROM 32021 s WHERE vac.legajo = s.legajo .and. s.liquida = 3 .and. s.concepto = 4 INTO CURSOR existe
    SELECT vac
    replace des  WITH existe.cantidad
    

ENDSCAN

SELECT vac
BROWSE TITLE "Sueldos :" + archivo