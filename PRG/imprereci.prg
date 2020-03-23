SET TALK OFF
SET PROCEDURE TO 
SET PROCEDURE TO c:\fwsu\prg\classliq
ob = CREATEOBJECT("configurar")
objm =CREATEOBJECT("montoescrito")
*ob.Seteo
PUBLIC nombremes,vano
ob.Seteopat(2)
********************************
vleg = 247
vfechapago = "04-10-2019"
vmes = 9
vano = 2019
vfecpjub = "13-01-2020"
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
REPORT FORM c:\fwsu\forms\recibosueldo-tacsa-fdo  TO PRINTER PROMPT NODIALOG PREVIEW
