SET PATH TO \\fileserver\f\sueldos\empre1
USE lagardi again

PRIVATE tabla,arreglo,reg,CardInsert,tabla,linea,valores,CadUpdate
linea     = " "
valores   = " "
CadUpdate = " "
tabla = "lagardi"
CadUpd = " "
reg = AFIELDS(arreglo)
FOR i=1 TO reg
   linea = linea + " "+ arreglo(i,1)+","
   valores = valores +" "+ ("Var"+arreglo(i,1))+","
   CadUpdate = CadUpdate+arreglo(i,1) +"=" + ("Var"+arreglo(i,1))+","
NEXT

?valores
CadInsert = "Insert into "+ tabla +" "+ "("+linea+")" + "Values" +"("+valores+")"
?CadInsert 
?Cadupdate

STRTOFILE(CadInsert,"c:\sql.txt")
STRTOFILE(Cadupdate,"c:\sql-update.txt")
