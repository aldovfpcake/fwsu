SET DELETED on
SELECT tabhoras
GO top


SCAN
 
    IF saldif <-120 
       positivo = saldif * -1
       horas =  INT(positivo/valcicta) 
       thoras = horcta - horas
       replace horcta WITH thoras
    ENDIF
    
    IF saldif > 10 
       horas = INT(saldif/valcicta)
       thoras = horcta - horas
       replace horcta  WITH thoras 
    ENDIF
   
    IF saldif < valcicta .AND. saldif > 1
       replace horcta WITH (horcta+1)
    ENDIF 

endscan