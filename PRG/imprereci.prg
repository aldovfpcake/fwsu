SET TALK OFF
SET PROCEDURE TO 
SET PROCEDURE TO c:\fwsu\prg\classliq
ob = CREATEOBJECT("configurar")
objm =CREATEOBJECT("montoescrito")
*ob.Seteo

ob.Seteopat(1)
********************************
vleg = 816
vfechapago = "03-07-2017"
vmes = 6
vano = 2017
vfecpjub = "08-07-2017"
vmonto = " "
arch  = "62017"
banco = "HSBC"
************************
fechapago = CTOD(vfechapago)
nombremes = objm.nombremes(vmes)
ano  = vano
fecpjub = vfecpjub
SELECT * FROM PERSONAL WHERE LEGAJO = vleg INTO CURSOR VPERSOLINEA
SELECT * FROM &arch WHERE LEGAJO = vleg .AND. LIQUIDA=3 ORDER BY CONCEPTO  INTO CURSOR "CURLIQ"
SUM TO impor aporte+sinaporte -descuento
monto = objm.monto(" ",impor)
REPORT FORM c:\fwsu\forms\recibosueldo.frx  TO PRINTER PROMPT NODIALOG PREVIEW
