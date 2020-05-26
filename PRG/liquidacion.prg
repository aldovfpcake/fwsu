*PARAMETERS emp
*WAIT WINDOW STR(emp,1)
*CLOSE databases
SET TALK OFF
SET EXCLUSIVE OFF
SET DATE ITALIAN
SET REPROCESS TO AUTOMATIC
SET MULTILOCKS ON
SET DELETED ON
*SET PATH TO t:\FWSU\FORMS;t:\FWSU\PRG;F:\FWSU\CLASES;F:\SUELDOS\EMPRE1;F:\SUELDOS
SET PROCEDURE TO c:\fwsu\prg\classliq
ob = CREATEOBJECT("configurar")
*ob.Seteo
* 6 demo
emp = 2
DO case
   CASE emp = 1
	    seteo = 1
   		ob.Seteopat(1)
   CASE emp = 2
        seteo = 2
   		ob.Seteopat(2)
   CASE emp = 3
        seteo = 3
   		ob.Seteopat(3)
   CASE emp = 6
        ob.Seteopat(6)    
ENDCASE
   		

OPEN DATABASE SUELDOS SHARED
ON ERROR DO errhand WITH ;
ERROR( ), MESSAGE( ), MESSAGE(1), PROGRAM( ), LINENO( )

SELECT 0
SELECT * FROM personal WHERE activo = "A" ORDER BY LEGAJO INTO CURSOR vpersolinea READWRITE
*SELECT 0
*IF .NOT. USED('B92013')
*    SELECT 0
*    USE B92013
*ENDIF
IF .NOT. USED('comentarios')
    SELECT 0
    USE comentarios NODATA
ENDIF  


IF .NOT. USED('curliq')
    SELECT 0
    USE curliq NODATA
ENDIF  
lSuccess=CURSORSETPROP("Buffering", 3, "curliq")
IF lSuccess = .f.
    =MESSAGEBOX("Operation NOT successful!",0,"Operation Status")
ENDIF
_screen.Visible = .F.
SELECT * FROM CODSUEL ORDER BY CONCEPTO INTO CURSOR CONCEPTOS   
SET EXCLUSIVE ON
SELECT curliq
*INDEX on STR(concepto,4) TO  c:\x-curl
*SET INDEX TO f:\sueldos\x-curl
SET EXCLUSIVE OFF
************************** mes y año de liquidacion
PRIVATE vmes,vano
vmes = 5
vano = 2020
*********************************************************
IF seteo = 6
   VarStringDe = "Modo Demo"
ELSE
   VarStringDe = " "
ENDIF      
DO FORM liquidacion WITH "MAYO 2020" +VarStringDe ,vmes,vano,emp
READ EVENTS

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







DO FORM FORMERROR

CLEAR
? 'Error número: ' + LTRIM(STR(merror))
? 'Mensaje de error: ' + mess
? 'Línea de código con error: ' + mess1
? 'Número de línea del error: ' + LTRIM(STR(mlineno))
? 'Programa con error: ' + mprog






RETURN   