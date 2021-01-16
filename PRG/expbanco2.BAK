SET TALK OFF
SET DELETED ON
SET TEXTMERGE ON
SET CURRENCY TO "99999,99"

CLEAR
SET CLASSLIB TO C:\fwsu\CLASES\rh

*SET PATH TO c:\suerut\empre1
*USE SUE3
SELECT SUE3
SET FILTER TO !EMPTY(CUENTA); 
.AND. SNTECOB <> 0 .AND. BANCO <>"PAGADO"

*SET FILTER  TO BANCO = "HSBC"

BROWSE
clear
GO TOP
COUNT FOR sntecob <>0 TO treg
SUM sntecob TO wtotal
*           23456879-123456789-   
@10,02 say "Total A Acredita :"
@10,25 say wtotal picture "99999999.99"
*                    
WAIT "presione"
GO top
*remplazo()  
cad = '30-51640352-3'+CHR(9)+ STR(treg,4)


*SET DEVICE TO FILE F:\ALDO\BANCO\BANK.TXT
 *                                  123456789-123    
 SET DEVICE TO FILE C:\SUELDOS\BANK.TXT
 
 @0,0  say '30-51640352-3' picture "99-99999999-9"
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
     @lin,14 say LTRIM(CHRTRAN(STR(sntecob,9,2),".",","))  
     lin = lin + 1
  ENDIF  
  
ENDSCAN	
*@lin,0  say CHR(13)
*CLOSE ALL
SET DEVICE TO SCREEN



FUNCTION remplazo

 SELECT SUE3
 SCAN
     SELECT LEGAJO,CUIL FROM f:\sueldos\legajos WHERE LEGAJO = SUE3.CHAPA;
     INTO CURSOR LISTAP
     SELECT SUE3
     REPLACE  SUE3.CUIL WITH LISTAP.CUIL 
     
 ENDSCAN
*SET DEVICE TO SCREEN

RETURN .t.