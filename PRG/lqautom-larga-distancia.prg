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
 *** cargar mes y año
 lq.wmes     = 4
 lq.wano     = 2020
 lq.wempresa  = 1
**************************************
 LOCAL varLeg
 PUBLIC fechapago,monto,nombremes,ano,banco,fecpjub,DiferSueldo
 fechapago = " "
 monto = " "
 nombremes = " "
 ano = 2020
 banco = " "
 fecpjub = " "
 DiferSueldo = 0
 ***CARGAR ARCHIVO DE LIQUIDACION******************************************************
 
 archliq= "42020"
 
 ************************
 lq.wdisplaynove = .t.
 lq.wlegajo  = lagardi.legajo
 lq.wtipoliq  = 3
 lq.buscolegajo
 lq.cargobase
 lq.auditar
* INSERT INTO curliq(legajo,concepto,cantidad,liquida)values(lq.wlegajo,5,1,3)
* INSERT INTO curliq(legajo,concepto,cantidad,liquida)values(lq.wlegajo,6,1,3) 
 
* INSERT INTO curliq(legajo,concepto,cantidad,liquida)values(lq.wlegajo,59,15,3)
* INSERT INTO curliq(legajo,concepto,cantidad,liquida)values(lq.wlegajo,64,15,3) 
 
 IF lq.wmes <> 9
   lq.feriadonotra
 ENDIF
 
 IF lagardi.knm <> 0
    insertar(17,lagardi.knm)
 ENDIF
 
 IF lagardi.kmcien <> 0
    insertar(23,lagardi.kmcien)
 ENDIF
 
 IF lagardi.cargapel <> 0
    insertar(12,7)
    insertar(26,0)
 
 ENDIF
 
 IF lagardi.ctrld <> 0
    insertar(14,lagardi.ctrld)
 ENDIF
 
 IF lagardi.fres <> 0
    insertar(24,lagardi.fres)
    insertar(68,lagardi.fres)
 ENDIF
 
 IF lagardi.cruce <> 0
    insertar(69,lagardi.cruce)
 ENDIF
 
 
 
 
 Varcantkil = lagardi.knm + lagardi.kmcien
 IF lagardi.kmsur2 <> 0
    Varcantkil = Varcantkil-lagardi.kmsur2
 ENDIF    
 
 insertar(70,Varcantkil)
 
 IF lagardi.kmsur2 <> 0
    insertar(400,lagardi.kmsur2)
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
 SELECT * FROM curliq ORDER BY concepto INTO CURSOR curliq readwrite 
 
 IF lq.wlegajo <> 825 
    IF lq.wlegajo <>838
       IF lq.wlegajo <> 875  
          lq.liquida
       ENDIF  
    ENDIF
 ENDIF 
 
* verdif()
 
 
 
 
 
 
 *SET DEVICE TO PRINTER  c:\suerut\recibos
REPORT FORM  RECIBOSUELDOAUTOM  NOCONSOLE PREVIEW 
grabarliq()
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