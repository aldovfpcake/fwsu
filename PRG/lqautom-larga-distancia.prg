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
 lq.wlegajo  = lagardi.legajo
 lq.wtipoliq = 3
 lq.buscolegajo
 lq.cargobase
* INSERT INTO curliq(legajo,concepto,cantidad,liquida)values(lq.wlegajo,5,1,3)
* INSERT INTO curliq(legajo,concepto,cantidad,liquida)values(lq.wlegajo,6,1,3) 
 
* INSERT INTO curliq(legajo,concepto,cantidad,liquida)values(lq.wlegajo,59,15,3)
* INSERT INTO curliq(legajo,concepto,cantidad,liquida)values(lq.wlegajo,64,15,3) 
 
 IF lq.wtipoliq <> 9
   lq.feriadonotra
 ENDIF
 
 IF lagardi.knm <> 0
    insertar(17,lagardi.knm)
 ENDIF
 
 IF lagardi.kmcien <> 0
    insertar(23,lagardi.kmcien)
 ENDIF
 
 IF lagardi.cargapel <> 0
    insertar(12,0)
    insertar(26,0)
 
 ENDIF
 
 IF lagardi.ctrld <> 0
    insertar(14,lagardi.ctrld)
 ENDIF
 
 IF lagardi.fres <> 0
    insertar(24,lagardi.fres)
    insertar(68,lagardi.fres)
 ENDIF
 
 Varcantkil = lagardi.knm + lagardi.kmcien
 insertar(70,Varcantkil)
  
 
 
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
 REPORT FORM  RECIBOSUELDOAUTOM  NOCONSOLE PREVIEW 
 grabarliq()
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
 
 SELECT legajo,concepto FROM &ARCHLIQ WHERE legajo = curliq.legajo AND concepto = curliq.concepto;
 INTO CURSOR EXISTE
 IF EOF()
       SELECT CURLIQ
       SCAN
       		INSERT INTO &ARCHLIQ(legajo,concepto,descrip,cantidad,aporte,sinaporte,descuento,liquida) VALUES;
      	    (lq.wlegajo,CURLIQ.CONCEPTO,CURLIQ.DESCRIP,CURLIQ.CANTIDAD,CURLIQ.APORTE,CURLIQ.SINAPORTE,CURLIQ.DESCUENTO,3)
            
       
       ENDSCAN 
       ? "SUELDO GRABADO....." + STR(curliq.legajo,4)
 ELSE
 
      ? "YA EXISTE LIQUIDACION EN ....=" + STR(curliq.legajo,4)  
 
 ENDIF
 