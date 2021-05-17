SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET EXCLUSIVE OFF
SET DELETED ON
SET TALK OFF
CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
x.Seteopat(1)
PUBLIC WARCHIVO
WARCHIVO = "42021"
SELECT legajo, NOMBRE,SINDICATO FROM PERSONAL WHERE ACTIVO = "A" .AND. SINDICATO = "SIND CHOF CAM SANTA FE" INTO CURSOR LSIN
SELECT LEGAJO,SUM(IIF(CONCEPTO = 1,APORTE,0))AS BASICO, SUM(APORTE)as bruto ,SUM(IIF(CONCEPTO = 17,APORTE,0)) AS KM,;
SUM(IIF(CONCEPTO = 23,APORTE,0)) AS KM100,SUM(IIF(CONCEPTO = 24,APORTE,0)) AS frares,SUM(IIF(CONCEPTO = 14,APORTE,0)) AS ctrol,completar()as otros  FROM &WARCHIVO  GROUP BY LEGAJO INTO CURSOR SUELDO readwrite
SCAN
   replace otros WITH bruto -(basico+km+km100+frares+ctrol)
   IF otros < 0
      replace otros WITH 0
   ENDIF   
   
endscan
SELECT lsin.legajo,lsin.nombre,sueldo.basico,sueldo.bruto,sueldo.km,sueldo.km100,sueldo.frares,sueldo.ctrol,sueldo.otros  FROM lsin INNER JOIN sueldo ON lsin.legajo = sueldo.legajo;
into TABLE C:\suerut\empre1\planilla-sta-fe
*BROWSE
USE c:\empre1\planilla-sta-fe

*O FOXYPREVIEWER.APP 
REPORT FORM lissantafe preview

***************
FUNCTION completar
****************
LOCAL VarSt
Varst = 0
RETURN Varst
