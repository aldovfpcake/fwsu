SET PROCEDURE TO c:\fwsu\prg\classliq
ob = CREATEOBJECT("configurar")
ob.Seteopat(1)

SELECT LEGAJO,NOMBRE,FECHAING FROM PERSONAL WHERE ACTIVO = "A" .AND. FECHAING < CTOD("01-10-2017").AND.;
CATEGORIA <> "DIRECTOR" .AND. LEGAJO <> 19 ORDER BY FECHAING INTO CURSOR LISTADOACUER

SCAN
    SELECT CONCEPTO FROM 32018 WHERE CONCEPTO = 355 .AND. LIQUIDA = 4 .AND. LEGAJO = LISTADOACUER.LEGAJO;
    INTO CURSOR EXISTE	
    
    IF EOF()
       INSERT INTO 32018 (LEGAJO,CONCEPTO,SINAPORTE,LIQUIDA) VALUES (LISTADOACUER.LEGAJO,355,2500,4)
    ELSE 
       UPDATE 32018 SET DESCRIP = "Acrdo. No Remu.Cta 1" ;
       WHERE LIQUIDA = 4 .AND. LEGAJO = LISTADOACUER.LEGAJO
    
       
    ENDIF
    
    SELECT LISTADOACUER




ENDSCAN

CLOSE TABLES ALL