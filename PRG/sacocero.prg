SET PROCEDURE TO c:\fwsu\prg\classliq
SET PATH TO F:\EMPRE1

ob = CREATEOBJECT("configurar")
*ob.Seteo

liquida = "122020"
*SELECT legajo,aporte,sinaporte,descuento,liquida from;
 &liquida WHERE aporte+sinaporte+descuento = 0
 
 DELETE FROM &liquida WHERE aporte+sinaporte+descuento = 0 