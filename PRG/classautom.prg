Define Class lqautom as custom
	
           

  	Procedure Init
 	 	   SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
    	   SET CLASSLIB TO C:\FWSU\CLASES\RH
    	    CREATE CURSOR CURLIQ (legajo n(4),concepto n(4),descrip c(35),cantidad n(8,2),aporte n(10,2),sinaporte n(10,2),descuento; n(10,2),liquida n(2)) INDEX on STR(legajo,4) TO c:\suerut\listados\xcurliq
 
 
       	   x = CREATEOBJECT( "configurar")

       	   lq = CREATEOBJECT('liquidacion')
   
       	   ?"Clase instanciada"  
  	Endproc

















Enddefine