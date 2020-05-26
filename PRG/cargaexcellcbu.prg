SET EXCLUSIVE off
SET DELETED ON
SET ESCAPE ON
SET PATH TO F:\SUELDOS\EMPRE1
SET CLASSLIB TO c:\fwsu\clases\rh
ON ERROR DO errhand WITH ;
ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )

LOCAL p as Object
p = CREATEOBJECT("legajoper")
MiArchivoExcel = GETFILE()
oExcel = CreateObject("Excel.Application")
oExcel.Workbooks.Open(MiArchivoExcel)
oExcel.sheets(1).Select
oExcel.Workbooks.Open(miExcel)
oExcel.Sheets(1).Select
LOCAL Varlegajo,VarNombre,VarCuil,VarEmail
clear
SELECT Legajo,nombre,cbu,p.pasocuil(cuil)as cuil from personal WHERE activo = "A" .AND. legajo > 886 ORDER BY legajo into cursor lista
browse
i = 3
SCAN
      oExcel.Cells(i,2).value  = lista.cuil
      oExcel.Cells(i,3).value  = lista.nombre
      oExcel.Cells(i,4).value  = SUBSTR(lista.cbu,1,22)
      i = i + 1 
         
     
     
ENDSCAN
? "Proceso Terminado"
oExcel.visible = .t
oExcel.quit()



PROCEDURE errhand
PARAMETER merror, mess, mess1, mprog, mlineno

IF merror = 2005
     x = TABLEREVERT( )
ENDIF

IF merror = 111 .or. merror = 1585 .or. merror = 3172
   SELECT curliq
   MESSAGEBOX("Revirtiendo Cambios Tabla de solo lectura",0,"Atención")
   x = TABLEREVERT()
ENDIF    

IF merror = 12
   RETURN
endif   




? 'Error número: ' + LTRIM(STR(merror))
? 'Mensaje de error: ' + mess
? 'Línea de código con error: ' + mess1
? 'Número de línea del error: ' + LTRIM(STR(mlineno))
? 'Programa con error: ' + mprog