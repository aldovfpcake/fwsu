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
	wdisplaynove  = .f.
	Procedure Init
		Set Date Italian
		Set Century On
		SET exclusive off
		SET DELETED on
		*This.buscolegajo
		*this.cargobase

	Endproc

	Procedure LIQUIDA
		Local wvalorfin As Decimal
        For i = 1 To Alen(This.wacumula)
			This.wacumula(i) = 0
		Endfor
		
		Select curliq
		GO top
		SCAN
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
					

				Case This.wconextracc =  'MAESTRO'
                      
                      this.buscobase (curliq.concepto)
                       
				Case This.wconextracc = 'PROMEDIO'
                      this.promedio 
                      
				Case This.wconextracc = 'USUARIO'

				Case This.wconextracc = 'EMBARGO'
                     This.embargo 
			    CASE This.wconextracc = 'EBGALIMENT'
			         this.embargosal
			
			
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
          
            
            Try 
	            DO Case
	               CASE this.wmodocarg   = 'CANTIDAD'
	                                                       
	                    this.wimporte    =  wvalorfin * this.wcant   
	               CASE this.wmodocarg   = 'IMPORTE' .AND. this.wmodocarg = 'USUARIO' .AND. this.wconextracc = 'MAESTRO'
	                  *  this.wimporte    =  this.buscobase(curliq.concepto)
	               CASE this.wmodocarg   = "IMPORTE" .AND. this.wconextracc = "USUARIO"         
	                    this.wimporte    =  curliq.aporte + curliq.sinaporte + curliq.descuento
	               CASE this.wconextracc = 'ANTIGUEDAD' .AND. this.wmodocarg = 'DEFECTO'
	                    this.wimporte    =  wvalorfin
	               CASE this.wmodocarg   = 'DEFECTO' 	        
	                    this.wimporte	 =  wvalorfin
	                CASE this.wmodocarg   =  'IMPORTE' .and. this.wconextracc = 'MAESTRO'
	                   * this.wimporte    =  this.buscobase(curliq.concepto)
	            ENDCASE
	        CATCH TO errp
	              this.mensaje("Error En Reemplazo En Concepto " + STR(curliq.concepto,4))
	        
	        
	        ENDTRY   
           
           IF EMPTY(this.wimporte)
              this.wimporte = 0
           ENDIF   
           
            * SE USA POR COMAPTIBILIDAD
           * 
            IF curliq.concepto = 150
               this.embargosal
            ENDIF
           
           
           
            DO Case
               CASE this.wtipoconcep =  'C/APORTE'   
                    SELECT curliq
                    replace curliq.aporte WITH this.wimporte
                    this.waporte = this.waporte + this.wimporte
               CASE this.wtipoconcep =  'APORTE NEG'        
                    this.wtotaporneg = this.wtotaporneg + this.wimporte
                    SELECT curliq 
                    replace curliq.aporte WITH (this.wimporte - (this.wimporte*2))
                    this.wimporte = (this.wimporte - (this.wimporte*2))
               CASE this.wtipoconcep =   'S/APORTE' 
                    SELECT curliq
                    replace  curliq.sinaporte WITH this.wimporte
                    this.wtotsinapor = this.wtotsinapor+ this.wimporte
               CASE this.wtipoconcep =   'DESCUENTO'       
                    SELECT curliq
                    replace  curliq.descuento WITH this.wimporte 
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
			This.mensaje("Error Concepto Inexistente")
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
      retorna = .f. 
      SELECT * FROM AUDITOR WHERE MES = this.wmes .and. ANO = this.wano .and. legajo = this.wlegajo;
      INTO CURSOR VEOAUDIT
      IF .not. EOF()
          IF this.wdisplaynove = .t.
             MESSAGEBOX("Se Detectan Novedades a Cargar",16,"Atención")
            * browse
          ENDIF 
          retorna = .t.
      ENDIF
      SELECT VEOAUDIT
      
      *SELECT CURLIQ
      return retorna
    
    Endproc



	Procedure mensaje
		Parameters elmensaje
		Messagebox(elmensaje,16,"Error")



	Endproc

	Procedure calcuant
*-- Cálculo de antiguedad
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
		Select * From PERSONAL Where LEGAJO = This.wlegajo;
			INTO Cursor CURPERSO
		If CURPERSO.LEGAJO = 0
			This.mensaje("Error legajo Inexistente " + Str(This.wlegajo,4))
			This.wcancelar = .F.
		Else
			This.wfechaingreso  = CURPERSO.fechaing
			This.wantiganterior = CURPERSO.antigant
			This.wcategoria     = Ltrim(CURPERSO.categoria)
		Endif
        if !EMPTY(CURPERSO.fechabaja)
           MESSAGEBOX("Legajo de Baja  " + DTOS(fechabaja),16,'Atención')
        endif           
           
    

	Endproc


	Procedure buscocategoria
		Select * From CATEGO Where DESCATEG = This.wcategoria;
			INTO Cursor CURCATEG
		If Empty(CURCATEG.DESCATEG)
			This.mensaje("No se Encuentra la categoria" + This.wcategoria)
			This.wcancelar = .F.
		Else
			This.wimporte = CURCATEG.importe
		Endif

	Endproc

    PROCEDURE Buscobase 
        PARAMETERS bcpto
        
        SELECT * FROM maper WHERE legajo = this.wlegajo;
        .AND.  TIPOLIQ = this.wtipoliq  .AND. CONCEPTO = bcpto INTO CURSOR curmaper
        IF curmaper.concepto = 0
           This.mensaje("No se Encuentra el concepto "+ CHR(9)+ "cargado en la liquidación base....:" + STR(curmaper.concepto,4))
           This.cancelar = .F. 
        ELSE
           this.wimporte = curmaper.importe
           RETURN curmaper.importe
        ENDIF 
        this.auditar

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
         	this.mensaje("Empleado Sin Liquidación base")
       	 RETURN
      	ENDIF
      	
      	SCAN
          	 wexiste = 0
          	SELECT CONCEPTO  FROM CURLIQ  WHERE CURLIQ.CONCEPTO = BASELIQ.CONCEPTO INTO CURSOR EXTCOP
          	IF EXTCOP.CONCEPTO = 0
          	         
            			INSERT INTO CURLIQ (LEGAJO,CONCEPTO,CANTIDAD,LIQUIDA);
            			VALUES(this.wlegajo,BASELIQ.CONCEPTO,BASELIQ.UNIDADES,this.wtipoliq)
          	             
          	ENDIF
          	SELECT BASELIQ
     	ENDSCAN
     	 SELECT BASELIQ
     	 USE
     	 SELECT EXTCOP
     	 USE
     	 SELECT CURLIQ   
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


    PROCEDURE TRAERECIBO
      * DEFINER EL ARCHIVO DE LIQUIDACION
      *INSERT INTO CURLIQ (CONCEPTO,CANTIDAD,APORTE,SINAPORTE,DESCUENTO);
       
        *if this.wmes > 1 
           wmesliq = this.wmes -1
           if this.wmes < 6
          	  this.wmesanterior = ALLTRIM(STR(wmesliq,1)+ STR(this.wano,4))
           else   
              this.wmesanterior = ALLTRIM(STR(wmesliq,2)+ STR(this.wano,4))
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
          	   IF RECSU.CONCEPTO = 130 .OR. RECSU.CONCEPTO = 99 .OR. RECSU.CONCEPTO = 123
          	       
          	       
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
    SCAN 
       IF buconcepto = curliq.concepto
          EXTCOP = 1
          EXIT 
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
               SELECT enero as impt FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust
               SELECT julio,agosto,setiembre,octubre,noviembre,diciembre FROM &waanter WHERE legajo = this.wlegajo INTO CURSOR aterior
               prome1 =   (lust.impt + aterior.agosto + aterior.setiembre + aterior.octubre + aterior.noviembre + aterior.diciembre)/6
           CASE this.wmes = 2 
               SELECT  agosto,setiembre,octubre,noviembre,diciembre FROM &waanter WHERE legajo = this.wlegajo INTO CURSOR aterior
               SELECT aterior
               SELECT  (enero) as impt FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust
               SELECT lust
               prome1 =  (lust.impt+aterior.agosto+ aterior.setiembre + aterior.octubre + aterior.noviembre + aterior.diciembre)/6
               IF lust.impt > prome1
                  prome1 = lust.impt
                  WAIT WINDOW "TOMANDO BASE ENERO"
               ENDIF
               WAIT WINDOW STR(prome1,8,2)
          CASE this.wmes = 3 
               SELECT setiembre,octubre,noviembre,diciembre FROM &waanter WHERE legajo = this.wlegajo INTO CURSOR aterior
               SELECT  (enero+febrero) as impt FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust
               prome1 =  (lust.impt+aterior.setiembre + aterior.octubre + aterior.noviembre + aterior.diciembre)/6
               WAIT WINDOW STR(prome1,8,2)
               
          CASE this.wmes = 4 
               SELECT   octubre,noviembre,diciembre FROM &waanter WHERE legajo = this.wlegajo INTO CURSOR aterior
               SELECT  (enero+febrero+marzo) as impt FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust
               SELECT  (marzo) as ultimo FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR ultimosue
               prome1 =  (aterior.octubre+aterior.noviembre+aterior.diciembre+lust.impt)/6
  
              IF ultimosue.ultimo > prome1
                 prome1 = ultimosue.ultimo
                 WAIT WINDOW "TOMANDO BASE ABRIL"
              ENDIF     
  
            
          CASE this.wmes = 5 
               SELECT  (enero+febrero+marzo+abril+mayo ) as impt FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust 
               prome1 =  (lust.impt)/5 
          
          CASE this.wmes = 6 
               SELECT  (enero+febrero+marzo+abril+mayo ) as impt FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust
               SELECT   diciembre FROM &waanter WHERE legajo = this.wlegajo INTO CURSOR aterior
               SELECT  (marzo) as ultimo FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR ultimosue
               prome1 = (lust.impt + aterior.diciembre)/6  
          
               IF ultimosue.ultimo > prome1
                 prome1 = ultimosue.ultimo
                 
               ENDIF     
  
          
          CASE this.wmes = 7 
               SELECT  (enero+febrero+marzo+abril+mayo+ junio) as impt FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust 
               prome1 =  (lust.impt)/6 
          CASE this.wmes = 8
               SELECT  (febrero+marzo+abril+mayo+ junio+ julio) as impt FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust 
               prome1 =  (lust.impt)/6
          CASE this.wmes = 9
               SELECT  (marzo+abril+mayo+ junio+ julio+ agosto) as impt FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust 
               prome1 =  (lust.impt)/6
          CASE this.wmes = 10
               SELECT  (abril+mayo+ junio+ julio+ agosto + setiembre ) as impt FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust 
               prome1 =  (lust.impt)/6
          CASE this.wmes = 11 
               SELECT  (mayo+ junio+ julio+ agosto + setiembre+octubre ) as impt FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust 
               prome1 =  (lust.impt)/6
          CASE this.wmes = 12 
               SELECT  (junio+ julio+ agosto + setiembre+octubre+noviembre ) as impt FROM &wlustro WHERE legajo = this.wlegajo INTO CURSOR lust 
               prome1 =  (lust.impt)/6
      ENDCASE
      
      this.wimporte = prome1
      *SELECT lust
     * use
     * SELECT anterior
     * use   
   
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
              VarEmbargo = (this.waporte - SalarioMin)*0.20
         CASE this.waporte  < SalarioMin*2              
              VarEmbargo = (this.waporte - SalarioMin)*0.10
      ENDCASE         
      this.wimporte = VarEmbargo
      
    ENDPROC
    
    PROCEDURE EMBARGOSAL
       
       LOCAL VarTotalSueldo,VarEmbargo
       STORE 0 TO VarTotalSueldo,VarEmbargo
       VarTotalSueldo = (this.waporte -this.wtotaporneg)+ this.wtotsinapor
       VarEmbargo     = (VarTotalSueldo*this.wcant)/100  
       this.wimporte  = VarEmbargo
       
    
    
    
    ENDPROC
    
    
 
Enddefine



DEFINE CLASS configurar AS liquidacion
 PropRuta = " "
 
     
    PROCEDURE init
       
 
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
       SET PATH TO t:\FWSU\FORMS;t:\FWSU\PRG;F:\SUELDOS\EMPRE1;F:\SUELDOS
    Endproc

    PROCEDURE Abrobase
       TRY 
         OPEN DATABASE SUELDOS
       CATCH TO Err
         this.mensaje ("Error No se Puede Abrir la Base De Datos")
       ENDTRY   
	Endproc



ENDDEFINE




