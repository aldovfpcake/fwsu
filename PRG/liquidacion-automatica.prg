SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET CLASSLIB TO C:\FWSU\CLASES\RH
SET EXCLUSIVE OFF
SET DELETED ON
CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
x.Seteopat(1)

 
 CREATE CURSOR CURLIQ (legajo n(4),concepto n(4),descrip c(35),cantidad n(8,2),aporte n(10,2),sinaporte n(10,2),descuento n(10,2),liquida n(2))
 INDEX on STR(legajo,4) TO c:\suerut\listados\xcurliq
 
 
 lq = CREATEOBJECT('liquidacion')
 lq.wmes     = 7
 lq.wano     = 2018

 LOCAL varLeg
 PUBLIC fechapago,monto,nombremes,ano,banco,fecpjub
 fechapago = " "
 monto = " "
 nombremes = " "
 ano = 2018
 banco = " "
 fecpjub = " "
 lq.wdisplaynove = .t.
 lq.wlegajo  = 191
 lq.wtipoliq = 3
 lq.buscolegajo
 lq.cargobase
 INSERT INTO curliq(legajo,concepto,cantidad,liquida)values(lq.wlegajo,5,1,3)
 INSERT INTO curliq(legajo,concepto,cantidad,liquida)values(lq.wlegajo,6,1,3) 
 lq.InsertarConceptoBis(59,25)
 lq.InsertarConceptoBis(64,25)
 lq.InsertarConceptoBis(8,1)
* INSERT INTO curliq(legajo,concepto,cantidad,liquida)values(lq.wlegajo,59,15,3)
* INSERT INTO curliq(legajo,concepto,cantidad,liquida)values(lq.wlegajo,64,15,3) 
 SELECT * FROM curliq ORDER BY concepto INTO CURSOR curliq readwrite 
 
 lq.liquida
 SELECT curliq
* BROWSE
 SELECT 0
 SELECT * FROM personal WHERE legajo = lq.wlegajo INTO CURSOR vpersolinea
 
 SELECT curliq
 REPORT FORM  RECIBOSUELDO TO PRINTER PROMPT NODIALOG PREVIEW
 