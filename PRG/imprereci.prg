SET TALK OFF
SET PROCEDURE TO 
SET PROCEDURE TO c:\fwsu\prg\classliq
ob = CREATEOBJECT("configurar")
objm =CREATEOBJECT("montoescrito")
*ob.Seteo

ob.Seteopat(1)
********************************
vleg = 384
vfechapago = "30-11-2018"
vmes = 11
vano = 2018
vfecpjub = "08-011-2018"
vmonto = " "
arch  = "112018"
banco = "HSBC"
************************
fechapago = CTOD(vfechapago)
nombremes = objm.nombremes(vmes)
ano  = vano
fecpjub = vfecpjub
SELECT * FROM PERSONAL WHERE LEGAJO = vleg INTO CURSOR VPERSOLINEA
SELECT * FROM &arch WHERE LEGAJO = vleg .AND. LIQUIDA=4 ORDER BY CONCEPTO  INTO CURSOR "CURLIQ"
SUM TO impor aporte+sinaporte -descuento
*monto = objm.monto(" ",impor)
 monto = " "
REPORT FORM c:\fwsu\forms\recibosueldo-IMG2.frx  TO PRINTER PROMPT NODIALOG PREVIEW
