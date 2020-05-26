SET EXCLUSIVE off
SET DELETED ON
SET ESCAPE ON
SET PATH TO F:\SUELDOS\EMPRE1
ON ERROR DO errhand WITH ;
ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )


MiArchivoExcel = GETFILE()
oExcel = CreateObject("Excel.Application")
oExcel.Workbooks.Open(MiArchivoExcel)
oExcel.sheets(1).Select
oExcel.Workbooks.Open(miExcel)
oExcel.Sheets(1).Select
LOCAL Varlegajo,VarNombre,VarCuil,VarEmail
clear
FOR I=2 TO 105
     Varlegajo     = oExcel.Cells(i,1).value
     VarNombre     = oExcel.Cells(i,2).value 
     VarEmail      = oExcel.Cells(i,4).value 

     UPDATE personal SET email = VarEmail WHERE legajo = Varlegajo
     
     
     
     
NEXT
? "Proceso Terminado"
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