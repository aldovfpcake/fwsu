SET EXCLUSIVE OFF
SET PATH TO F:\SUELDOS\EMPRE1
*SET PATH TO C:\SUERUT\EMPRE1
SET DATE ITALIAN
SET CENTURY ON
SET DELETED ON
warchivo = ""
SELECT LEGAJO,SUM(APORTE )AS BRUTO,SUM(APORTE) + SUM(SINAPORTE) - SUM(DESCUENTO) AS NETO,;
SUM(IIF(CONCEPTO = 80 OR CONCEPTO = 131 OR CONCEPTO = 800 ,DESCUENTO,0))AS JUB,SUM(IIF(CONCEPTO = 81,DESCUENTO,0))AS PAM,SUM(IIF(CONCEPTO = 82,DESCUENTO,0))AS OBS,;
SUM(IIF(CONCEPTO = 83,1,0))AS SIND,SUM(IIF(CONCEPTO = 59 .OR. CONCEPTO = 64,SINAPORTE,0))AS SINAP,SUM(IIF(CONCEPTO = 1,APORTE,0)) AS BASICO ;
FROM 112020 WHERE LIQUIDA = 3  GROUP BY LEGAJO INTO CURSOR ONE
**
* VERIFICAR FECHA DE INGRESO
*
SELECT P.LEGAJO,P.FECHAING,P.NOMBRE,P.CUIL, P.DEPART,P.SUELDOFIJO,P.CATEGORIA FROM PERSONAL AS P WHERE ACTIVO = "A" .AND. FECHAING < CTOD("01-12-2020") INTO CURSOR PACTIVO

SELECT PE.LEGAJO,PE.NOMBRE,PE.FECHAING, PE.CUIL,PE.CATEGORIA,PE.DEPART,PE.SUELDOFIJO,ONE.BASICO,ONE.BRUTO, ONE.JUB,ONE.PAM,ONE.NETO, ONE.SINAP,VERIFICA(ONE.BRUTO,ONE.JUB)AS verifica  FROM PACTIVO AS PE  LEFT JOIN ONE ON PE.LEGAJO = ONE.LEGAJO;
ORDER BY PE.DEPART INTO CURSOR LEG

fso = CreateObject('Scripting.FileSystemObject')
tf = fso.CreateTextFile('c:\testfile.txt', .t.)

*SCAN FOR ISNULL(JUB) .OR. NETO = 0 .OR. BRUTO = 0
SCAN FOR ISNULL(BASICO).OR. BASICO = 0 
  linea = str(leg.legajo,4) + "  " + leg.nombre + " " + dtoc(leg.fechaing)
  tf.WriteLine(linea)


ENDSCAN
tf.Close
MODIFY FILE 'c:\testfile.txt'
BROWSE
BROWSE FOR VERIFICA >1 

FUNCTION verifica
PARAMETERS bruto,jub
 
 IF isnull(bruto)
   RETURN 0
 ENDIF
 
 IF isnull(jub)   
    RETURN 0
 ENDIF
    
 vvdf = 0
 vvdf =  ROUND(bruto*0.11,2)
 vvdf = vvdf-jub


RETURN vvdf