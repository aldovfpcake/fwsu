SET TALK OFF
SET DELETED ON
SET PATH TO F:\SUELDOS\EMPRE1
VarAno = 2016
Varlegajo = 814
VarTot = 0
clear
FOR x =1 TO 12
      archivo = IIF(x<= 6, STR(x,1)+STR(varano,4),STR(x,2)+STR(varano,4))
      IF FILE(archivo+".dbf")
        SELECT SUM(IIF(CONCEPTO = 126,DESCUENTO,0))AS emb FROM &archivo WHERE LEGAJO = Varlegajo INTO CURSOR SUELDO
        IF .NOT. EOF()
           SELECT legajo,periodo FROM ctremb WHERE legajo = Varlegajo .and. periodo = archivo;
           INTO CURSOR existe
           Varimporte =sueldo.emb
           
           IF EOF()
              insertar(Varlegajo,Varimporte,archivo)                   
           ELSE 
              updatear(Varlegajo,Varimporte,archivo)
           ENDIF   
        
        ENDIF
                        
        ?archivo + "  " + STR(sueldo.emb,10,2) 
        VarTot = VarTot +sueldo.emb   
     ENDIF





NEXT
SELECT CTREMB
SUM importe TO VarTot FOR legajo = Varlegajo
? "Total General Retenido............ = " + STR(Vartot,10,2)




CLOSE TABLES
RETURN                              


FUNCTION insertar()
PARAMETERS Varlegajo,Varimporte,Varperiodo 
  INSERT INTO ctremb(legajo,importe,periodo) VALUES (Varlegajo,Varimporte,Varperiodo)

RETURN .T.





FUNCTION updatear()
PARAMETERS Varlegajo,Varimporte,Varperiodo
              UPDATE ctremb SET importe = Varimporte,;
                             periodo = Varperiodo ;
                             WHERE legajo = Varlegajo .and. periodo = Varperiodo   


RETURN .T.