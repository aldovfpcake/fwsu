SET PATH TO C:\SUERUT\EMPRE1
SET EXCLUSIVE off
SET DELETED ON
CLOSE tables
SELECT 0
USE 42021 ALIAS sueldos
reemp()
*s.legajo = p.legajo WHERE ALLTRIM(orden) = "20210311" .and. concepto = 20 INTO CURSOR LISTA
SELECT p.legajo as l ,p.nombre,s.legajo,s.tipoconcep FROM sueldos s INNER JOIN personal p ON ;
s.legajo = p.legajo WHERE val(s.tipoconcep) = 70 into cursor lista

browse
DELETE FROM  sueldos
SELECT LISTA
SCAN
     SELECT sueldos
     RECALL FOR sueldos.LEGAJO = LISTA.L .AND. sueldos.LIQUIDA = 2
     SELECT LISTA

ENDSCAN


*****************
FUNCTION reemp
****************
REPLACE TIPOCONCEP WITH "70" FOR LEGAJO = 813 .AND. LIQUIDA = 2
REPLACE TIPOCONCEP WITH "70" FOR LEGAJO = 850 .AND. LIQUIDA = 2
REPLACE TIPOCONCEP WITH "70" FOR LEGAJO = 724 .AND. LIQUIDA = 2
