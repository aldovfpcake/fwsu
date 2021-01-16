SET PATH TO C:\SUERUT\EMPRE1
SET EXCLUSIVE off
SELECT 0
USE 12021 ALIAS sueldos

SELECT p.legajo as l ,p.nombre,s.legajo FROM sueldos s INNER JOIN personal p ON ;
s.legajo = p.legajo WHERE ALLTRIM(orden) = "20210115" .and. s.concepto = 20 INTO CURSOR LISTA

DELETE FROM  sueldos
SELECT LISTA
SCAN
     SELECT sueldos
     RECALL FOR sueldos.LEGAJO = LISTA.L .AND. sueldos.LIQUIDA = 2
     SELECT LISTA

ENDSCAN
