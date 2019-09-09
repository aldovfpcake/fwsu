SET TALK OFF
SET DELETED ON
SET EXCLUSIVE OFF
SET PATH TO F:\SUELDOS\EMPRE1
VarAno = 2017
Varlegajo = 701

VarTot = 0
*LEGAJO 701 MARCELO SALVAGGIO 

clear
FOR I = 1 TO 3
   FOR x =1 TO 12
      archivo = IIF(x<= 6, STR(x,1)+STR(varano,4),STR(x,2)+STR(varano,4))
      IF FILE(archivo+".dbf")
        SELECT SUM(IIF(CONCEPTO = 126 .OR. CONCEPTO = 875,DESCUENTO,0))AS emb FROM &archivo WHERE LEGAJO = Varlegajo INTO CURSOR SUELDO
        IF .NOT. EOF()
           SELECT legajo,periodo,pagado FROM ctremb WHERE legajo = Varlegajo .and. periodo = archivo;
           INTO CURSOR existe
           Varimporte =sueldo.emb
           IF ISNULL(Varimporte) 
               *WAIT WINDOW "Importe Nulo"
           ELSE    
           	  IF EOF()
                 insertar(Varlegajo,Varimporte,archivo)                   
              ELSE 
                 updatear(Varlegajo,Varimporte,archivo)
              ENDIF   
           ENDIF
        
        ENDIF
                        
        ?archivo + "  " + STR(sueldo.emb,10,2)  + " " + TRANSFORM(existe.pagado)
         
        VarTot = VarTot +sueldo.emb   
     ENDIF
   NEXT
  
   VarAno = VarAno +1
   
NEXT

SELECT ctremb
Vartot =0
SUM importe TO VarTot FOR legajo = Varlegajo .AND. pagado = .f.
? "Total General Retenido............ = " + STR(Vartot,10,2)

VarFalta = 308838.69 - Vartot
?"Falta Retener...............$" + STR(VarFalta,10,2) 
 



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