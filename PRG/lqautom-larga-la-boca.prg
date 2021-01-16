parameters Varleg
SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET CLASSLIB TO C:\FWSU\CLASES\RH
SET EXCLUSIVE OFF
SET DELETED ON

x=CREATEOBJECT('configurar')
x.Seteopat(1)

 
 CREATE CURSOR CURLIQ (legajo n(4),concepto n(4),descrip c(35),cantidad n(8,2),aporte n(10,2),sinaporte n(10,2),descuento n(10,2),liquida n(2))
 INDEX on STR(legajo,4) TO c:\suerut\listados\xcurliq


 
 lq = CREATEOBJECT('liquidacion')
 *** cargar mes y a�o
 lq.wmes     = 6
 lq.wano     = 2020
 lq.wempresa  = 1
**************************************
* LOCAL varLeg
 PUBLIC fechapago,monto,nombremes,ano,banco,fecpjub,DiferSueldo
 fechapago = " "
 monto = " "
 nombremes = " "
 ano = 2020
 banco = " "
 fecpjub = " "
 DiferSueldo = 0
 ***CARGAR ARCHIVO DE LIQUIDACION******************************************************
 
 archliq= "62020"
 
 ************************
 INSERT INTO CURLIQ (CONCEPTO,CANTIDAD,APORTE,SINAPORTE);
 SELECT CONCEPTO,CANTIDAD,APORTE,SINAPORTE FROM (archliq) where legajo = Varleg .and. liquida = 3

 lq.wdisplaynove = .t.
 lq.wlegajo  = Varleg
 lq.wtipoliq  = 3
 lq.buscolegajo
 lq.cargobase
 lq.auditar
 SELECT * FROM curliq ORDER BY concepto INTO CURSOR curliq readwrite
 lq.liquida
 SELECT 0
 SELECT * FROM personal WHERE legajo = lq.wlegajo INTO CURSOR vpersolinea
 select curliq
 REPORT FORM  RECIBOSUELDOAUTOM  NOCONSOLE PREVIEW 
 *grabarliq()
*borrar()
 return





******************* 
FUNCTION insertar
********************
PARAMETERS concep,lwcantidad
 lq.InsertarConceptoBis(concep,lwcantidad)
return


*************
 FUNCTION GRABARLIQ
 ********************
 
 SELECT legajo,concepto FROM &ARCHLIQ WHERE legajo = lq.wlegajo AND concepto = curliq.concepto AND liquida = 3;
 INTO CURSOR EXISTE
 IF EOF()
       SELECT CURLIQ
       SCAN
       		INSERT INTO &ARCHLIQ(legajo,concepto,descrip,cantidad,aporte,sinaporte,descuento,liquida) VALUES;
      	    (lq.wlegajo,CURLIQ.CONCEPTO,CURLIQ.DESCRIP,CURLIQ.CANTIDAD,CURLIQ.APORTE,CURLIQ.SINAPORTE,CURLIQ.DESCUENTO,3)
            
       
       ENDSCAN 
       ? "SUELDO GRABADO....." + STR(lq.wlegajo,4)
 ELSE
       SELECT CURLIQ
       SCAN
           UPDATE &ARCHLIQ SET legajo    = lq.wlegajo,;
                               concepto  = curliq.concepto,;
                               descrip   = curliq.descrip,;
                               cantidad  = curliq.cantidad,;
                               aporte    = curliq.aporte,;
                               sinaporte = curliq.sinaporte,;
                               descuento = curliq.descuento,;
                               liquida   = curliq.liquida;
                               WHERE legajo = lq.wlegajo .and. liquida = 3
       
         ? " ACTUALIZANDO SUELDO....." + STR(lq.wlegajo,4)
    
  
       ENDSCAN   
 
 ENDIF
 SELECT EXISTE
 USE
 
 
 ***********************************
 FUNCTION BORRAR
 **************************************
 DELETE FROM &ARCHLIQ WHERE legajo = lq.wlegajo .and. liquida = 3 
 ?"BORRANDO LIQUIDACION.................." + STR(lq.wlegajo,4)