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
xb = CREATEOBJECT("lqsac")
xb.wano = 2015
xb.wtiposac = 2
warchlq = "122015"
wtipo = 4
wconcep = 18
SET TEXTMERGE ON

STORE FCREATE( 'c:\suerut\listados\myNamesFile.txt') TO _TEXT


SELECT LEGAJO,FECHAING,FECHABAJA FROM PERSONAL WHERE ACTIVO = "A" INTO CURSOR LIS ORDER BY LEGAJO
SCAN
     xb.wlegajo = lis.legajo
     xb.liquisac 
     TEXT
       <<STR(LIS.LEGAJO,4)>> <<DTOC(LIS.FECHAING)>>  <<DTOC(LIS.FECHABAJA)>> <<STR(xb.wmejor/2,9,2)>>
     ENDTEXT
     *INSERT INTO &warchlq(legajo,liquida,concepto,aporte) values(lis.legajo,wtipo,wconcep,(xb.wmejor/2)) 
ENDSCAN



SELECT LIS
GO TOP
lq = CREATEOBJECT('liquidacion')
lq.wmes     = 12
lq.wano     = 2015
lq.wtipoliq = 4
SELECT 0
USE 122015
SELECT 0
USE CURLIQ NODATA
SELECT LIS

SCAN
    
    lq.wlegajo = lis.legajo
    SELECT curliq
    vlegajo   = lis.legajo
    vliquida  = 4
    REQUERY()
    *lq.cargobase
    GO top
    lq.liquida 
     ?lis.legajo
    SELECT lis 
         
ENDSCAN


CLOSE TABLES ALL