SET EXCLUSIVE OFF
SET DATE ITALIAN
SET CENTURY on
SET PATH TO c:\suerut\empre1;C:\FWSU\FORMS
SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET CLASSLIB TO C:\FWSU\CLASES\RH
SET DELETED ON
CLOSE TABLES all
SELECT 0
USE vacaci again
SET FILTER TO dadeu = 1
SET STEP ON 



PUBLIC X AS Object


DO WHILE .not. EOF()
   replace desde WITH CTOD("30-04-2018")
   replace hasta WITH desde + dias
   *? STR(legajo,4) + " " + DTOC(desde) + " " + DTOC(hasta) + " " +STR(dias,2)
   X = CREATEOBJECT("Formvac")
   SELECT legajo,nombre FROM personal WHERE legajo = vacaci.legajo;
   INTO CURSOR trabajador
   x.legajo =  trabajador.legajo
   x.nombre =  trabajador.nombre
   x.desde  =  vacaci.desde
   x.hasta  =  vacaci.hasta
   x.dias   =  vacaci.dias 
   REPORT FORM formvac PREVIEW  
   SELECT vacaci
   SKIP
          
ENDDO


FUNCTION mostrar

 ? STR(x.legajo,4) + " " + DTOC(x.desde) + "  "+ DTOC(x.hasta) + " "+ "dias=" + STR(x.dias,2)

RETURN .t.    



