SET PATH TO F:\SUELDOS\EMPRE1

SELECT p.legajo,p.nombre,p.depart,v.dias,v.sueldos;
from personal p INNER JOIN vacaci v ON p.legajo = v.legajo;
where ano = 2018
browse