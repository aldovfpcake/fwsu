SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET EXCLUSIVE OFF
SET DELETED ON
CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
x.Seteopat(1)
PUBLIC WARCHIVO
WARCHIVO = "122020"
SELECT legajo,nombre,sindicato; 
FROM personal WHERE SINDICATO ='SIND. CHOF MISIONES      '  INTO CURSOR LSIN
SELECT LEGAJO,SUM(IIF(CONCEPTO = 1,APORTE,0))AS BASICO, SUM(APORTE)as bruto ,SUM(SINAPORTE)as nre, SUM(IIF(CONCEPTO = 164,DESCUENTO,0)) AS farm,;
SUM(IIF(CONCEPTO = 165,DESCUENTO,0)) AS Mutual FROM &WARCHIVO  GROUP BY LEGAJO INTO CURSOR SUELDO
SELECT lsin.legajo,lsin.nombre,sueldo.basico,sueldo.bruto,sueldo.nre,sueldo.farm,sueldo.mutual FROM lsin INNER JOIN sueldo ON lsin.legajo = sueldo.legajo;
into cursor planilla
BROWSE
DO FOXYPREVIEWER.APP 
REPORT FORM c:\suerut\consultas\lstmisiones.frx preview