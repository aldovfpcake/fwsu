SET TALK OFF
SET EXCLUSIVE OFF
SET DATE ITALIAN
SET REPROCESS TO AUTOMATIC
SET MULTILOCKS ON
SET DELETED ON
OPEN DATABASE F:\SUELDOS\SUELDOS SHARED
CLEAR
*SET PATH TO t:\FWSU\FORMS;t:\FWSU\PRG;F:\FWSU\CLASES;F:\SUELDOS\EMPRE1;F:\SUELDOS
SET PROCEDURE TO T:\fwsu\prg\classliq
ob = CREATEOBJECT("configurar")
ob.Seteo
ob.Seteopat(1)
warchlq = "62016"
SELECT 0
USE (warchlq) ALIAS curliq

xb = CREATEOBJECT("lqsac")
xb.wano = 2016
xb.wtiposac = 1


wtipo = 4
wconcep = 18

SET TEXTMERGE ON

STORE FCREATE( 'c:\suerut\listados\myNamesFile.txt') TO _TEXT


SELECT LEGAJO,FECHAING,FECHABAJA FROM PERSONAL WHERE ACTIVO = "A" INTO CURSOR LIS ORDER BY LEGAJO
SCAN
*     xb.wlegajo = lis.legajo
*     xb.liquisac 
     
*     TEXT
*       <<STR(LIS.LEGAJO,4)>> <<DTOC(LIS.FECHAING)>>  <<DTOC(LIS.FECHABAJA)>> <<STR(xb.wmejor/2,9,2)>>
*     ENDTEXT
*     
*     SELECT legajo,concepto FROM curliq WHERE legajo = lis.legajo .and. concepto = 18 .and. liquida = 4;
*    INTO CURSOR existe
*     IF EOF()
*        INSERT INTO &warchlq(legajo,liquida,concepto,aporte) values(lis.legajo,wtipo,wconcep,(xb.wmejor/2)) 
*     ELSE
*        UPDATE &warchlq SET aporte = xb.wmejor/2 WHERE legajo = lis.legajo .and.liquida = wtipo .and. concepto =18
*       
*     ENDIF
*     SELECT LIS

      liquisac(lis.legajo)
      SELECT lis 

ENDSCAN

RETURN









**********************
FUNCTION liquisac
*********************
PARAMETERS wleg
?wleg
SELECT LIS
GO TOP
lq = CREATEOBJECT('liquidacion')
lq.wmes     = 6
lq.wano     = 2016
lq.wtipoliq = 4
lq.wlegajo = wleg
lq.liquida 

 RELEASE lq

RETURN .T.

CLOSE TABLES ALL