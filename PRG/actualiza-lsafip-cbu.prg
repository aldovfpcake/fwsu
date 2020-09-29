SET EXCLUSIVE OFF
SET DELETED ON
VarTabla = "\\192.168.1.10\K\LSAFIP\EMPLEADO.DBF"
SET PATH TO f:\sueldos\empre1
SELECT * FROM (VarTabla);
where EMPTY(cbu) INTO CURSOR LISTA
GLEDIT=.T.
SCAN
   SELECT cbu FROM personal WHERE legajo = lista.legajo INTO CURSOR pers
   
   UPDATE (VarTabla) SET cbu = pers.cbu WHERE legajo = lista.legajo
   ?_tally

ENDSCAN 