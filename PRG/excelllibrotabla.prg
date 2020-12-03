SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET EXCLUSIVE OFF
SET DELETED ON
CLOSE TABLES all
SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
x.Seteopat(1)
fso = CreateObject('Scripting.FileSystemObject')
tf = fso.CreateTextFile('c:\sueldos\ls.txt', .t.)
tf.close


*DIMENSION LEGAJOS[10]

*LEGAJOS[1]=441
*LEGAJOS[2]=442
*LEGAJOS[3]=444
*LEGAJOS[4]=445
*LEGAJOS[5]=448
*LEGAJOS[6]=449
*LEGAJOS[7]=465
*LEGAJOS[8]=484
*LEGAJOS[9]=487
*LEGAJOS[10]=525

*SELECT legajo,nombre,depart, legajo=0 as marca FROM C:\SUERUT\EMPRE1\personal WHERE activo = "A" ORDER BY depart;
INTO TABLE C:\SUERUT\EMPRE1\listafp
*
* familiar adicional
*SELECT distin p.legajo,p.nombre,m.concepto,m.unidades FROM personal p INNER JOIN maper m;
*ON p.legajo = m.legajo WHERE p.activo= "A" .AND. m.concepto = 855

*


CLEAR
USE C:\SUERUT\EMPRE1\listafp
*DELETE FOR LEGAJO= 819
*REPLACE ALL MARCA WITH .F.
*LOCATE FOR LEGAJO = 864
*
GO TOP
*FOR IND = 1 TO 50
*    IF MARCA = 0
*      REPLACE MARCA WITH 1
*    ENDIF
*    SKIP

 *NEXT
GO TOP
*BROWSE FOR LEGAJO > 809
LOCAL Contador, Sec
Contador = 1
Sec = 4

*DO WHILE .NOT. EOF()
*   IF marca = 0 .and. contador <=50
*      replace marca WITH Sec
*      Contador = Contador + 1
*      
*   ENDIF
*   skip
*ENDDO


VarCont = 1
SCAN FOR LEGAJO = 258
      ?LEGAJO
      
      DO EXCELLIBROB WITH LISTAFP.LEGAJO,VarCont
      VarCont= VarCont+1

ENDSCAN

?VarCont



