*aplicacion del decreto 561/19 concepto 876

SET PATH TO F:\SUELDOS\EMPRE1
SET DELETED ON
SET EXCLUSIVE OFF  
SET CLASSLIB TO c:\fwsu\clases\rh
SET PROCEDURE TO c:\fwsu\prg\classliq
x  = CREATEOBJECT("legajoper")
*tb = CREATEOBJECT("abretabla")
*tb.optabla(7,2019)
USE 82019 ALIAS LIQUIDA again
ob = CREATEOBJECT("configurar")
ob.Seteopat(1)

SELECT legajo,SUM(aporte) as sbruto FROM liquida  GROUP BY legajo HAVING SUM(aporte) <= 60000 INTO CURSOR sd
*ELECT ;
    legajo,;
    (SELECT SUM(aporte) as br FROM liquida WHERE br < 60000 GROUP BY legajo);
    from liquida into cursor sd
SELECT p.legajo,p.nombre,p.categoria,p.depart,sd.sbruto FROM personal p INNER JOIN sd ON p.legajo = sd.legajo;
WHERE  ALLTRIM(p.categoria) <> "CONDUCTOR 1RAC " .OR. ALLTRIM(p.categoria) = "DIRECTOR"  INTO CURSOR apldecret
*browse


GO top

SCAN
    SELECT legajo,concepto FROM LIQUIDA WHERE concepto = 876 .and. legajo = apldecret.legajo INTO CURSOR EXISTE
    IF EOF()
       ? "Insertando " + STR(existe.legajo,4) 
       INSERT INTO liquida(legajo,concepto,descrip, descuento,liquida) VALUES (apldecret.legajo,876,"Decrt. Beneficio 561/19",-2000,3)
    ENDIF 
    SELECT apldecret
ENDSCAN

WAIT WINDOW "Proceso Terminado"
CLOSE TABLES 
return