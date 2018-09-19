SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET CLASSLIB TO C:\FWSU\CLASES\RH
SET EXCLUSIVE OFF
SET DELETED ON
*CLOSE TABLES all
*SET PATH TO c:\suerut\empre1

x=CREATEOBJECT('configurar')
x.Seteopat(1)

 
 CREATE CURSOR CURLIQ (legajo n(4),concepto n(4),descrip c(35),cantidad n(8,2),aporte n(10,2),sinaporte n(10,2),descuento n(10,2),liquida n(2))
 INDEX on STR(legajo,4) TO c:\suerut\listados\xcurliq
 
 
 lq = CREATEOBJECT('liquidacion')
 lq.wmes     = 8
 lq.wano     = 2018

 LOCAL varLeg
 PUBLIC fechapago,monto,nombremes,ano,banco,fecpjub,DiferSueldo
 fechapago = " "
 monto = " "
 nombremes = " "
 ano = 2018
 banco = " "
 fecpjub = " "
 DiferSueldo = 0
 archliq= "82018"
 lq.wdisplaynove = .t.
 lq.wlegajo  = tablatec.legajo
 **tabhoras.leg
 lq.wtipoliq = 3
 lq.buscolegajo
 lq.cargobase
 
  VarCant   = tablatec.comd
  VarConcep = 59
  insertar(VarConcep,Varcant)
  Varconcep = 64 
  insertar(VarConcep,Varcant)
  det =0
  IF det = 0
     Varconcep = 5
     Varcant   = 1 
     insertar(VarConcep,Varcant)
     Varconcep = 6
     Varcant   = 1 
     insertar(VarConcep,Varcant)
  ENDIF   
     
     
  
  if tablatec.adj <> 0
     Varconcep = 2
     Varcant   = tablatec.adj
     insertar(VarConcep,Varcant) 
  endif

  if tablatec.fer <> 0
     Varconcep = 8
     Varcant   = tablatec.fer
     insertar(VarConcep,Varcant)
  endif

  if tablatec.enf <> 0
     Varconcep = 31
     Varcant   = tablatec.enf
     insertar(VarConcep,Varcant)
     Varconcep = 4
     Varcant   = tablatec.enf
     insertar(VarConcep,Varcant)
  endif
 
 if tablatec.aus <> 0
     Varconcep = 7
     Varcant   = tablatec.aus
     insertar(VarConcep,Varcant)
  endif

  SELECT * FROM curliq ORDER BY concepto INTO CURSOR curliq readwrite 
  lq.liquida
  SELECT 0
 SELECT * FROM personal WHERE legajo = lq.wlegajo INTO CURSOR vpersolinea
 
SELECT curliq
REPORT FORM  RECIBOSUELDOAUTOM  NOCONSOLE PREVIEW 
 
 return



















  *********************
  FUNCTION INSERTAR
  *******************
  Parameters VarConcep,Varcant

  lq.InsertarConceptoBis(VarConcep,Varcant)