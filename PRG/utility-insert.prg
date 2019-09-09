SET PATH TO C:\SUERUT\EMPRE1
USE comentarios AGAIN

PRIVATE tabla,arreglo,reg,CardInsert,tabla,linea,valores,CadUpdate
linea     = " "
valores   = " "
CadUpdate = " "
tabla = "personal"

reg = AFIELDS(arreglo)
FOR i=1 TO reg
   linea = linea + " "+ arreglo(i,1)+","
   valores = valores +" "+ ("Var"+arreglo(i,1))+","
NEXT

?valores
CadInsert = "Insert into "+ tabla +" "+ "("+linea+")" + "Values" +"("+valores+")"

?CadInsert 

STRTOFILE(CadInsert,"c:\sql.txt")