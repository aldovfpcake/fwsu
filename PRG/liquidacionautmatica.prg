SET PROCEDURE TO c:\fwsu\prg\classliq
SET SAFETY off
ob = CREATEOBJECT("configurar")
ob.Seteo
ob.Seteopat(6)
*warchlq = "B92014"

CLEAR

VarMes = 6
wsueldototal = 44500
Vlegajo = 702
Vliquida = 3

Varmes = 6

lq = CREATEOBJECT('liquidacion')
lq.wmes     = 6
lq.wano     = 2018
lq.wdisplaynove = .t.
lq.wlegajo  = 702
lq.wtipoliq = 3
lq.buscolegajo
lq.cargobase
IF VarMes <> 9
   lq.feriadonotra
ENDIF
lq.liquida
SELECT curliq
REQUERY()
BROWSE 
SELECT SUM(aporte) + SUM(sinaporte) - SUM(descuento) as neto;
FROM curliq  GROUP BY legajo INTO CURSOR net
SELECT curliq
Varcant    = 18
Varconcep  = 5
Varliquida = 3
Varlegajo  = 702
FOR zjw= 1 TO 50
   SELECT concepto FROM curliq WHERE concepto = 5 INTO CURSOR existe
   IF EOF()
      INSERT INTO curliq(legajo,concepto,cantidad,liquida) values(Varlegajo,Varconcep,Varcant,Varliquida)
      INSERT INTO curliq(legajo,concepto,cantidad,liquida) values(Varlegajo,6,11,Varliquida)
   ELSE   
      UPDATE curliq SET cantidad = Varcant WHERE curliq.concepto = 5 .and. curliq.liquida = 3
   ENDIF
   SELECT CURLIQ
   REQUERY()
   lq.liquida
      
   Varcant = Varcant + 2
   SELECT SUM(aporte) + SUM(sinaporte) - SUM(descuento) as neto;
   FROM curliq  GROUP BY legajo INTO CURSOR net
   ?net.neto
   ?zjw  
   
*   IF zjw = 7
     * SET STEP ON 
*   ENDIF   
   
   df = wsueldototal - net.neto
   
   IF df  < 80  
      exit
   endif
NEXT     
SELECT curliq
REQUERY()
SELECT SUM(aporte) + SUM(sinaporte) - SUM(descuento) as neto;
FROM curliq  GROUP BY legajo INTO CURSOR net
?net.neto
?"diferencia......=" + STR(df,10,2)
BROWSE












*************************
FUNCTION BORRAR
************************
USE f:\sueldos\empre1\b92014 ALIAS curliq exclusive
ZAP
INDEX on STR(concepto,4) TO f:\sueldos\empre1\b92014
USE

**************
FUNCTION CREAR
**************
SELECT 0
USE (warchlq) ALIAS curliq 
*SET INDEX TO  f:\sueldos\empre1\b92014
