SET PROCEDURE TO c:\fwsu\prg\classliq
SET PATH TO C:\SUERUT\EMPRE1

ob = CREATEOBJECT("configurar")
*ob.Seteo

liquida = "62019"
*SELECT legajo,aporte,sinaporte,descuento,liquida from;
 &liquida WHERE aporte+sinaporte+descuento = 0
 
 DELETE FROM &liquida WHERE aporte+sinaporte+descuento = 0 .AND.  LEGAJO <> 19