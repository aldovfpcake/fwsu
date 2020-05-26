*PARAMETERS  Varlegajo
SET TALK OFF
SET PROCEDURE TO 
SET PROCEDURE TO c:\fwsu\prg\classliq
ob = CREATEOBJECT("configurar")
objm =CREATEOBJECT("montoescrito")
*ob.Seteo
PUBLIC nombremes,vano
ob.Seteopat(2)
********************************
Varlegajo = 247
vfechapago = "04-05-2020"
vmes = 4
vano = 2020
vfecpjub = "9-04-2020"
vmonto = " "
arch  = "42020"
banco = "HSBC"
************************
LOCAL Varchi as Character
Varchi = "d:\"+STR(Varlegajo,4)+".PDF"
*Varchi ="D:\MiArchivo2.PDF"
?Varchi
fechapago = CTOD(vfechapago)
nombremes = objm.nombremes(vmes)
ano  = vano
fecpjub = vfecpjub
SELECT * FROM PERSONAL WHERE LEGAJO = Varlegajo INTO CURSOR VPERSOLINEA
SELECT * FROM &arch WHERE LEGAJO = Varlegajo.AND. LIQUIDA=2 ORDER BY CONCEPTO  INTO CURSOR "CURLIQ"
SUM TO impor aporte+sinaporte -descuento
monto = objm.monto(" ",impor)
* monto = " "
*DO FOXYPREVIEWER.APP  
*REPORT FORM c:\fwsu\forms\recibosueldo-tacsa-firma-empleado TO PRINTER PROMPT NODIALOG PREVIEW
*REPORT FORM c:\fwsu\forms\recibosueldo-tacsa TO print
REPORT FORM RECIBOSUELDO TO PRINT
*REPORT FORM  recibosueldo-tacsa-pr OBJECT PDF3() TO FILE (Varchi)