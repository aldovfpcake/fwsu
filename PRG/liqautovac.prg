PARAMETERS xlegajo,xcantidad
WAIT WINDOW STR(xlegajo,4 ) + " " + STR(xcantidad,2)
SET TALK OFF
SET SAFETY OFF
*CLOSE TABLES all
SET TALK OFF
SET EXCLUSIVE OFF
SET DATE ITALIAN
SET REPROCESS TO AUTOMATIC
SET MULTILOCKS ON

SET DELETED ON
OPEN DATABASE F:\SUELDOS\SUELDOS SHARED
CLEAR
*SET PATH TO t:\FWSU\FORMS;t:\FWSU\PRG;F:\FWSU\CLASES;F:\SUELDOS\EMPRE1;F:\SUELDOS
SET PROCEDURE TO c:\fwsu\prg\classliq
ob = CREATEOBJECT("configurar")
ob.Seteo
ob.Seteopat(1)
clear
warchlq = "B92014"
warchiliquida = "22018"
wconcep = 20
******************************************************
wlegajo = xlegajo
wcant   = xcantidad 
***************************************************
waporte = 0
wliquida = 2
wvaloruni = 1
borrar()
crear()
lq = CREATEOBJECT('liquidacion')
****************************************
lq.wmes = 1
lq.wano = 2018
*************************************
lq.wtipoliq = 2
lq.wlegajo = wlegajo
lq.buscolegajo
lq.cargobase
lq.liquida 
SELECT curliq
replace ALL valoruni WITH 1
recibo()
comentarios()
actualizar()
*CLOSE TABLES all
SELECT curliq
USE
wlegajo = 0
wcant = 0
 
RELEASE lq
SELECT vpersolinea
use
return



***********************
FUNCTION recibo
*********************
obm = CREATEOBJECT("montoescrito")
vlegajo = wlegajo
PUBLIC monto,nombremes,banco,fecpjub,ano,fechapago
ano = 2018
SELECT SUM(aporte)as ap ,SUM(sinaporte) as sp, SUM(descuento) as ds;
FROM CURLIQ INTO CURSOR tota
neto = (tota.ap + tota.sp) - tota.ds
monto = obm.monto(" ",neto)
*********************************
nombremes = obm.nombremes(lq.wmes)
*******************************
banco = "HSBC"
fecpjub = "08-1-2018"
fechapago = dtoc(date())
SELECT 0
USE vpersolinea
LOCATE FOR legajo = lq.wlegajo
SELECT curliq
REPORT FORM  RECIBOSUELDO TO PRINTER PROMPT NODIALOG PREVIEW




*************************
FUNCTION BORRAR
************************
USE f:\sueldos\empre1\b92014 exclusive
ZAP
INDEX on STR(concepto,4) TO f:\sueldos\empre1\b92014
use


*****************
FUNCTION CREAR
**************
SELECT 0
USE (warchlq) ALIAS curliq
INSERT INTO curliq(legajo,concepto,cantidad,aporte,liquida) values(wlegajo,wconcep,wcant,waporte,wliquida)
INSERT INTO curliq(legajo,concepto,cantidad,aporte,liquida) values(wlegajo,40,wcant,waporte,wliquida)

**********************
FUNCTION actualizar
************************
SELECT curliq
?"**************"
? "Actualizando legajo......:" + STR(wlegajo,4)
?"*************"
  
SELECT concepto FROM f:\sueldos\empre1\22018 WHERE legajo = wlegajo .and. liquida = 2;
INTO CURSOR EXISTE  
Varexiste = 1  
IF EOF()
   VarExiste = 0
ENDIF   

IF VarExiste = 0  
   SELECT CURLIQ
   SCAN
      
     INSERT INTO f:\sueldos\empre1\22018(legajo,concepto,cantidad,aporte,sinaporte,descuento,descrip,liquida,valoruni) VALUES;
     (curliq.legajo,curliq.concepto,curliq.cantidad,curliq.aporte,curliq.sinaporte,curliq.descuento,curliq.descrip,2,1)

     ENDSCAN
  WAIT WINDOW "REGISTRO ACTUALIZADO"
ENDIF

RETURN 0
 
**************************
FUNCTION comentarios
********************
?lq.wmes
?lq.wano
SELECT c.legajo,c.mes,c.ano FROM  coments c WHERE legajo = lq.wlegajo .and. ano = lq.wano ;
.and. mes = lq.wmes INTO CURSOR existe
IF EOF()
   INSERT INTO coments(legajo,mes,ano,coments) VALUES (lq.wlegajo,lq.wmes,lq.wano,"Vac Liquidadas--"+DTOC(DATE());
   + " "+ STR(wcant,2))
 ELSE   
  * UPDATE coments SET  coments = "Vac Liquidadas--"+DTOC(DATE());
   + " "+ STR(wcant,2) WHERE legajo = lq.wlegajo .and. ano = lq.wano .and. mes = lq.wmes
   
ENDIF
SELECT EXISTE
USE
RETURN   
                           
     