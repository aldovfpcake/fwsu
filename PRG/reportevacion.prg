SET PATH TO F:\SUELDOS\EMPRE1;C:\FWSU\FORMS
SET DELETED ON
*SELECT DISTINCT  l.legajo,l.documento,l.nombre,;
v.ano,v.desde,v.hasta,v.dias FROM personal l INNER JOIN vacaci v ON l.legajo = vacaci.legajo WHERE v.ano = 2017  INTO CURSOR vacaciones
SELECT legajo,nombre,documento FROM personal WHERE legajo = 402 INTO CURSOR lper
SELECT vacaci.legajo,vacaci.desde, vacaci.hasta,vacaci.dias,vacaci.ano FROM vacaci WHERE legajo = 402 .and. ano = 2017 INTO CURSOR lvc
SELECT l.legajo,l.nombre,l.documento,s.desde,s.hasta,s.dias,s.ano FROM lper l INNER JOIN lvc s ON l.legajo = s.legajo;
into CURSOR vacaciones
REPORT FORM vacformu preview