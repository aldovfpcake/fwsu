SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET EXCLUSIVE OFF
SET DELETED ON
CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
x.Seteopat(1)
SET CLASSLIB TO rh 
SET CLASSLIB TO c:\fwsu\clases\rh
MiArchivoExcel = "c:\suerut\listados\Nomina_30516403523_201811_000.xls"
*Nomina_30516403523_201812_000
oExcel = CreateObject("Excel.Application")
oExcel.Workbooks.Open(MiArchivoExcel)
CLEAR
STORE 0 TO VarSinaporte
PRIVATE String Varsianp,VarCuil,VarNombre
FOR xfila = 6 TO 223
     *SET STEP ON 
     Varsianp =oExcel.application.cells(xfila,28).VALUE
     VarCuil  =oExcel.application.cells(xfila,1).VALUE
   VarNombre  =oExcel.application.cells(xfila,2).VALUE
    * ? ROUND(Varsianp,2)
     buscarlegajo(INT(VarCuil),VarNombre,Varsianp)
      
NEXT



*************************
FUNCTION Buscarlegajo
**********************
PARAMETERS VarCuil,VarNombre,Varsianp
PRIVATE String VarsClu,VarCuil,VarDocu
*SET STEP ON
VarsClu = STR(VarCuil,11)
PART1 =SUBSTR(VarsClu,1,2)
PART2 =SUBSTR(VarsClu,11,1)
PART3 = SUBSTR(VarsClu,3,8)
VarCuil = PART1+ "-"+PART3+"-"+PART2


SELECT legajo,nombre FROM personal  WHERE cuil = VarCuil .and. activo = "A";
into cursor perso
IF EOF()
   *WAIT WINDOW "ERROR NO SE ENCUENTRA " + VarCuil + " " + VarNombre
ENDIF


SELECT legajo,SUM(sinaporte) as sip FROM 112018 WHERE legajo = perso.legajo GROUP BY legajo;
into CURSOR existe
? STR(perso.legajo,4) + " "+ VarNombre + " "+ STR(existe.sip,16,2)

IF existe.sip <> Varsianp
   WAIT WINDOW  STR(perso.legajo,4) + " "+ VarNombre + STR(existe.sip,16,2) + " "+ STR(Varsianp,16,2)
ENDIF
return