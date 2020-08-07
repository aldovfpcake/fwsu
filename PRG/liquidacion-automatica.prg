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

**********************************************************periodo de liquidacion
 lq.wmes     = 7
 lq.wano     = 2020
**********************************************************************************
 LOCAL varLeg
 PUBLIC fechapago,monto,nombremes,ano,banco,fecpjub,DiferSueldo
 fechapago = " "
 monto = " "
 nombremes = " "
 ano = 2020
 banco = " "
 fecpjub = " "
 DiferSueldo = 0
*****************************archivo de liquidación
 archliq= "72020"
 *****************************************************************w
 lq.wdisplaynove = .t.
 lq.wlegajo  = tabhoras.leg
 **tabhoras.leg
 lq.wtipoliq = 3
 lq.wempresa = 1
 lq.buscolegajo
 lq.cargobase
* INSERT INTO curliq(legajo,concepto,cantidad,liquida)values(lq.wlegajo,5,1,3)
* INSERT INTO curliq(legajo,concepto,cantidad,liquida)values(lq.wlegajo,6,1,3) 
 lq.InsertarConceptoBis(401,tabhoras.comida)
 lq.InsertarConceptoBis(403,tabhoras.comida)
 lq.InsertarConceptoBis(6,tabhoras.horcien)
 lq.InsertarConceptoBis(5,tabhoras.horcta)
 IF tabhoras.parfer <> 0
    lq.InsertarConceptoBis(8,tabhoras.parfer)
 
 ENDIF
 
 IF tabhoras.diasnotra <> 0
    lq.InsertarConceptoBis(4,tabhoras.diasnotra)
 
 ENDIF
 
 
 
* INSERT INTO curliq(legajo,concepto,cantidad,liquida)values(lq.wlegajo,59,15,3)
* INSERT INTO curliq(legajo,concepto,cantidad,liquida)values(lq.wlegajo,64,15,3) 
 
 IF lq.wmes <> 9
   lq.feriadonotra
 ENDIF
 
 IF tabhoras.enf <>0
     IF tabhoras.enf >= 30
        DELETE FROM CURLIQ WHERE CONCEPTO = 401 .OR. CONCEPTO = 403
     ELSE
        lq.InsertarConceptoBis(4,tabhoras.enf)
        lq.InsertarConceptoBis(31,tabhoras.enf)
        UPDATE CURLIQ SET CANTIDAD = (25 -TABHORAS.ENF) WHERE CONCEPTO = 401 
        UPDATE CURLIQ SET CANTIDAD = (25 -TABHORAS.ENF) WHERE CONCEPTO = 403 
     ENDIF
     
 ENDIF
 
 
 IF tabhoras.aus <> 0
    lq.InsertarConceptoBis(7,tabhoras.aus) 
    UPDATE CURLIQ SET CANTIDAD = (25 -TABHORAS.AUS) WHERE CONCEPTO = 401
    UPDATE CURLIQ SET CANTIDAD = (25 -TABHORAS.AUS) WHERE CONCEPTO = 403 
 
 
 ENDIF
 
 SELECT * FROM curliq ORDER BY concepto INTO CURSOR curliq readwrite 
 lq.liquida
 
 **********************
 *SELECT * FROM personal WHERE legajo = lq.wlegajo INTO CURSOR vpersolinea
 *determ()
 ************************
 
 SELECT curliq

 SELECT 0
 SELECT * FROM personal WHERE legajo = lq.wlegajo INTO CURSOR vpersolinea
 
 SELECT curliq
* verdif()
 
 *SET DEVICE TO PRINTER  c:\suerut\recibos
REPORT FORM  RECIBOSUELDOAUTOM PREVIEW     
grabarliq()
* grabatabla()
* grabacincuenta()
 *grabacien() 
* grabaferi()
 return
 
 
 
 ******************
 FUNCTION determ
 *******************
 SELECT curliq
 SUM aporte+sinaporte -descuento TO neto
 clear
 ?neto
  SELECT aporte as Imp FROM curliq WHERE concepto = 5 INTO CURSOR valh
  SELECT aporte as Imp FROM curliq WHERE concepto = 6 INTO CURSOR valcien
  dif = vpersolinea.sueldofijo - neto
  DiferSueldo = dif  
  ?"Diferencia..........:" + STR(dif,10,2)
  IF dif > 100
  	thc = dif/valh.Imp
  	?"Total Hs 50 %.......:" + STR(thc,10,2)  
  	hs50   =  (dif *70/100)/valh.Imp
  	totci  = hs50*valh.imp
  	tocien = dif - totci
  	hs100  = tocien/valcien.imp
  	? "Horas 50% =" + STR(hs50,4) + " Horas 100%=" + STR(hs100,4)
    SELECT tabhoras
    rec = RECNO()
     
    tothorcta   = INT(hs50)+4
    tothorcien  = INT(hs100)+4
    
    IF tothorcta > 100
       tothorcta = 99
    ENDIF
        
    IF tothorcien > 100
       tothorcien = 99
    ENDIF    
       
    UPDATE tabhoras set horcta   = tothorcta,;
                        horcien  = tothorcien,;
                        valcicta = valh.imp;
                        WHERE leg = vpersolinea.legajo
    GO rec                    
 endif
   SELECT curliq
 return
 
 
 *********************
 FUNCTION Verdif
 *******************

 SELECT curliq
 SUM aporte+sinaporte -descuento TO neto
 dif = vpersolinea.sueldofijo - neto
 DiferSueldo = dif  
 SELECT tabhoras
    rec = RECNO()
    UPDATE tabhoras set valferiado = neto - saldif;
                        WHERE leg = vpersolinea.legajo
  GO rec 
 
 SELECT curliq
 return 
 
 
 
 
 *************
 FUNCTION GRABARLIQ
 ********************
 
 SELECT legajo,concepto FROM &ARCHLIQ WHERE legajo = curliq.legajo AND concepto = curliq.concepto;
 INTO CURSOR EXISTE
 IF EOF()
       SELECT CURLIQ
       SCAN
       		INSERT INTO &ARCHLIQ(legajo,concepto,descrip,cantidad,aporte,sinaporte,descuento,liquida) VALUES;
      	    (lq.wlegajo,CURLIQ.CONCEPTO,CURLIQ.DESCRIP,CURLIQ.CANTIDAD,CURLIQ.APORTE,CURLIQ.SINAPORTE,CURLIQ.DESCUENTO,3)
             ?"Grabando"
       
       ENDSCAN 
 
 ENDIF
 
 
 *************************
 FUNCTION GRABATABLA
 **********************
 SELECT curliq
 SUM aporte+sinaporte -descuento TO neto
 
 
 SELECT vpersolinea.legajo FROM basehoras WHERE legajo = vpersolinea.legajo INTO CURSOR VERSIESTA
 IF EOF()
    INSERT INTO basehoras(legajo,nombre,sueldoneto) VALUES (vpersolinea.legajo,vpersolinea.nombre,neto)
 ELSE   
   UPDATE basehoras SET sueldoneto = neto;
   WHERE LEGAJO = VPERSOLINEA.LEGAJO
 ENDIF   
 
 
   
   **************************
   FUNCTION grabacincuenta
   **************************
   LOCAL valhsci
   SELECT curliq
   SUM aporte+sinaporte -descuento TO netocin
    ?"Grabando horas al 50% " + STR(vpersolinea.legajo,4)
   SELECT vpersolinea.legajo,sueldoneto FROM basehoras WHERE legajo = vpersolinea.legajo INTO CURSOR VERSIESTA
   
   valhsci =  netocin - versiesta.sueldoneto
   ?"Valor Hora 50%" + STR(valhsci,4)
    
   UPDATE basehoras SET horcincuen = valhsci WHERE BASEHORAS.LEGAJO = VPERSOLINEA.LEGAJO
   ? _TALLY
   RETURN 
 
    **************************
   FUNCTION grabacien
   **************************
   LOCAL valhsci
   SELECT curliq
   SUM aporte+sinaporte -descuento TO netocin
   
   SELECT vpersolinea.legajo,sueldoneto FROM basehoras WHERE legajo = vpersolinea.legajo INTO CURSOR VERSIESTA
   
   valhsci =  netocin - versiesta.sueldoneto
    
   UPDATE basehoras SET horascien = valhsci WHERE BASEHORAS.LEGAJO = VPERSOLINEA.LEGAJO
   ? _TALLY
   RETURN 
   
   
   
    **************************
   FUNCTION grabaferi
   **************************
   LOCAL valhsci
   SELECT curliq
   SUM aporte+sinaporte -descuento TO netocin
   
   SELECT vpersolinea.legajo,sueldoneto FROM basehoras WHERE legajo = vpersolinea.legajo INTO CURSOR VERSIESTA
   
   valhsci =  netocin - versiesta.sueldoneto
    
   UPDATE basehoras SET valorfer = valhsci WHERE BASEHORAS.LEGAJO = VPERSOLINEA.LEGAJO
   ? _TALLY
   RETURN 