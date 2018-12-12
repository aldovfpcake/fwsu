*PARAMETERS legajo,dias
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
warchlq = "B92014"
wconcep = 18
*wlegajo = legajo
wcant = 0 
waporte = 0
wliquida = 4

SELECT 0
use sueldosfijos
GO top
*SET STEP ON 
Scan
  SELECT sueldosfijos
  Varsac = sueldosfijos.sueldo*0.275 + (sueldosfijos.sueldo)/2
  wlegajo = sueldosfijos.legajo
  borrar()
  crear()
  xb = CREATEOBJECT("lqsac")
  xb.wano = 2018
  xb.wlegajo = wlegajo
  xb.wtiposac = 2
  xb.liquisac
  SELECT curliq
  * sldo = sueldosfijos.sueldo*0.275 + (sueldosfijos.sueldo)/2
  replace aporte WITH Varsac
  RELEASE xb
  wtipo = 4
  liquisac(wlegajo)
  SELECT curliq
 * BROWSE
  
  * actualizar()
   SELECT sueldosfijos
endscan
 




**********************
FUNCTION liquisac
*********************
PARAMETERS wleg
lq = CREATEOBJECT('liquidacion')
lq.wmes     = 12
lq.wano     = 2017
lq.wtipoliq = 4
lq.wlegajo = wleg
lq.cargobase
lq.liquida 

 RELEASE lq

RETURN .T.

CLOSE TABLES ALL






***********************
FUNCTION recibo
*********************
obm = CREATEOBJECT("montoescrito")
vlegajo = wlegajo
PUBLIC monto,nombremes,banco,fecpjub,ano,fechapago
SELECT SUM(aporte)as ap ,SUM(sinaporte) as sp, SUM(descuento) as ds;
FROM CURLIQ INTO CURSOR tota
neto = (tota.ap + tota.sp) - tota.ds
monto = obm.monto(" ",neto)
nombremes = obm.nombremes(12)
banco = "HSBC"
fecpjub = "14-10-2016"
fechapago = "30-12-2016"
SELECT 0
USE vpersolinea
LOCATE FOR legajo = vlegajo
SELECT curliq
REPORT FORM  RECIBOSUELDO TO PRINTER PROMPT NODIALOG PREVIEW

return  


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





**********************
FUNCTION actualizar
************************
SELECT curliq
?"**************"
? "Actualizando legajo......:" + STR(curliq.legajo,4)
?"*************"
 
SCAN
   DELETE FROM  f:\sueldos\empre1\122018  WHERE legajo = curliq.legajo .and. liquida = 4
   INSERT INTO f:\sueldos\empre1\122018 (legajo,concepto,aporte,sinaporte,descuento,descrip,liquida) VALUES;
   (curliq.legajo,curliq.concepto,curliq.aporte,curliq.sinaporte,curliq.descuento,curliq.descrip,4)

ENDSCAN
RETURN 0


