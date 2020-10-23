*PARAMETERS Varlegajo
SET DEFAULT TO C:\SUERUT\EMPRE1
SET CLASSLIB TO c:\fwsu\clases\rh
SET DELETED ON
MiArchivoExcel = "c:\suerut\libro-sueldo-digital-afip\librob.xlsx"
oExcel = CreateObject("Excel.Application")
oExcel.Workbooks.Open(MiArchivoExcel)
oExcel.sheets(1).Select
oExcel.Workbooks.Open(MiArchivoExcel)
fso = CreateObject('Scripting.FileSystemObject')
*tf = fso.CreateTextFile('c:\sueldos\ls.txt', .t.)
 tf = fso.OpenTextFile("c:\sueldos\ls.txt",8,0)


oExcel.Sheets(1).Select

linea =   oExcel.Range("J9").value
tf.Writeline(linea)
oExcel.Sheets(2).Select
VarLegajo = 890
datper(VarLegajo)
xl = CREATEOBJECT("legajoper")
LOCAL FechaDePago as String,FormDePago as Integer
FechaDePago = "20201002" 
FormaDePago  = 3
oExcel.visible = .t.
oExcel.Range("b7").Value = ALLTRIM("'02")
oExcel.Range("c7").Value = xl.pasocuil(datper.cuil)
oExcel.Range("f7").Value = ALLTRIM(datper.cbu)
oExcel.Range("h7").Value = FechaDePago
oExcel.Range("j7").Value = FormaDePago
linea =   oExcel.Range("k7").value
tf.Writeline(linea)
*STRTOFILE(linea,"C:\sueldos\linea2.txt")

oExcel.Sheets(3).Select
oExcel.visible = .t.
oExcel.Range("b5").Value = ALLTRIM("'03")
SELECT * FROM 92020 WHERE legajo = Varlegajo.and. liquida =3  ORDER BY concepto INTO CURSOR sueldo
fila = 5
SCAN
   oExcel.cells(fila,2).Value = ALLTRIM("'03")
   oExcel.cells(fila,3) =xl.pasocuil(datper.cuil)
   IF sueldo.concepto = 404
      oExcel.cells(fila,4) = 5404
   ELSE       
     oExcel.cells(fila,4) = sueldo.concepto
   ENDIF
   
   IF sueldo.cantidad > 10000
       oExcel.cells(fila,5) = TRANSFORM(STR(sueldo.cantidad,5),"99999")
   ELSE
       oExcel.cells(fila,5) = TRANSFORM(STR(sueldo.cantidad,4),"99999")
   ENDIF
   IF sueldo.aporte <> 0
      oExcel.cells(fila,7) = TRANSFORM(sueldo.aporte,"999999.99")
      oExcel.cells(fila,8)="C"
      IF sueldo.concepto = 4 .OR. sueldo.concepto = 7 .OR. sueldo.concepto = 22
         oExcel.cells(fila,8)="D"
         VarSue = sueldo.aporte * -1
         oExcel.cells(fila,7) = TRANSFORM(VarSue,"999999.99")
      ENDIF
   ENDIF
   IF sueldo.sinaporte <> 0
      oExcel.cells(fila,7) = TRANSFORM(sueldo.sinaporte,"999999.99")
      oExcel.cells(fila,8)="C"
   ENDIF
   IF sueldo.descuento <> 0
      oExcel.cells(fila,7) = TRANSFORM(sueldo.descuento,"999999.99")
      oExcel.cells(fila,8)="D"
   ENDIF
   linea = oExcel.cells(fila,10).value
   tf.Writeline(linea)   
       
   fila = fila +1


endscan
oExcel.Sheets(4).Select
fila = 5
oExcel.cells(fila,2)= ALLTRIM("'04")
oExcel.cells(fila,3) =xl.pasocuil(datper.cuil)
oExcel.cells(fila,6) =1
oExcel.cells(fila,7) =1
oExcel.cells(fila,8) =0
oExcel.cells(fila,9) =1
oExcel.cells(fila,11)= ALLTRIM(datper.situaret)
oExcel.cells(fila,12)= ALLTRIM(datper.condcod)
oExcel.cells(fila,13)= ALLTRIM(datper.codigoacti)
oExcel.cells(fila,14)= ALLTRIM(datper.mccdo)
oExcel.cells(fila,15)= ALLTRIM(datper.codsiniest)
oExcel.cells(fila,16)= ALLTRIM(datper.zonageogra)
oExcel.cells(fila,17)= ALLTRIM(datper.situaret)
oExcel.cells(fila,18)= ALLTRIM(STR(datper.diani1,1))
oExcel.cells(fila,19)= ""
oExcel.cells(fila,20)= "0"
oExcel.cells(fila,21)= " "
oExcel.cells(fila,22)=  0
oExcel.cells(fila,23)= 30
oExcel.cells(fila,24)= 0
oExcel.cells(fila,25)= 0
IF datper.categoria = "COND"
   oExcel.cells(fila,26)= 2
ELSE
   oExcel.cells(fila,26)= 0 
ENDIF   

oExcel.cells(fila,27)= ALLTRIM(datper.dgiobrasoc)
SELECT sueldo
SUM sueldo.aporte TO bruto
SUM sueldo.aporte + sueldo.sinaporte TO stotal
oExcel.cells(fila,32)= 0
oExcel.cells(fila,34)= 0
oExcel.cells(fila,35)= TRANSFORM(stotal,"999999.99")
oExcel.cells(fila,36)= TRANSFORM(bruto,"999999.99")
oExcel.cells(fila,37)= TRANSFORM(bruto,"999999.99")
oExcel.cells(fila,38)= TRANSFORM(bruto,"999999.99")
oExcel.cells(fila,39)= TRANSFORM(bruto,"999999.99")
oExcel.cells(fila,40)= TRANSFORM(bruto,"999999.99")
oExcel.cells(fila,43)= TRANSFORM(bruto,"999999.99")
oExcel.cells(fila,44)= TRANSFORM(bruto,"999999.99")
rm =bruto -7003.50
oExcel.cells(fila,47)= TRANSFORM(rm,"999999.99")
oExcel.cells(fila,48)=7003.50
IF datper.categoria = "DIRECTOR"
   oExcel.cells(fila,47)= TRANSFORM(bruto,"999999.99")
   oExcel.cells(fila,48)= 0
ENDIF

linea = oExcel.Range("AW5").value
tf.Writeline(linea)
tf.close 
oExcel.visible = .t.



oExcel.quit()
WAIT WINDOW "fin"








FUNCTION datper
PARAMETERS xleg
SELECT * FROM personal WHERE legajo= xleg INTO CURSOR datper




RETURN .t.


FUNCTION SUELDO
PARAMETERS xleg
SELECT * FROM 92020 WHERE legajo = xleg .and. liquida = 3 INTO CURSOR sueldo
RETURN .t.

