SET TALK OFF
SET PROCEDURE TO 
SET PROCEDURE TO c:\fwsu\prg\classliq
ob = CREATEOBJECT("configurar")
objm =CREATEOBJECT("montoescrito")
*ob.Seteo

ob.Seteopat(2)
********************************
vleg = 250
vfechapago = "2-10-2019"
vmes = 9
vano = 2019
vfecpjub = "11-09-2019"
vmonto = " "
arch  = "92019"
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
* monto = " "
*DO FOXYPREVIEWER.APP  
REPORT FORM c:\fwsu\forms\recibosueldo  TO PRINTER PROMPT NODIALOG PREVIEW
