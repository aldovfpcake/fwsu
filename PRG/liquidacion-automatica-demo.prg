
PARAMETERS ParmLegajo
SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET CLASSLIB TO C:\FWSU\CLASES\RH
SET EXCLUSIVE OFF
SET DELETED ON

SET PROCEDURE TO c:\fwsu\prg\classliq
ob = CREATEOBJECT("configurar")
ob.Seteopat(8)
 
 lq = CREATEOBJECT('liquidacion')
 lq.wmes     = 9
 lq.wano     = 2020
 lq.wempresa = 1
 LOCAL varLeg

 
 lq.wdisplaynove = .t.
 lq.wlegajo  = ParmLegajo
 lq.wtipoliq = 3
 lq.buscolegajo
 lq.cargobase
 if lq.wmes <> 9
   lq.feriadonotra
 ENDIF
 lq.liquida
 vlegajo = lq.wlegajo
 vliquida =lq.wtipoliq
 REQUERY()
 BROWSE
 return