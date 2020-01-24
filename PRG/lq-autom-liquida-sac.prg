SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET CLASSLIB TO C:\FWSU\CLASES\RH
SET EXCLUSIVE OFF
SET DELETED ON
SET ESCAPE ON
*CLOSE TABLES all
*SET PATH TO c:\suerut\empre1

x=CREATEOBJECT('configurar')
x.Seteopat(2)

 
 CREATE CURSOR CURLIQ (legajo n(4),concepto n(4),descrip c(35),cantidad n(8,2),aporte n(10,2),sinaporte n(10,2),descuento n(10,2),liquida n(2))
 INDEX on STR(legajo,4) TO c:\suerut\listados\xcurliq
 
 CREATE CURSOR GLIQ (legajo n(4),concepto n(4),descrip c(35),cantidad n(8,2),aporte n(10,2),sinaporte n(10,2),descuento n(10,2),liquida n(2))
 INDEX on STR(legajo,4) TO c:\suerut\listados\xcurliq2
 
 
 
 lq = CREATEOBJECT('liquidacion')
 *** cargar mes y año
 lq.wmes     = 12
 lq.wano     = 2019
**************************************
 LOCAL varLeg
 PUBLIC fechapago,monto,nombremes,ano,banco,fecpjub,DiferSueldo
 fechapago = " "
 monto = " "
 nombremes = " "
 ano = 2018
 banco = " "
 fecpjub = " "
 DiferSueldo = 0
 archliq= "122018"
 lq.wdisplaynove = .t.
 lq.wlegajo  = sueldosfijos.legajo
 lq.wtipoliq = 4
 lq.buscolegajo
 lq.cargobase
 Varsac = 0
 Varsac = (sueldosfijos.sueldo/2)
 IF lq.wlegajo = 1 .OR. legajo = 12 .or. legajo = 4
    Varpor = Varsac *0.155
    Varsac = Varsac + Varpor
 else
    Varpor = Varsac *0.275
    Varsac = Varsac + Varpor
 ENDIF
 *insertar (18,varsac)
  INSERT INTO curliq(legajo,concepto,aporte,liquida)values(lq.wlegajo,18,Varsac,4)
* INSERT INTO curliq(legajo,concepto,cantidad,liquida)values(lq.wlegajo,6,1,3) 
 
* INSERT INTO curliq(legajo,concepto,cantidad,liquida)values(lq.wlegajo,59,15,3)
* INSERT INTO curliq(legajo,concepto,cantidad,liquida)values(lq.wlegajo,64,15,3) 
 
 
 SELECT * FROM curliq ORDER BY concepto INTO CURSOR curliq readwrite 
 lq.liquida
 
 **********************
 *SELECT * FROM personal WHERE legajo = lq.wlegajo INTO CURSOR vpersolinea
 *determ()
 ************************
 
 SELECT curliq
 UPDATE personal SET sueldofijo = sueldosfijos.sueldo WHERE legajo = sueldosfijos.legajo
 SELECT 0
 SELECT * FROM personal WHERE legajo = lq.wlegajo INTO CURSOR vpersolinea
 *replace sueldofijo WITH sueldosfjos.sueldo
 
 SELECT curliq
* verdif()
 GO top
 lq.liquida
 
 
 *SET DEVICE TO PRINTER  c:\suerut\recibos
 *REPORT FORM  RECIBOSUELDOAUTOM TO FILE AVER
 * borrar()
 grabarliq()
  
 return





*******************
FUNCTION insertar
********************
PARAMETERS concep,lwcantidad
 *lq.InsertarConceptoBis(concep,lwcantidad)
INSERT INTO curliq (concepto,descrip,aporte) VALUES (concep," S.a.c.",lwcantidad)

return


*************
 FUNCTION GRABARLIQ
 ********************
 
 SELECT legajo,concepto FROM &ARCHLIQ WHERE legajo = lq.wlegajo AND concepto = curliq.concepto AND liquida = 4;
 INTO CURSOR EXISTE
 IF EOF()
       SELECT CURLIQ
       SCAN
       		INSERT INTO &ARCHLIQ(legajo,concepto,descrip,cantidad,aporte,sinaporte,descuento,liquida) VALUES;
      	    (lq.wlegajo,CURLIQ.CONCEPTO,CURLIQ.DESCRIP,CURLIQ.CANTIDAD,CURLIQ.APORTE,CURLIQ.SINAPORTE,CURLIQ.DESCUENTO,4)
            
       
       ENDSCAN 
       ? "SUELDO GRABADO....." + STR(lq.wlegajo,4)
 ELSE
 
      ? "YA EXISTE LIQUIDACION EN ....=" + STR(lq.wlegajo,4)  
 
 ENDIF
 
 
 ************************
 FUNCTION BORRAR
 *****************
 DELETE FROM &ARCHLIQ WHERE LEGAJO = CURLIQ.LEGAJO  .AND. LIQUIDA = 4
 
 
 