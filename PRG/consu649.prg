SELECT n.legajo, SUM(n.enero+n.febrero +n.marzo + n.abril + n.mayo + n.junio + n.julio + n.agosto + n.setiembre+ n.octubre + n.noviembre + n.diciembre)as t;
FROM nlegajo n INNER JOIN nconceptos c;
ON n.concepto = c.concepto;
WHERE n.ano = 2015 .and.  c.clase = 8 ;
GROUP BY n.legajo;
having(n.legajo = 765)