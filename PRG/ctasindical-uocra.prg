SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET EXCLUSIVE OFF
SET DELETED ON
SET DATE LONG
CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
x.Seteopat(2)
SET CLASSLIB TO rh 
lg = CREATEOBJECT("legajoper")
ms = 4
an = 2021
op= CREATEOBJECT('abretabla')
op.optabla(ms,an)
*select p.cuil,sum(s.aporte),p.fechaing,p.codipos,p.categoria from personal p;
inner join liquida s on s.legajo = p.legajo group by p.cuil 
*SELECT p.cuil,SUM( l.aporte)as s FROM personal p INNER JOIN liquida l ON p.legajo = l.legajo;
GROUP BY l.legajo
*SELECT p.cuil,SUM( l.aporte),p.fechaing,p.codipos,p.categoria FROM personal p INNER JOIN liquida l ON p.legajo = l.legajo;
GROUP BY p.cuil
SELECT lg.pasocuil(p.cuil)as cuil,p.fechaing,p.codipos,p.categoria,SUM(l.aporte)sb FROM personal p INNER JOIN liquida l;
ON p.legajo = l.legajo  GROUP BY p.cuil,p.fechaing,p.codipos,p.categoria INTO CURSOR sldo
BROWSE


fso = CreateObject('Scripting.FileSystemObject')
tf = fso.CreateTextFile("c:\sueldos\uocra.txt",.t.)
clear
SCAN
    ano = " "
    mes = " "
    dia = " "
    vcateg = " "
    conven = " "
    conven = "01"
    fecha = DTOS(fechaing)
    dia = SUBSTR(fecha,7,2)
    mes = SUBSTR(fecha,5,2)
    ano = SUBSTR(fecha,1,4) 
    IF sb < 100000
       remu = "0"+ STR(sb,5)+"00"
    ELSE
       remu = ALLTRIM(STR(sb,7))+"00"
    ENDIF
    ?remu
    IF categoria = "SERENO"
       vcateg = "06"
    ELSE   
       vcateg = "03"
    ENDIF
    linea = ALLTRIM(cuil)+ALLTRIM("S")+remu+remu+ALLTRIM(dia)+ALLTRIM(mes)+ALLTRIM(ano)+ALLTRIM(STR(codipos,4))+ALLTRIM(conven)+ALLTRIM(vcateg)+ALLTRIM("N")
    tf.WriteLine(linea)

ENDSCAN

tf.Close

