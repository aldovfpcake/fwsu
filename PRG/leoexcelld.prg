SET EXCLUSIVE off
SET DELETED ON
SET ESCAPE ON
SET PATH TO F:\SUELDOS\EMPRE1
ON ERROR DO errhand WITH ;
ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )


MiArchivoExcel = "F:\ALDO\AVELLANEDA-LD\aver4.xls"
oExcel = CreateObject("Excel.Application")
oExcel.Workbooks.Open(MiArchivoExcel)
oExcel.sheets(1).Select
oExcel.Workbooks.Open(miExcel)
oExcel.Sheets(1).Select
clear
*DO borra

STORE 0 TO  VarKNM, VarKMCIEN, VarKMSUR2, VarKMSUR4, VarCTRLD, VarFRES, VarCRUCE, VarCARGAPEL 
CLEAR
 

 
FOR i=3 TO 10              
    Varlegajo     = oExcel.Cells(i,1).value
    Varknm        = oExcel.Cells(i,4).value
    VarKmcien     = oExcel.Cells(i,5).value
    Varkmsur2     = oExcel.Cells(i,6).value
    VarCtrld      = oExcel.Cells(i,11).value  
    VarFres       = oExcel.Cells(i,12).value
    VarCruce      = oExcel.Cells(i,13).value
    *****************VERIFICAR
    VarCARGAPEL   = 0
    **************************
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
   MESSAGEBOX("Revirtiendo Cambios Tabla de solo lectura",0,"Atenci�n")
   x = TABLEREVERT()
ENDIF    

IF merror = 12
   RETURN
endif   




? 'Error n�mero: ' + LTRIM(STR(merror))
? 'Mensaje de error: ' + mess
? 'L�nea de c�digo con error: ' + mess1
? 'N�mero de l�nea del error: ' + LTRIM(STR(mlineno))
? 'Programa con error: ' + mprog


**************************
PROCEDURE borra
*************************
UPDATE lagardi SET knm   = 0,;
 kmcien = 0,; 
 kmsur2= 0,;
 kmsur4 = 0,;  
 ctrld = 0,; 
 fres  = 0,;
 cruce = 0,;
 cargapel= 0;
