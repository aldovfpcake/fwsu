SET EXCLUSIVE off
SET DELETED ON
SET ESCAPE ON
SET PATH TO F:\SUELDOS\EMPRE1
ON ERROR DO errhand WITH ;
ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )
MiArchivoExcel = "F:\ALDO\AVELLANEDA-LD\KMS-DICIEMBRE-2019.XLS"
oExcel = CreateObject("Excel.Application")
oExcel.Workbooks.Open(MiArchivoExcel)
STORE 0 TO  VarKNM, VarKMCIEN, VarKMSUR2, VarKMSUR4, VarCTRLD, VarFRES, VarCRUCE, VarCARGAPEL 
Clear
FOR i=18 TO 50
    Varlegajo     = oExcel.Cells(i,1).value
    Varknm        = oExcel.Cells(i,4).value
    VarKmcien     = oExcel.Cells(i,5).value
    Varkmsur2     = oExcel.Cells(i,6).value
    VarCtrld      = oExcel.Cells(i,11).value  
    VarFres       = oExcel.Cells(i,12).value
    VarCruce      = oExcel.Cells(i,13).value
      
    IF .not. ISNULL(Varlegajo)
            
            ?Varlegajo
            
            UPDATE LAGARDI;
        	SET KNM= VarKNM,;
        	KMCIEN= VarKmcien,;
        	KMSUR2=VarKMSUR2,;
 	   		KMSUR4=VarKMSUR4,;
       		CTRLD=VarCTRLD,;
       		FRES=VarFRES,;
       		CRUCE=VarCRUCE,;
       		CARGAPEL= VarCARGAPEL;
       		WHERE LEGAJO = Varlegajo
    ENDIF
    STORE 0 TO  VarKNM, VarKMCIEN, VarKMSUR2, VarKMSUR4, VarCTRLD, VarFRES, VarCRUCE, VarCARGAPEL 

NEXT




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

