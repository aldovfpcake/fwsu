SET EXCLUSIVE OFF
SET PATH TO F:\SUELDOS\EMPRE1
x = GETOBJECT("c:\suerut\listados\reintegros-ganancias.xls")


fila = 5

FOR fila = 5 TO 105
    leg = x.application.cells(fila,1).VALUE
    imp = x.application.cells(fila,3).VALUE
    ?STR(leg,4)+ " "+ STR(imp,10,2)
    SELECT  legajo,concepto FROM 42017 WHERE concepto = 653;
    AND legajo = leg AND LIQUIDA = 3 INTO CURSOR EXISTE
    
    IF EOF()
       INSERT INTO 42017(legajo,concepto,descuento,liquida);
       VALUES (leg,653,imp,3)
    ENDIF
    
NEXT    