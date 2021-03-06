*CREATE CURSOR CURLIQ (concepto n(4),deno c(35),cantidad n(8,2),aporte n(10,2),sinaporte n(10,2),descuento n(10,2))
*CREATE CURSOR CURLIQ (concepto n(4),deno c(35),cantidad n(8,2),aporte n(10,2),sinaporte n(10,2),descuento n(10,2))


Define Class LIQUIDACION As Custom
	wlegajo		 = 0
	wfechaingreso = Date()
	wfechaliq     = Date()
	wimporte      = 0
	Declare wacumula(100)
	wembargo      = 0
	wbasico       = 0
	wconextracc   = "  "
	wantiganterior= 0
	wcancelar     = .T.
	wmes          =  1
	wano          = 2013
	wcant         = 0
	wcategoria	  = " "
	wdivide    	  = 0
	wporciento 	  = 0
	wmultiplica   = 0
    wsuma         = " "
    wmodocarg     = " "
	wtipoliq      = 3
	wtipoconcep   = " "
	wacumulador   = 0
	wdesde        = 0
	whasta        = 0 
	wmesanterior  = " "
	wdescrip      = " "  
	waporte       = 0
	wtotsinapor   = 0
	wtotaporneg   = 0
	wtotdescue    = 0
	wdisplaynove  = .f.
	Wpromesu      = 0
	Wempresa      = 0
	Procedure Init
		Set Date Italian
		Set Century On
		SET exclusive off
		SET DELETED on
		*Select curliq
		*SET FILTER TO legajo = this.wlegajo .and. liquida = this.wtipoliq
		
		*This.buscolegajo
		*this.cargobase

	Endproc

	Procedure LIQUIDA
	    Local wvalorfin As Decimal
        for i = 1 To Alen(This.wacumula)
			This.wacumula(i) = 0
		Endfor
		

	    IF this.wmes = 12 .and. this.wtipoliq = 3
		   IF this.wempresa = 1
              IF this.wlegajo <> 755 .or. this.wlegajo <> 600
		         this.cargodiacam
		      ENDIF
           ENDIF

		ENDIF    
		
		
		Select curliq
		GO top
		SCAN FOR LEGAJO = this.wlegajo .and. LIQUIDA = this.wtipoliq
		    this.wcant = curliq.cantidad
			This.bsconcepto(curliq.concepto)
			Select curliq
			If This.wcancelar = .F.
				Exit
			Endif

			Do Case

				Case This.wconextracc = 'ANTIGUEDAD'
				   
					This.wfechaliq = Ctod("28"+"-"+Str(This.wmes,2)+"-"+Str(This.wano,4))

					If This.wcancelar = .F.
						Exit
					ENDIF
					this.wcant =This.calcuant(This.wfechaliq,This.wfechaingreso) + This.wantiganterior
	   		        this.extraecelda
					replace curliq.cantidad WITH this.wcant
				    
				Case This.wconextracc = 'CELDA'
				     this.extraecelda
                     
				Case This.wconextracc = 'CATEGORIA'
					This.buscocategoria
					If This.wcancelar = .F.
						Exit
					Endif
			   		
		        
		        CASE this.wconextracc = "VACACI"
		             
		             This.buscocategoria   
		             This.promedio
		             This.calcuvac			
					

				Case This.wconextracc =  'MAESTRO'
                      
                      this.buscobase (curliq.concepto)
                       
				Case This.wconextracc = 'PROMEDIO'
                      this.promedio 
                      
				Case This.wconextracc = 'USUARIO'

				Case This.wconextracc = 'EMBARGO'
                     This.embargo 
			    CASE This.wconextracc = 'EBGALIMENT'
			         this.embargosal
			    
			    CASE This.wconextracc = 'NETO'
			         this.calcneto
			Endcase
             
            Do Case
               Case  This.wdivide  # 0      
                     wvalorfin = this.calcufor(this.wimporte)   
               Case  This.wporciento  # 0
                     wvalorfin = this.calcufor(this.wimporte)
               Case	 This.wmultiplica #0  
                     wvalorfin = this.calcufor(this.wimporte)
               OTHERWISE
                     wvalorfin = this.wimporte
              
            Endcase             
            
            if curliq.concepto = 241
               *set step on
               this.prhoras
               wvalorfin = this.wimporte/30

            endif


            Try 
	            DO Case
	               CASE this.wmodocarg   = 'CANTIDAD'
	                                                       
	                    this.wimporte    	=  wvalorfin * this.wcant   
	               CASE this.wmodocarg   	= 'IMPORTE' .AND. this.wmodocarg = 'USUARIO' .AND. this.wconextracc = 'MAESTRO'
	                  *  this.wimporte  	=  this.buscobase(curliq.concepto)
	               CASE this.wmodocarg  	= "IMPORTE" .AND. this.wconextracc = "USUARIO"         
	                    this.wimporte   	=  curliq.aporte + curliq.sinaporte + curliq.descuento
	               CASE this.wconextracc	= 'ANTIGUEDAD' .AND. this.wmodocarg = 'DEFECTO'
	                    this.wimporte    	=  wvalorfin
	               CASE this.wmodocarg   	= 'DEFECTO' 	        
	                    this.wimporte	 	=  wvalorfin
	                CASE this.wmodocarg 	=  'IMPORTE' .and. this.wconextracc = 'MAESTRO'
	                     * this.wimporte    =  this.buscobase(curliq.concepto)
	                
	            ENDCASE
	        CATCH TO errp
	        
	              IF curliq.concepto <> 150
	                 this.mensaje("Error En Reemplazo En Concepto " + STR(curliq.concepto,4))
	              ENDIF  
	        
	        ENDTRY   
           
           IF EMPTY(this.wimporte)
              this.wimporte = 0
           ENDIF   
           
            * SE USA POR COMAPTIBILIDAD
           * 
            IF curliq.concepto = 150 .or. curliq.concepto = 153 .or. curliq.concepto = 873 .or. curliq.concepto = 877
               this.embargosal(curliq.concepto)
            ENDIF
            IF curliq.concepto = 405
              
               WAIT WINDOW this.wtipoconcep   
            ENDIF
           
           
            DO Case
               CASE this.wtipoconcep =  'C/APORTE'   
                    SELECT curliq
                    replace curliq.aporte WITH this.wimporte
                    this.waporte = this.waporte + this.wimporte
               CASE this.wtipoconcep =  'APORTE NEG'        
                    this.wtotaporneg = this.wtotaporneg + this.wimporte
                    this.waporte = this.waporte - this.wimporte
                    SELECT curliq 
                    replace curliq.aporte WITH (this.wimporte - (this.wimporte*2))
                    this.wimporte = (this.wimporte - (this.wimporte*2))
               CASE this.wtipoconcep =   'S/APORTE' 
                    SELECT curliq
                    replace  curliq.sinaporte WITH this.wimporte
                    this.wtotsinapor = this.wtotsinapor+ this.wimporte
               CASE this.wtipoconcep = 'S/AP NEGATI'
                    SELECT curliq 
                    replace curliq.sinaporte WITH (this.wimporte - (this.wimporte*2))
                      
               CASE this.wtipoconcep =   'DESCUENTO'       
                    SELECT curliq
                    replace  curliq.descuento WITH this.wimporte 
                    this.wtotdescue = this.wtotdescue + this.wimporte
             ENDCASE
            
             
             IF this.wacumulador # 0
                wacuanterior = 0
                wacuanterior = this.wacumula(this.wacumulador)
                this.wacumula(this.wacumulador) = this.wimporte + wacuanterior
             
             ENDIF

            replace curliq.cantidad WITH this.wcant
            
			Store 0 To This.wdivide,This.wporciento,This.wmultiplica,wvalorfin,this.wcant,this.wimporte
		Endscan
        
    




	Endproc



	Procedure bsconcepto
		Parameters bconcepto
		Select * From CODSUEL Where concepto = bconcepto;
			INTO Cursor CURCONP
		If CURCONP.concepto = 0
			This.mensaje("Error Concepto Inexistente..."+str(curconp.concepto,4))
			This.wcancelar = .F.
		Else
			Replace curliq.descrip With CURCONP.denoconep
			this.wdescrip  = CURCONP.denoconep
			*UPDATE curliq set curliq.deno = curconp.denoconep;
			*WHERE curliq.concepto = curconp.concepto
			This.wconextracc = Alltrim(Rtrim(CURCONP.extraccio))
		    This.wdivide     =  CURCONP.divide
		    This.wporciento  =  CURCONP.porciento
		    This.wmultiplica =  CURCONP.multiplica 
		    This.wsuma       =  CURCONP.suma
		    This.wmodocarg   =  Alltrim(Rtrim(CURCONP.modocarg))
		    this.wimporte    =  CURCONP.importe
		    this.wtipoconcep =  ALLTRIM(Rtrim(CURCONP.tipoconp))
		    this.wacumulador =  CURCONP.acumulador
		    this.wdesde      =  CURCONP.desde
		    this.whasta      =  CURCONP.hasta
		Endif

	Endproc


    PROCEDURE auditar
      LOCAL retorna
      IF this.wdisplaynove = .f.
          RETURN .f.
      ENDIF
         
      
      retorna = .f. 
      SELECT * FROM AUDITOR WHERE MES = this.wmes .and. ANO = this.wano .and. legajo = this.wlegajo;
      INTO CURSOR VEOAUDIT
      IF .not. EOF()
           retorna = .t.
      ENDIF
      SELECT VEOAUDIT
      SCAN      
         if  this.conceptoduplicado(veoaudit.concepto) = .t.
             This.bsconcepto(veoaudit.concepto)
             
             if  This.wconextracc = 'USUARIO' OR  this.wmodocarg = 'CANTIDAD'
                 IF this.wtipoconcep =   'DESCUENTO'
                    INSERT INTO CURLIQ (LEGAJO,CONCEPTO,DESCUENTO,LIQUIDA);          	         
                    VALUES(this.wlegajo,VEOAUDIT.CONCEPTO,VEOAUDIT.IMPORTE, this.wtipoliq)
                 ELSE 			  
                    INSERT INTO CURLIQ (LEGAJO,CONCEPTO,CANTIDAD,LIQUIDA);          	         
                    VALUES(this.wlegajo,VEOAUDIT.CONCEPTO,VEOAUDIT.CANTIDAD, this.wtipoliq)
			     ENDIF
			 ENDIF    
		 endif	 

	  ENDSCAN
      SELECT CURLIQ
      return retorna
    
    Endproc

	Procedure InsertarConcepto
	    Parameters ParConcepto
	    if  this.conceptoduplicado(ParConcepto) = .t.
             INSERT INTO CURLIQ (LEGAJO,CONCEPTO,CANTIDAD,DESCUENTO,LIQUIDA);          	         
              VALUES(this.wlegajo,ParConcepto,0,0, this.wtipoliq)
			 
		 endif
	
	
	Endproc
	

   Procedure InsertarConceptoBis
	    Parameters ParConcepto,ParCantidad
	    if  this.conceptoduplicado(ParConcepto) = .t.
             INSERT INTO CURLIQ (LEGAJO,CONCEPTO,CANTIDAD,DESCUENTO,LIQUIDA);          	         
              VALUES(this.wlegajo,ParConcepto,ParCantidad,0, this.wtipoliq)
			 
		 endif
	
	
	Endproc

 


	


	Procedure mensaje
		Parameters elmensaje
		Messagebox(elmensaje,16,"Error")



	Endproc

	Procedure calcuant
*-- C�lculo de antiguedad
		Parameters factual,fcalcula
* valor de retorno es antg
		Store 0 To antg,Resto

		If Empty(fcalcula)
			antg = 0
			Return antg
		Endif
		Private aoactual,aocalc,maactual,mealcl
		Store 0 To aoactual,aocalc,maactual,mcalcu
		maactual = Val(Substr(Dtoc(factual),4,2))
		mcalcu   = Val(Substr(Dtoc(fcalcula),4,2))
		aoactual = Val(Substr(Dtoc(factual),7,4))
		aocalc   = Val(Substr(Dtoc(fcalcula),7,4))
		mcalcu   = Month(fcalcula)
		maactual = Month(factual)
		If Year(factual) > Year(fcalcula)

			If Month(factual) > Month(fcalcula)
				antg =  Year(factual) - Year(fcalcula)
			Else
				antg = (Year(factual) - Year(fcalcula)) -1
			Endif
			If Month(factual) = Month(fcalcula)
				antg =  Year(factual) - Year(fcalcula)
			Endif

		Else
			antg = 0
		Endif

		Return antg
	Endproc

	Procedure buscolegajo
		    *Select * From PERSONAL Where LEGAJO = This.wlegajo;
			INTO Cursor CURPERSO
		    SELECT * FROM personal WHERE activo = "A" INTO CURSOR lista
		    SELECT * FROM lista WHERE legajo = this.wlegajo INTO CURSOR curperso
		
		
		
			
		If CURPERSO.LEGAJO = 0
			*This.mensaje("Error legajo Inexistente en Archivo Personal " + Str(This.wlegajo,4))
			*This.wcancelar = .F.
			This.wfechaingreso  = curperso.fechaing
			This.wantiganterior = curperso.antigant
			This.wcategoria     = Ltrim(curperso.categoria) 
		
		Else
			This.wfechaingreso  = CURPERSO.fechaing
			This.wantiganterior = CURPERSO.antigant
			This.wcategoria     = Ltrim(CURPERSO.categoria)
		Endif
        if !EMPTY(CURPERSO.fechabaja)
           MESSAGEBOX("Legajo de Baja  " + DTOS(fechabaja),16,'Atenci�n')
        endif           
           
    

	ENDPROC
	
	PROCEDURE busconombre
	    WAIT WINDOW "Buscando por nombre" + vpersolinea.nombre
	    
	
	
	
	endproc
	


	Procedure buscocategoria
		Select * From CATEGO Where DESCATEG = This.wcategoria;
			INTO Cursor CURCATEG
		If Empty(CURCATEG.DESCATEG)
			This.mensaje("No se Encuentra la categoria" + This.wcategoria)
			This.wcancelar = .F.
		Else
			This.wimporte = CURCATEG.importe
			This.wbasico  = CURCATEG.importe
		Endif

	Endproc

    PROCEDURE Buscobase 
        PARAMETERS bcpto
        
        SELECT * FROM maper WHERE legajo = this.wlegajo;
        .AND.  TIPOLIQ = this.wtipoliq  .AND. CONCEPTO = bcpto INTO CURSOR curmaper
        IF curmaper.concepto = 0
           This.mensaje("No se Encuentra el concepto "+ CHR(9)+ "cargado en la liquidaci�n base....:" + STR(curmaper.concepto,4))
           This.cancelar = .F. 
        ELSE
           this.wimporte = curmaper.importe
           RETURN curmaper.importe
        ENDIF 
        this.auditar

     Endproc


     PROCEDURE calcneto
        * UPDATE curliq SET descuento = 0 WHERE concepto = 875
         select SUM(aporte) as br, SUM(sinaporte) as snp,SUM(IIF(CONCEPTO <> 875,descuento,0)) as des;
         FROM curliq INTO CURSOR cnet
         this.wimporte = (cnet.br + cnet.snp) - cnet.des    
     
         RETURN .t.
     Endproc







    PROCEDURE Calcufor
       	parameters valor
	    LOCAL devuelve as decimal  
	   	declare retorno[3]
       	for i = 1 to 3
          retorno[i] =0
       	next   
		 if this.wdivide # 0
         	retorno[1]   = valor/this.wdivide
 		 endif
 
 		if this.wporciento # 0.and. this.wdivide # 0
    		retorno [2]   =  (retorno[1]* this.wporciento)/100
 		else
   			retorno[2]     =  (valor*this.wporciento)/100
 		endif     
 
 		if this.wmultiplica # 0.and. this.wdivide  # 0 .and. this.wporciento # 0
       		retorno[3]     =  retorno[2]* this.wmultiplica
 		else  
    		if this.wmultiplica # 0 .and. this.wdivide # 0
       			retorno[3]     =  retorno[1] * this.wmultiplica
    		else
       			retorno[3]      =  valor * this.wmultiplica
   			endif    
		 endif              
             
 		if this.wsuma = '+'
    		devuelve =  retorno[1] + retorno[2] + retorno[3]
 		else
    		for i=1 to 3              
       				if retorno[i] # 0
         				devuelve = retorno[i]
       				endif
    		 next
		 endif
        
 		 return devuelve       
    
    Endproc

    PROCEDURE extraecelda
     LOCAL n as integer  
     LOCAL 	wtemp as decimal 
        
     
     FOR n = this.wdesde TO this.whasta
         wtemp = 0
         wtemp = this.wimporte 
         this.wimporte = wtemp + this.wacumula(n)
        *n = n+ 1 
     NEXT
     
     *IF this.wdesde  = this.whasta
     *    WAIT WINDOW "Son Iguales"
     *   this.wimporte = this.wacumula(this.wdesde)
     *ENDIF    
    
    ENDPROC


    PROCEDURE CARGOBASE
      	SELECT * FROM MAPER WHERE TIPOLIQ = this.wtipoliq .and. legajo = this.wlegajo;
      	INTO CURSOR BASELIQ
      	SELECT BASELIQ
      	IF RECCOUNT() = 0
         	this.mensaje("Empleado Sin Liquidaci�n base")
       	 RETURN
      	ENDIF
      	
      	SCAN
          	 wexiste = 0
          	SELECT CONCEPTO  FROM CURLIQ  WHERE CURLIQ.CONCEPTO = BASELIQ.CONCEPTO INTO CURSOR EXTCOP
          	IF EXTCOP.CONCEPTO = 0
          	            IF  BASELIQ.CONCEPTO = 142
          	               INSERT INTO CURLIQ (LEGAJO,CONCEPTO,CANTIDAD,DESCUENTO,LIQUIDA);          	         
            			   VALUES(this.wlegajo,BASELIQ.CONCEPTO,BASELIQ.UNIDADES,BASELIQ.IMPORTE,this.wtipoliq)
            			ELSE
            			   INSERT INTO CURLIQ (LEGAJO,CONCEPTO,CANTIDAD,LIQUIDA);
            			    VALUES(this.wlegajo,BASELIQ.CONCEPTO,BASELIQ.UNIDADES,this.wtipoliq)
          	           ENDIF  
          	ENDIF
          	SELECT BASELIQ
          	
     	ENDSCAN
     	 SELECT BASELIQ
     	 USE
     	 SELECT EXTCOP
     	 USE
     	 SELECT CURLIQ   
    ENDPROC
    
    
          
          
          
          
          
    PROCEDURE CARGODIACAM      
       varcndiacam = 16
          
      SELECT concepto FROM curliq WHERE concepto = varcndiacam INTO CURSOR existe
      
      IF EOF() 
         INSERT INTO curliq (LEGAJO,CONCEPTO,CANTIDAD,LIQUIDA);
         VALUES(this.wlegajo,varcndiacam,0,3) 
      ENDIF    
   ENDPROC
  
  
   PROCEDURE BUSCOBASE
    PARAMETERS coneptbus
        SELECT * FROM maper WHERE tipoliq = this.wtipoliq .and. legajo = this.wlegajo;
        .and. concepto = coneptbus INTO CURSOR Exstmp 
           this.wimporte = Exstmp.importe
           this.wcant    = Exstmp.unidades 
            SELECT Exstmp
        USE 

    ENDPROC

    PROCEDURE FERIADONOTRA
         IF this.wtipoliq <> 3
            RETURN 
         ENDIF
         varfc   = 8
         varfer  = 9
         SELECT concepto FROM curliq WHERE concepto = varfer .or. concepto = varfc INTO CURSOR existe 
         IF NOT EOF()  
            RETURN    
         ENDIF
    
         IF this.wmes = 1
              wmesliq = 12
              wlustroant = this.wano - 1
              this.wmesanterior = ALLTRIM(STR(wmesliq,2)+ STR(wlustroant,4))
           else
              wmesliq = this.wmes -1
           	  if this.wmes < 6
          	     this.wmesanterior = ALLTRIM(STR(wmesliq,1)+ STR(this.wano,4))
             else   
                 this.wmesanterior = ALLTRIM(STR(wmesliq,2)+ STR(this.wano,4))
             endif
          endif


          SELECT LEGAJO AS LE, SUM(this.FER(CONCEPTO,APORTE ))AS M   FROM (this.wmesanterior) ;
          GROUP BY LEGAJO WHERE LEGAJO = this.wlegajo INTO CURSOR RMVAR
          IF rmvar.m <>0
             INSERT INTO CURLIQ (LEGAJO,CONCEPTO,aporte,LIQUIDA);
            			VALUES(this.wlegajo,9,(rmvar.m/24) ,this.wtipoliq)
          ENDIF 
          
          
          *  MESSAGEBOX("Importe por Feriado " + STR(rmvar.m,7,2),"aT")

    ENDPROC


    FUNCTION FER
	PARAMETERS wconcepto,waporte
	LOCAL wimporte as Number
	DO case
   		CASE wconcepto = 5 .or. wconcepto = 6
        wimporte = waporte
   	CASE wconcepto = 17 .or. wconcepto = 23 .or. wconcepto = 14 .or. concepto = 24    
        wimporte = waporte
   	OTHERWISE
        wimporte = 0
	ENDCASE
    RETURN wimporte             

    PROCEDURE SACPROP
       
    
    
    
    ENDPROC
    





    PROCEDURE TRAERECIBO
      * DEFINER EL ARCHIVO DE LIQUIDACION
      *INSERT INTO CURLIQ (CONCEPTO,CANTIDAD,APORTE,SINAPORTE,DESCUENTO);
       
        *if this.wmes > 1 
           IF this.wmes = 1
              wmesliq = 12
              wlustroant = this.wano - 1
              this.wmesanterior = ALLTRIM(STR(wmesliq,2)+ STR(wlustroant,4))
           else
              wmesliq = this.wmes -1
           	  if this.wmes < 6
          	     this.wmesanterior = ALLTRIM(STR(wmesliq,1)+ STR(this.wano,4))
             else   
                 this.wmesanterior = ALLTRIM(STR(wmesliq,2)+ STR(this.wano,4))
             endif
           endif
           
          * wmesliq = 12
          * wlustroant = this.wano - 1
          * this.wmesanterior = ALLTRIM(STR(wmesliq,2)+ STR(wlustroant,4)) 
        
        *endif   
        SELECT CONCEPTO,DESCRIP,CANTIDAD,APORTE,SINAPORTE,DESCUENTO FROM (this.wmesanterior) WHERE LIQUIDA = this.wtipoliq .AND. LEGAJO = this.wlegajo;
        INTO CURSOR RECSU
        SELECT RECSU
      
        SCAN
            wexiste = 0
          	SELECT CONCEPTO  FROM CURLIQ  WHERE CURLIQ.CONCEPTO = RECSU.CONCEPTO INTO CURSOR EXTCOP
          	
          	IF EXTCOP.CONCEPTO = 0 
          	   IF RECSU.CONCEPTO = 130 .OR. RECSU.CONCEPTO = 99 .OR. RECSU.CONCEPTO = 123 .OR. RECSU.CONCEPTO = 16 .OR. RECSU.CONCEPTO = 142;
          	      .OR. RECSU.CONCEPTO = 175 .OR. RECSU.CONCEPTO = 9 .OR. RECSU.CONCEPTO = 121 .OR. RECSU.CONCEPTO = 653 .OR. RECSU.CONCEPTO = 654;
          	      .OR. RECSU.CONCEPTO = 876 .OR. RECSU.CONCEPTO = 303
          	   ELSE
            	      INSERT INTO CURLIQ (LEGAJO,CONCEPTO,DESCRIP,CANTIDAD,APORTE,SINAPORTE,DESCUENTO,LIQUIDA);
            		  VALUES(this.wlegajo,RECSU.CONCEPTO,RECSU.DESCRIP,RECSU.CANTIDAD,RECSU.APORTE,RECSU.SINAPORTE,RECSU.DESCUENTO,this.wtipoliq)
          	        
          	   ENDIF
          	 ENDIF
            SELECT EXTCOP
        ENDSCAN
        SELECT RECSU
        USE
        IF USED('EXTCOP') 
          SELECT EXTCOP
          USE
        ENDIF
    ENDPROC 


    


    PROCEDURE CONCEPTODUPLICADO
    PARAMETERS buconcepto
    LOCAL EXTCOP
    EXTCOP = 0
    SELECT CURLIQ
	*IF EOF()
    *  RETURN .T.

	*ENDIF
    SCAN 
       IF buconcepto = curliq.concepto
          EXTCOP = 1
          RETURN .F. 
       ENDIF
    ENDSCAN
    
    *SELECT CONCEPTO  FROM CURLIQ  WHERE CURLIQ.CONCEPTO = buconcepto;
    INTO CURSOR EXTCOP
    IF EXTCOP = 0
       RETURN .T.
    ELSE
       RETURN .F.
    ENDIF
    
    ENDPROC
    
    PROCEDURE PROMEDIO
      wlustro = " "
      wlustro = "SBR" +SUBSTR(STR(this.wano,4),3) 
      wanterior = this.wano -1
      waanter = "SBR" +SUBSTR(STR(wanterior,4),3)
      prome1 = 0
       
       DO CASE
          CASE this.wmes = 1 
               SELECT  s7,s8,s9,s10,s11,s12 FROM &waanter WHERE legajo = this.wlegajo INTO CURSOR aterior
               this.wpromesu =   (aterior.s7+ aterior.s8 + aterior.s9 + aterior.s10 + aterior.s11 + aterior.s12)/6
               SELECT  julio,agosto,setiembre,octubre,noviembre,diciembre FROM &waanter WHERE legajo = this.wlegajo INTO CURSOR aterior
               prome1 = (aterior.julio +aterior.agosto+ aterior.setiembre + aterior.octubre + aterior.noviembre + aterior.diciembre)/6
                               
           CASE this.wmes = 2
                 
               SELECT  agosto,setiembre,octubre,noviembre,diciembre FROM &waanter WHERE legajo = this.wlegajo INTO CURSOR aterior
               SELECT aterior
               SELECT s8,s9,s10,s11,s12 FROM &waanter WHERE legajo = this.wlegajo INTO CURSOR anterpro
               SELECT  (enero) as impt FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust
               SELECT s1 FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR encurso
               SELECT lust
               prome1 =  (lust.impt+aterior.agosto+ aterior.setiembre + aterior.octubre + aterior.noviembre + aterior.diciembre)/6
               this.wpromesu =(anterpro.s8+anterpro.s9+anterpro.s10+anterpro.s11+anterpro.s12+ encurso.s1)/6
               
               
          CASE this.wmes = 3 
               SELECT setiembre,octubre,noviembre,diciembre FROM &waanter WHERE legajo = this.wlegajo INTO CURSOR aterior
               SELECT  (enero+febrero) as impt FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust
               SELECT s9,s10,s11,s12 FROM &waanter WHERE legajo = this.wlegajo INTO CURSOR anterpro
               SELECT s1,s2 FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR encurso 
               prome1 =  (lust.impt+aterior.setiembre + aterior.octubre + aterior.noviembre + aterior.diciembre)/6
               this.wpromesu =(anterpro.s9+anterpro.s10+anterpro.s11+anterpro.s12+ encurso.s1+encurso.s2)/6
               *SELECT febrero as ultimo FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR ULTSUEL
               *IF ultsuel.ultimo > prome1
               *   prome1= ultsuel.ultimo
               *   WAIT WINDOW "TOMANDO BASE FEBRERO" 
               *ENDIF   
               
          CASE this.wmes = 4 
               SELECT   octubre,noviembre,diciembre FROM &waanter WHERE legajo = this.wlegajo INTO CURSOR aterior
               SELECT   enero,febrero,marzo  FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust
               SELECT  (marzo) as ultimo FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR ultimosue
               SELECT s10,s11,s12 FROM &waanter WHERE legajo = this.wlegajo INTO CURSOR antepro
               SELECT  s1,s2,s3 FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR encurso 
                       prome1 =  (antepro.s10+antepro.s11+antepro.s12+encurso.s1+encurso.s2+encurso.s3)/6
               this.wpromesu  =  (antepro.s10+antepro.s11+antepro.s12+encurso.s1+encurso.s2+encurso.s3)/6
  
              *IF ultimosue.ultimo > prome1
              *   prome1 = ultimosue.ultimo
               *  WAIT WINDOW "TOMANDO BASE ABRIL"
              *ENDIF     
  
            
          CASE this.wmes = 5 
               SELECT  noviembre,diciembre FROM &waanter WHERE legajo = this.wlegajo INTO CURSOR aterior
               SELECT  (enero+febrero+marzo+abril) as impt FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust 
               SELECT s11,s12 FROM &waanter WHERE legajo = this.wlegajo INTO CURSOR antepro 
               SELECT (s1+s2+s3+s4) as impvac from &wlustro WHERE legajo = this.wlegajo INTO CURSOR lvac
               *this.wpromesu = (antepro.s11+antepro.s12+lvac.s1+lvac.s2+lvac.s3+lvac.s4)/6 
               this.wpromesu = (aterior.noviembre + aterior.diciembre+ lust.impt)/6
               prome1 =  (aterior.noviembre + aterior.diciembre+ lust.impt)/6 
          
          CASE this.wmes = 6 
               *SET STEP ON 
               SELECT  (enero+febrero+marzo+abril+mayo ) as impt FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust
               SELECT   diciembre FROM &waanter WHERE legajo = this.wlegajo INTO CURSOR aterior
               SELECT  (marzo) as ultimo FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR ultimosue
               SELECT s12 FROM &waanter WHERE legajo = this.wlegajo INTO CURSOR antepro 
               SELECT (s1+s2+s3+s4+s5)as impvac FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lvac 
               this.wpromesu =  (antepro.s12+ lvac.impvac)/6
               prome1 = (lust.impt + aterior.diciembre)/6  
                      
          CASE this.wmes = 7 
               SELECT  (enero+febrero+marzo+abril+mayo+ junio) as impt FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust 
               SELECT (s1+s2+s3+s4+s5+s6)as impvac FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lvac 
               this.wpromesu = lvac.impvac/6
               prome1 =  (lust.impt)/6 
          CASE this.wmes = 8
               SELECT  (febrero+marzo+abril+mayo+ junio+ julio) as impt FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust 
               SELECT (s2+s3+s4+s5+s6+s7)as impvac FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lvac 
               this.wpromesu = lvac.impvac/6
               prome1 =  (lust.impt)/6
          CASE this.wmes = 9
               SELECT  (marzo+abril+mayo+ junio+ julio+ agosto) as impt FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust 
               SELECT (s3+s4+s5+s6+s7+S8)as impvac FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lvac 
               this.wpromesu = lvac.impvac/6
               prome1 =  (lust.impt)/6
          CASE this.wmes = 10
               SELECT  (abril+mayo+ junio+ julio+ agosto + setiembre ) as impt FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust 
               SELECT (s4+s5+s6+s7+s8+s9)as impvac FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lvac 
               this.wpromesu = lvac.impvac/6
               prome1 =  (lust.impt)/6
          CASE this.wmes = 11 
               SELECT  (mayo+ junio+ julio+ agosto + setiembre+octubre ) as impt FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust 
               SELECT (s5+s6+s7+s8+s9+s10)as impvac FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lvac
               this.wpromesu = lvac.impvac/6
               prome1 =  (lust.impt)/6
          CASE this.wmes = 12 
               SELECT  (junio+ julio+ agosto + setiembre+octubre+noviembre ) as impt FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust 
               SELECT (s6+s7+s8+s9+s10+s11)as impvac FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lvac
               this.wpromesu = lvac.impvac/6
               prome1 =  (lust.impt)/6
      ENDCASE
      
      this.wimporte = prome1
    
    ENDPROC
    
    PROCEDURE CALCUVAC
 		this.wimporte = this.wbasico + this.wpromesu

	ENDPROC

    
    
    
    
    
    PROCEDURE EMBARGO
           
      VarEmbargo =0
      try 
        SalarioMin = VAL(FILETOSTR('smv.txt'))
      CATCH TO e 
            this.mensaje("No Se puede Abrir El Archivo smv.txt")
       
      ENDTRY
        
      DO CASE  
         CASE this.waporte > SalarioMin*2
              VarEmbargo = (this.waporte - (SalarioMin*2))*0.20
         CASE this.waporte  < SalarioMin*2              
              VarEmbargo = (this.waporte - SalarioMin)*0.10
      ENDCASE         
      
      if this.wlegajo = 701
         if VarEmbargo > 3794.69
            VarEmbargo = 3794.69
         endif
      endif      


      this.wimporte = VarEmbargo
          
      
      *this.updateembargo
      
    ENDPROC
     
    





    
    PROCEDURE EMBARGOSAL
         
       PARAMETERS concepto
       Private VarTotalSueldo,VarEmbargo
       STORE 0 TO VarTotalSueldo,VarEmbargo
       IF concepto = 150
       	  VarTotalSueldo = (this.waporte -this.wtotaporneg)+ this.wtotsinapor
       ENDIF
       
       IF concepto = 153
          VarTotalSueldo = ((this.waporte -this.wtotaporneg ) - this.wtotdescue) 
       ENDIF   
	   
       IF concepto = 873
          VarTotalSueldo = ((this.waporte -this.wtotaporneg)+ this.wtotsinapor) -this.wtotdescue
       ENDIF

	   *WAIT WINDOW STR(this.waporte,7,2) + ' ' + str(this.wtotdescue,7,2)
       *WAIT WINDOW STR(this.wcant,2)
       
       IF concepto  = 875
          VarTotalSueldo = this.waporte
	   ENDIF	  

       WAIT WINDOW "SUELDO : " + STR(VarTotalSueldo,14,2) + "Cantidad " + STR(this.wcant,6,2) 
       VarEmbargo     = (VarTotalSueldo*this.wcant)/100  
       this.wimporte  = VarEmbargo
       
    ENDPROC
    
    PROCEDURE EXISTEVAC
    
      SELECT legajo,ano,desde,hasta,dias,sueldos FROM vacaci WHERE legajo = this.wlegajo .and. ANO = this.wano;
      INTO CURSOR VACEXST
      IF .NOT. EOF()
         BROWSE
      ENDIF
      SELECT CURLIQ
    
    
    ENDPROC
    
    *PROCEDURE PDATEEMBARGO
    
     * SELECT legajo,periodo FROM ctremb WHERE legajo = Varlegajo .and. periodo = archivo;
      INTO CURSOR existe
    
     * SELECT CURLIQ
    
    
    
    
    
    
    *ENDPROC
    
    
    
    
    
    
    
    
    
    
    
    PROCEDURE EXISTELGPER
    PARAMETERS wleg
    LOCAL VarBoldevuelve as Boolean
    VarBoldevuelve = .t.   
    
       SELECT LEGAJO,NOMBRE,FECHAING,ACTIVO,FECHABAJA FROM PERSONAL WHERE LEGAJO = WLEG INTO CURSOR EXTLEG
       
       IF  .NOT. EMPTY(EXTLEG.FECHABAJA)
           this.mensaje("Legajo de Baja " + STR(legajo,4)+ " " + extleg.nombre)  
           VarBoldevuelve = .f.
       ENDIF
        
       RETURN  VarBoldevuelve 
    
    ENDPROC
       
    

    PROCEDURE PRHORAS

        Select sum(iif(concepto=5 .or. concepto = 6,aporte,0)) as horimp from 102019 where legajo = this.wlegajo;
        into cursor oct
       
        Select sum(iif(concepto=5 .or. concepto = 6,aporte,0)) as horimp from 112019 where legajo = this.wlegajo;
        into cursor nov
               
        Select sum(iif(concepto=5 .or. concepto = 6,aporte,0)) as horimp from 122019 where legajo = this.wlegajo;
        into cursor dic
        
        Select sum(iif(concepto=5 .or. concepto = 6,aporte,0)) as horimp from 12020 where legajo = this.wlegajo;
        into cursor ene
        
        Select sum(iif(concepto=5 .or. concepto = 6,aporte,0)) as horimp from 22020 where legajo = this.wlegajo;
        into cursor feb

        Select sum(iif(concepto=5 .or. concepto = 6,aporte,0)) as horimp from 32020 where legajo = this.wlegajo;
        into cursor mar
       
         ?oct.horimp
        
        this.wimporte = (oct.horimp+nov.horimp+dic.horimp+ene.horimp+feb.horimp+mar.horimp)/6         





    ENDPROC




    
     
Enddefine













DEFINE CLASS configurar AS liquidacion
 PropRuta = " "
 
     
    PROCEDURE init
       this.Seteo
 
    Endproc

       
	PROCEDURE Seteo        
      SET EXCLUSIVE OFF
      SET DATE ITALIAN
      SET TALK OFF
	  SET EXCLUSIVE OFF
	  SET REPROCESS TO AUTOMATIC
      SET MULTILOCKS ON
	  SET DELETED ON
    Endproc

    
    PROCEDURE SeteoPat
       PARAMETERS cpath
        VarBased = " "
       DO CASE
          CASE cpath = 1
                SET PATH TO C:\FWSU\FORMS;C:\FWSU\PRG;C:\FWSU\CLASES;F:\SUELDOS\EMPRE1;F:\SUELDOS;F:\empre1;f:\
                 this.abrobase
                 VarBased = "f:\sueldos.dbc"
		  CASE cpath = 2
                SET PATH TO C:\FWSU\FORMS;C:\FWSU\PRG;F:\SUELDOS\EMPRE2;F:\SUELDOS;C:\FWSU\CLASES;F:\EMPRE2;F:\  
                this.abrobase
		  CASE cpath = 3
                SET PATH TO C:\FWSU\FORMS;C:\FWSU\PRG;C:\FWSU\CLASES;C:\SUERUT\EMPRE2
          CASE cpath = 4
                SET PATH TO C:\FWSU\FORMS;C:\FWSU\PRG;C:\FWSU\CLASES;I:\SUELDOS\EMPRE1;I:\SUELDOS     
          CASE cpath = 5
               SET PATH TO C:\FWSU\FORMS;C:\FWSU\PRG;C:\FWSU\CLASES;C:\SUERUT\EMPRE1 
               VarBased = "C:\SUERUT\EMPRE1\SUELDOS.DBC"
               this.abrobase
		  CASE cpath = 6
                SET PATH TO C:\FWSU\FORMS;C:\FWSU\PRG;C:\FWSU\CLASES;C:\suerut\demo;F:\sueldos
          CASE cpath = 7
                SET PATH TO C:\FWSU\FORMS;C:\FWSU\PRG;C:\FWSU\CLASES;C:\SUERUT\EMPRE3
          CASE cpath = 8
                SET PATH TO C:\FWSU\FORMS;C:\FWSU\PRG;C:\FWSU\CLASES;C:\SUERUT\DEMO     
                  
       ENDCASE
    Endproc

    PROCEDURE Abrobase
     PARAMETERS VarBase
       TRY 
         OPEN DATABASE SUELDOS
          
       CATCH TO Err
         this.mensaje ("Error No se Puede Abrir la Base De Datos ")
         FINALLY
       ENDTRY   
	ENDPROC
	
ENDDEFINE

DEFINE CLASS montoescrito as Custom
    
    
            

            FUNCTION nombremes
			parameters wmes

			nom = space(12)

			declare meses [12]

			meses[1]  = 'enero'
			meses[2]  = 'febrero'
			meses[3]  = 'marzo'
			meses[4]  = 'abril'
			meses[5]  = 'mayo'
			meses[6]  = 'junio'
			meses[7]  = 'julio'
			meses[8]  = 'agosto'
			meses[9]  = 'setiembre'

			meses[10] = 'octubre'
			meses[11] = 'noviembre'
			meses[12] = 'diciembre'

			if wmes = 0 .or. wmes > 12
			   nom  = 'error en n�mero de per�odo'
			else  
			   nom  = meses[wmes] 
			endif   

			return nom
         
            ***********************         
            FUNCTION monto()
	   	    ***********************		
			
			parameters letras,nn
			
			LOCAL MayorC
			MayorC = 0
			
			IF nn > 100000
			   MayorC = nn 
			   nn = nn-100000
			ENDIF   
					
			
			dimension nombre [28]
			store "uno"        to nombre[1]
			store "dos"        to nombre [2]
			store "tres"       to nombre [3]
			store "cuatro"     to nombre [4]
			store "cinco"      to nombre [5]
			store "seis"       to nombre [6]
			store "siete"      to nombre [7]
			store "ocho"       to nombre [8]
			store "nueve"      to nombre [9]
			store "diez"       to nombre [10]
			store "once"       to nombre [11]
			store "doce"       to nombre [12]
			store "trece"      to nombre [13]
			store "catorce"    to nombre [14]
			store "quince"     to nombre [15]
			store "dieciseis"  to nombre [16]
			store "diecisiete" to nombre [17]
			store "dieciocho"  to nombre [18]
			store "diecinueve "to nombre [19]
			store "veinte"     to nombre [20]
			store "treinta"    to nombre [21]
			store "cuarenta "  to nombre [22]
			store "cincuenta"  to nombre [23]
			store "sesenta  "  to nombre [24]
			store "setenta  "  to nombre [25]
			store "ochenta  "  to nombre [26]
			store "noventa  "  to nombre [27]
			store "ciento   "  to nombre [28]

		    
			store space(20) to gracia,nuni,centena,unimil,parcial,decemil
			store space(3) to nrgral
			store space(2) to cc,dec,unid,vn,vmil,wdec
			store 0  to cientos,mil,integro,deci
			integro = int(nn)
			deci    = ((nn - integro)*100)
            
             
             
			if deci = 0
			   parcial = ' '
			else
			   parcial = ltrim("con " + str(deci,2) +"/100")
			endif

			if integro < 10000
			   nrgral  = str(integro,4)
			else 
			   if integro > 100000
				  nrgral = str(integro,7) 
			   else
				  nrgral   = str(integro,5)
			   endif
			 
			endif

			if integro < 10000
				cientos = len(ltrim(nrgral))
				mil     = len(ltrim(nrgral))
				cc      =  substr(nrgral,3)
				dec     = substr(cc,1,1)
				unid    = substr(cc,2)
				wdec    = substr(cc,1,2)
			else
				cientos  = val (substr (nrgral,3,1))
				dec      =  substr(nrgral,4,1)  
				unid     =  substr(nrgral,5,1)
				wdec     =  substr(nrgral,4,2)
			endif

			if integro >= 10000 .and. integro < 20000
				decenamil = substr(nrgral,1,2)
				decemil    =  nombre[val(decenamil)] + "mil"
			else
				
				if integro >=20000
				   IF integro > 100000
				      cienmil = SUBSTR(nrgral,1,3)
				   	  Ciento  = "CienMil"	   
				      largo  = LEN(nrgral)
				      NumMay = SUBSTR(nrgral,2,largo)
				      nrgral = NumMay
				      dec      =  substr(nrgral,4,1)
				      unid     =  substr(nrgral,5,1)
				      wdec     =  substr(nrgral,4,2)
				   ENDIF
				
				
					decenamil  = substr(nrgral,1,1)+ "0"		 
													
					unidademil = " "
					*****************VERIFICAR ***************
					IF nn > 100000
						bnum       = substr(nrgral,4,1)
					ELSE
					    bnum       = substr(nrgral,2,1)
					ENDIF
					****************************************    
										
					if bnum <> "0"
					  unidademil = nombre[val(bnum)]
					endif
					if decenamil = "20"
					   decemil = "veinti"+ unidademil + "mil" 
					else
					   do case
					 
						  case decenamil = "30"
										  decemil    =  nombre[21]+" y "+ unidademil + "mil"   
					      case decenamil = "40"
										  decemil    =  nombre[22]+" y "+ unidademil + "mil" 
					      case decenamil = "50"
										  decemil    =  nombre[23]+" y "+ unidademil + "mil"
					      case decenamil = "60"
										  decemil    =  nombre[24]+" y "+ unidademil + "mil"
					      case decenamil = "70"
										  decemil    =  nombre[25]+" y "+ unidademil + "mil"  					  
					   
					      case decenamil = "80" 
					                       decemil    =  nombre[26]+" y "+ unidademil + "mil"   
					  
					  
					   endcase
					endif
					mil = 0
				endif
				*wait window decemil
			endif

			if mil = 4
			   vmil= substr(nrgral,1,1)
			   do case
				  case val(vmil) = 1
						 unimil  = "mil"
				  case val(vmil) = 2
					   unimil    = nombre[val(vmil)] + "mil"  
				  case val(vmil) = 3
					   unimil    = nombre[val(vmil)] + "mil"
				  case val(vmil) = 4
					   unimil    = nombre[val(vmil)] + "mil"
				  case val(vmil) = 5
					   unimil    = nombre[val(vmil)] + "mil"
				  case val(vmil) = 6
					   unimil    = nombre[val(vmil)] + "mil"
				  case val(vmil) = 7
					   unimil    = nombre[val(vmil)] + "mil"
				  case val(vmil) = 8
					   unimil    = nombre[val(vmil)] + "mil"
				  case val(vmil) = 9
					   unimil    = nombre[val(vmil)] + "mil"
				  otherwise
					   unimil    = ' '
			   endcase
			endif

			if cientos = 4 .or. cientos = 3
			   vn = right((substr(nrgral,1,2)),1)
			*  @1,1 say vn
			 do case
				   case val(vn) = 0
						centena = '     '
				   case val(vn) = 1
						if val(wdec) = 0
						   centena = "cien"
						else
						   centena = "ciento"
						endif
					case val(vn) = 5
						centena = "quinientos"
				   case val(vn) = 9
						centena = "novecientos"
				   otherwise
						 centena =  nombre[val(vn)] + "cientos"
				endcase
			endif

			if integro > 10000
				do case 
					case cientos = 0
						 centena = " "    
					case cientos = 1
						 centena = "ciento "    
					case cientos = 5
						 centena = "quinientos"
					case cientos = 5      
						 centena = "novecientos"
					otherwise		 
						 centena =  nombre[cientos] + "cientos"
				endcase
			endif




			do case
			   case val(dec) = 0
					gracia = "        "
			   case val(dec)= 1
					  gracia = nombre[val(wdec)]
			   case val(dec) = 2
					gracia   = nombre[(val(dec)*10)]
			   case val(dec)= 3
					gracia=    nombre[(val(dec)*10)-9]
			   case val(dec)=4
					gracia=    nombre[(val(dec)*10)-18]
			   case val(dec)=5
					gracia   = nombre[(val(dec)*10)-27]
			   case val(dec)=6
					gracia=    nombre[(val(dec)*10)-36]
			   case val(dec)=7
					gracia =   nombre[(val(dec)*10)-45]
			   case val(dec)=8
					gracia=    nombre[(val(dec)*10)-54]
			   case val(dec)=9
					gracia =   nombre[(val(dec)*10)-63]
			endcase
			if val(unid) = 0 .or. val(dec)=1
				nuni = '  '
			else
			   if val(dec)=0
				  nuni = nombre[val(unid)]
			   else
				 nuni ="y"+ " "+nombre[val(unid)]
			   endif
			endif


			if integro < 10000
				letras= trim(unimil)+" "+trim(centena)+" "+trim(gracia)+" "+trim(nuni)+" "+rtrim(parcial)
			else
				if integro > 10000
					letras= trim(decemil)+" "+trim(centena)+" "+trim(gracia)+" "+trim(nuni)+" "+rtrim(parcial)
				endif
			
			    IF integro > 100000
			        letras = "Ciento "+trim(decemil)+" "+trim(centena)+" "+trim(gracia)+" "+trim(nuni)+" "+rtrim(parcial)
			      
			    ENDIF  
			      
			endif    


			return letras


ENDDEFINE


DEFINE CLASS VISUREC AS Custom

   archivo = "  "
   legajo  = 0
   liquida = 0
   mes  = 0
   ano   = 0
   cancelar = .t.

   PROCEDURE init
      
        this.mes =  month(date())
        this.ano =  year(date())


   ENDPROC
  
   
   PROCEDURE veorec
          varchivo = this.archivo 
          SELECT * FROM (varchivo)  WHERE legajo=this.legajo;
         .and. liquida = this.liquida ORDER BY concepto INTO cursor recibo READWRITE
    
   ENDPROC   
   
   PROCEDURE Mesatras
     
     IF this.mes = 1
        this.mes = 12
        this.ano = this.ano - 1    
    ELSE
       this.mes = this.mes - 11
    ENDIF   
  ENDPROC
   

  

    


 

ENDDEFINE



DEFINE CLASS LQSAC AS LIQUIDACION

wlustro  = " "
wano     = 0
wtiposac = 0
wmejor   = 0





PROCEDURE LIQUISAC
      wlustro = "SBR" +SUBSTR(STR(this.wano,4),3)
      
      IF this.wtiposac = 1
         SELECT enero,febrero,marzo,abril,mayo,junio FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR calcsac
         this.wmejor = 0 
         this.wmejor = enero
         
         IF febrero > this.wmejor    
            this.wmejor = febrero
         ENDIF    
      
         IF marzo > this.wmejor    
            this.wmejor = marzo
         ENDIF    
      
         IF abril > this.wmejor    
            this.wmejor = abril
         ENDIF    
         
         IF mayo  > this.wmejor    
            this.wmejor = mayo
         ENDIF    
       
         IF junio > this.wmejor    
            this.wmejor = junio
         ENDIF    
      
      ENDIF
      
      
      
      
     IF this.wtiposac = 2
         SELECT junio,julio,agosto,setiembre,octubre,noviembre,diciembre FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR calcsac
         this.wmejor = 0
         this.wmejor = junio
         
         IF julio > this.wmejor
            this.wmejor = Julio
         ENDIF   
           
         IF agosto > this.wmejor
                 this.wmejor = agosto
         ENDIF
              
         IF setiembre > this.wmejor
             this.wmejor = setiembre
         ENDIF
                
         IF  octubre > this.wmejor
              this.wmejor = octubre
         ENDIF
             
         IF  noviembre > this.wmejor
              this.wmejor = noviembre
         ENDIF
         
         IF   diciembre > this.wmejor                  
                 this.wmejor = diciembre   
         ENDIF
     ENDIF    
      
ENDPROC






ENDDEFINE


DEFINE CLASS VAC AS liquidacion

    PROCEDURE INIT
    
    
    ENDPROC


	PROCEDURE etiquetames
	     
	      
	      
	      DO CASE
	         CASE this.wmes = 10
	         
	         
	         
	          
	ENDPROC      
ENDDEFINE


DEFINE CLASS VACACIONES As Custom
   	 legajo      = 0
   	 anovac         = 0
     Desde       = CTOD("  /  /    ")
     hasta       = CTOD("  /  /    ")
     dias        = 0
     Sueldos     = 0
     registradas = 0
     PROCEDURE Existe
       SELECT desde,hasta,dias,sueldos,ano FROM vacaci;
       WHERE legajo = this.legajo  .and. ano = this.anovac INTO CURSOR existe;
      
       if NOT eof()
          this.desde        = existe.desde
          this.hasta        = existe.hasta
          this.dias         = existe.dias
          this.sueldos      = existe.sueldos
          this.anovac       = existe.ano
          this.registradas  = 1
      
       endif
     
     ENDPROC
     
     
     
     PROCEDURE Insertar
        this.existe
        IF this.registradas = 0
           INSERT INTO vacaci (legajo,ano,desde,hasta,dias,sueldos);
           VALUES (this.legajo,this.anovac,this.desde,this.hasta,this.dias,this.sueldos)
           
           
        ELSE
           WAIT WINDOW "Vacaciones Registradas"   
        
        ENDIF
     ENDPROC
     
     PROCEDURE calcudiasvac
       	parameters ans
       	Vcdiasv = 0
		IF ans  = 0
   		   RETURN Vcdiasv
		endif   

		do case
 		   case ans =< 4
                Vcdiasv  = 14
  		   case ans >=5 .and. ans <= 9     
        		Vcdiasv = 21   
   		  case ans >= 10 .and. ans <= 19
        		Vcdiasv = 28
   			case ans >19
        		Vcdiasv = 35
		ENDCASE
		
		IF ans < 5
		  Vcdiasv = 14
		ENDIF  
		
		RETURN Vcdiasv
     
     ENDPROC
     
     
     
     
     
     
  ENDDEFINE 

  DEFINE CLASS Formvac as Custom
   legajo = 0
   nombre = " "
   dias = 0 
   desde = CTOD("  -  -    ")
   hasta = CTOD("  -  -    ")
  ENDDEFINE





   
