SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET EXCLUSIVE OFF
SET DELETED ON
CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
x.Seteopat(2)
SET CLASSLIB TO rh 
LOCAL ms,an,artxt
ms = 4
an = 2020
op= CREATEOBJECT('abretabla')
op.optabla(ms,an)
rp = CREATEOBJECT('reportesueldo')
 UPDATE repcab SET mes = op.nombres(ms),;
                      ano = an

 IF ms =< 10 .and. an = 2019
    rp.fdodes  =0.12
 ELSE
    rp.fdodes = 0.08
 ENDIF
 WAIT WINDOW  "Fondo De Desempleo...."+STR(rp.fdodes,2,2)    
 
 rp.sindistincion
 DELETE FOR chapa = 255
  gensueldo()
            
 SELECT sue3          
 SUM FDODES TO VV
 WAIT WINDOW STR(VV,12,2)
 COUNT FOR sntecob <>0 TO treg
 DO FOXYPREVIEWER.APP
 REPORT FORM detalle-fdo preview
  
 
 arttxt = "c:\fondo-desempleo-"+STR(ms,2)+"-"+STR(an,4)
 
  SET DEVICE TO FILE (arttxt)
 
 @0,0  say '33-60724391-9' picture "99-99999999-9"
 @0,13 say CHR(9)  
 @0,14 say LTRIM(STR(treg,4))
lin = 1
SCAN
  IF sntecob <> 0
     pesos = STR(sntecob,9,2)

     cad = ALLTRIM(ALLTRIM(cuil)+CHR(9)+LTRIM(SUBSTR(pesos,1,LEN(ALLTRIM(pesos)))))
     *                        123456789-123           
     *                         12346579-1234
     @lin,0  say cuil picture "99-99999999-9" 
     @lin,13 say CHR(9)
     @lin,14 say LTRIM(CHRTRAN(STR(fdodes,9,2),".",","))  
     lin = lin + 1
  ENDIF  
  
ENDSCAN	
*@lin,0  say CHR(13)
CLOSE ALL
SET DEVICE TO SCREEN
CLOSE TABLES


FUNCTION remplazo

 SELECT SUE3
 SCAN
     SELECT LEGAJO,CUIL FROM PERSONAL WHERE LEGAJO = SUE3.CHAPA;
     INTO CURSOR LISTAP
     SELECT SUE3
     REPLACE  SUE3.CUIL WITH LISTAP.CUIL 
     
 ENDSCAN
*SET DEVICE TO SCREEN

RETURN .t.


***********************
FUNCTION gensueldo
*********************
SELECT legajo,SUM(IIF(concepto <> 18,aporte,0))as bruto FROM liquida GROUP BY legajo INTO CURSOR LISTA
SUM bruto TO vv
WAIT WINDOW  "Total bruto para fondo de Desempleo : "+ STR(vv,16,2)
SCAN
   UPDATE SUE3 SET SBRUTO = lista.bruto;
          WHERE chapa = lista.legajo
          
   SELECT lista

ENDSCAN