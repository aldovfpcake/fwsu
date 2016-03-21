SET PROCEDURE TO t:\fwsu\prg\classliq
 
 lq = CREATEOBJECT('liquidacion')
 lq.wmes     = thisform.mes
 lq.wano     = thisform.ano

 lq.wdisplaynove = .t.
 lq.wlegajo  = thisform.txtLegajo.Value
 lq.wtipoliq = thisform.tipoliq
 lq.buscolegajo
 lq.cargobase
 lq.liquida
 