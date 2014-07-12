 SELECT * FROM CODSUEL INTO CURSOR VERIFICA WHERE CONCEPTO = CURLIQ.CONCEPTO
 
 IF verifica.tipocarga <> "MOVIMIENTO"
    MESSAGEBOX("No Se puede Eliminar Este Concepto",16,"Atención")
 ELSE     
    SELECT curliq
    DELETE
 ENDIF
 SELECT VERIFICA
 USE   
 SELECT CURLIQ
 GO TOP
 _screen.ActiveForm.grid1.refresh
 _screen.ActiveForm.refresh