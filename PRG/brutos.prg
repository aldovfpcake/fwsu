fso = CreateObject('Scripting.FileSystemObject')
tf = fso.CreateTextFile('F:\sueldos\EMPRE1\testfileb.txt', .t.)
lega = 816
SELECT * FROM sbr20 WHERE legajo = lega  INTO CURSOR informe
i=3
FOR I= 3 TO FCOUNT()
   linea =fields(i) +"........:..." + STR(( EVALUATE(fields(i))),12,2)+" " 
    tf.WriteLine(linea)
   linea ="--------------------------------"
   tf.WriteLine(linea)
NEXT

tf.close