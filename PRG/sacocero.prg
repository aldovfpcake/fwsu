SET PROCEDURE TO c:\fwsu\prg\classliq
ob = CREATEOBJECT("configurar")
*ob.Seteo
ob.Seteopat(1)
liquida = "52018"
*SELECT legajo,aporte,sinaporte,descuento,liquida from;
 &liquida WHERE aporte+sinaporte+descuento = 0
 
 DELETE FROM 92018 WHERE aporte+sinaporte+descuento = 0 