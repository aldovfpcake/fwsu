fso = CreateObject('Scripting.FileSystemObject')
tf = fso.CreateTextFile('F:\sueldos\EMPRE1\testfileb.txt', .t.)
LOCAL Varlg,VarAne
Varlg = thisform.txtlegajo.Value
VarAne = YEAR(DATE())
wlustro = "SBR" +SUBSTR(STR(VarAne,4),3)
SET STEP ON 

SELECT * FROM &wlustro WHERE legajo = Varlg  INTO CURSOR informe
i=3
FOR I= 3 TO FCOUNT()
   linea =fields(i) +"........:..." + STR(( EVALUATE(fields(i))),12,2)+" " 
    tf.WriteLine(linea)
   linea ="--------------------------------"
   tf.WriteLine(linea)
NEXT

FOR I=3 TO FCOUNT()
   linea = STR(( EVALUATE(fields(i))),12,2) 
   tf.WriteLine(linea)
   
NEXT

tf.close

fso = CreateObject('Scripting.FileSystemObject')
tf = fso.CreateTextFile('F:\sueldos\EMPRE1\testfileb.txt', .t.)
wlustro = "SBR" +SUBSTR(STR(vvano,4),3)
lega = 17
SELECT * FROM &wlustro WHERE legajo = lega  INTO CURSOR informe
i=3
FOR I= 3 TO FCOUNT()
   linea =fields(i) +"........:..." + STR(( EVALUATE(fields(i))),12,2)+" " 
    tf.WriteLine(linea)
   linea ="--------------------------------"
   tf.WriteLine(linea)
NEXT

FOR I=3 TO FCOUNT()
   linea = STR(( EVALUATE(fields(i))),12,2) 
   tf.WriteLine(linea)
   
NEXT

tf.close

DO FORM fmedcionbrutos