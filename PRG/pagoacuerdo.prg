SET PROCEDURE TO c:\fwsu\prg\classliq
ob = CREATEOBJECT("configurar")
ob.Seteopat(1)

*SELECT LEGAJO,NOMBRE,FECHAING FROM PERSONAL WHERE ACTIVO = "A" .AND. FECHAING < CTOD("01-10-2017").AND.;
CATEGORIA <> "DIRECTOR" .AND. LEGAJO <> 19 .AND. LEGAJO <> 755 ORDER BY FECHAING INTO CURSOR LISTADOACUER

SELECT LEGAJO,NOMBRE,FECHAING FROM PERSONAL WHERE ACTIVO = "A" .AND. CATEGORIA <> "DIRECTOR" INTO CURSOR LISTADOACUER




SCAN
    SELECT CONCEPTO FROM 102019 WHERE CONCEPTO = 448 .AND. LIQUIDA = 1 .AND. LEGAJO = LISTADOACUER.LEGAJO;
    INTO CURSOR EXISTE	
    
    IF EOF()
       INSERT INTO 102019 (LEGAJO,CONCEPTO,DESCRIP,SINAPORTE,LIQUIDA) VALUES (LISTADOACUER.LEGAJO,448,"Decreto 665/19",2500,1)
    ELSE 
       UPDATE 102019 SET DESCRIP = "Decreto 665/19" ;
       WHERE LIQUIDA = 1 .AND. LEGAJO = LISTADOACUER.LEGAJO
    
       
    ENDIF
    
    SELECT LISTADOACUER




ENDSCAN

CLOSE TABLES ALL