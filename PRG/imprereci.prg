SET TALK OFF
SET PROCEDURE TO 
SET PROCEDURE TO c:\fwsu\prg\classliq
ob = CREATEOBJECT("configurar")
objm =CREATEOBJECT("montoescrito")
*ob.Seteo
PUBLIC nombremes,vano
ob.Seteopat(2)
********************************
vleg = 248
vfechapago = "21-01-2020"
vmes = 1
vano = 2020
vfecpjub = "11-12-2019"
vmonto = " "
arch  = "12020"
banco = "HSBC"
************************

fechapago = CTOD(vfechapago)
nombremes = objm.nombremes(vmes)
ano  = vano
fecpjub = vfecpjub
SELECT * FROM PERSONAL WHERE LEGAJO = vleg INTO CURSOR VPERSOLINEA
SELECT * FROM &arch WHERE LEGAJO = vleg .AND. LIQUIDA=1 ORDER BY CONCEPTO  INTO CURSOR "CURLIQ"
SUM TO impor aporte+sinaporte -descuento
monto = objm.monto(" ",impor)
* monto = " "
*DO FOXYPREVIEWER.APP  
REPORT FORM c:\fwsu\forms\recibosueldo-tacsa  TO PRINTER PROMPT NODIALOG PREVIEW
