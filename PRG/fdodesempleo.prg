SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET EXCLUSIVE OFF
SET DELETED ON
CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
x.Seteopat(2)
SET CLASSLIB TO rh 
ms = 12
an = 2019
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
 browse                     
 SUM FDODES TO VV
 WAIT WINDOW STR(VV,12,2)
 COUNT FOR sntecob <>0 TO treg
 
  SET DEVICE TO FILE C:\BANK.TXT
 
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