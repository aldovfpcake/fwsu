SET PROCEDURE TO c:\fwsu\prg\classliq
ob = CREATEOBJECT("configurar")
ob.Seteopat(1)

*SELECT LEGAJO,NOMBRE,FECHAING FROM PERSONAL WHERE ACTIVO = "A" .AND. FECHAING < CTOD("01-10-2017").AND.;
CATEGORIA <> "DIRECTOR" .AND. LEGAJO <> 19 .AND. LEGAJO <> 755 ORDER BY FECHAING INTO CURSOR LISTADOACUER

SELECT LEGAJO,NOMBRE,FECHAING FROM PERSONAL WHERE ACTIVO = "A" .AND. CATEGORIA <> "DIRECTOR" INTO CURSOR LISTADOACUER

clear


SCAN
    SELECT CONCEPTO FROM MAPER WHERE CONCEPTO = 303.AND. TIPOLIQ = 3 .AND. LEGAJO = LISTADOACUER.LEGAJO;
    INTO CURSOR EXISTE	
    
    IF EOF()
       Insert into maper ( LEGAJO, CONCEPTO, UNIDADES, IMPORTE, OBSERVA, DESCRIP, TIPOLIQ)Values(  listadoacuer.legajo, 303, 0, 0, " ", " ", 3)
    ? "INSERTANDO EN"+ STR(LISTADOACUER.LEGAJO,4)
    ENDIF 
      
    SELECT LISTADOACUER




ENDSCAN

CLOSE TABLES ALL
