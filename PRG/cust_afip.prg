DEFINE CLASS custafipanses AS custom 
 	*< CLASSDATA: Baseclass="custom" Timestamp="" Scale="Pixels" Uniqueid="" />

	*<DefinedPropArrayMethod>
		*m: havinternet
		*m: just_digits
		*m: mtdcomprobarconexion
		*m: mtdconsultaafip		&& Metodo que consulta la constancia de inscripcion en el navegador
		*m: mtdconsultaanses		&& Metodo que consulta el CUIL en el navegador
		*m: mtd_consultacae
		*m: mtd_validezcomprob
		*m: showerror
		*p: propapellido
		*p: propapellidocasada
		*p: propcuil		&& Almacena el CUIL a consultar
		*p: propcuit		&& Almacena el CUIT a consultar
		*p: propdirafip		&& Direccion COnstancia de Inscripcion
		*p: propdiranses		&& Direccion Constancia CUIL
		*p: propdni
		*p: propestcivil		&& Casado=2 / Union de Hecho=7 / Soltero=1 / Viudo=3 / Divorciado=6
		*p: propfecnac
		*p: propnombre
		*p: propsexo		&& 0=femenino / 1 = Masculino
		*p: url_comprobantes
		*p: url_factura_electronica
	*</DefinedPropArrayMethod>

	Height = 16
	Name = "custafipanses"
	Picture = afipanses.png
	propapellido = 
	propapellidocasada = 
	propcuil = 		&& Almacena el CUIL a consultar
	propcuit = 		&& Almacena el CUIT a consultar
	propdirafip = https://seti.afip.gob.ar/padron-puc-constancia-internet/jsp/Constancia.jsp		&& Direccion COnstancia de Inscripcion
	propdiranses = http://servicioswww.anses.gov.ar/ConstanciadeCuil2/Inicio.aspx		&& Direccion Constancia CUIL
	propdni = 
	propestcivil = 0		&& Casado=2 / Union de Hecho=7 / Soltero=1 / Viudo=3 / Divorciado=6
	propfecnac = {}
	propnombre = 
	propsexo = 1		&& 0=femenino / 1 = Masculino
	url_comprobantes = http://www.afip.gob.ar/genericos/imprentas/facturas.asp
	url_factura_electronica = http://www.afip.gob.ar/genericos/consultacae/
	Width = 17
	
	PROCEDURE havinternet
		LOCAL llret
		DECLARE LONG InternetGetConnectedState IN "wininet.dll" LONG lpdwFlags, LONG dwReserved
		llRet=IIF(InternetGetConnectedState(0, 0) = 1,.t.,.f.)
		RETURN llret
		
	ENDPROC

	PROCEDURE just_digits
		LPARAMETERS tcString
		** Luis María Guayan
		** Devuelve únicamente los números que contiene una cadena
		return CHRTRAN(m.tcString,CHRTRAN(m.tcString,"1234567890",""),"")
	ENDPROC

	PROCEDURE mtdcomprobarconexion
		PARAMETERS parURL
		tcURL = IIF(TYPE("tcURL")="C" AND !EMPTY(tcURL),tcURL,parURL)
		
		DECLARE INTEGER InternetCheckConnection in wininet;
			STRING lpszUrl,;
				INTEGER dwFlags,;
					INTEGER dwReserved
		
		lcResul = InternetCheckConnection(tcURL, 1, 0) == 1
		  
		RETURN lcResul
	ENDPROC

	PROCEDURE mtdconsultaafip		&& Metodo que consulta la constancia de inscripcion en el navegador
		TRY 
			LOCAL loex as Exception,;
				loBar as Object,;
				objIe as Object,;
				lcMessage
			
			lcMessage = "No hay Conexión a Internet"
			
			IF This.Havinternet()
				lcMessage = "No se puede mostrar la página"		
				IF this.mtdcomprobarconexion(this.propdirafip)
					lcMessage = ""
			
					* Crea Objeto de barra de esperando respuesta
					loBar = NEWOBJECT("frmConectando","afip_anses.vcx")
					
					* Crea un objeto Explorer y lo hace visible
					objIE =Createobject("InternetExplorer.Application")
					IF VARTYPE(objIE) = "O"
						loBar.Show()
		
					
						*Dirección a la que tiene que apuntar
						IR_A = ALLTRIM(this.propdirafip)
						objIE.navigate(ir_a)
		
						* Espera mientras se conecta a la dirección indicada ...
						loBar.Show_Bar()
						DO While objIE.busy OR objIE.readystate#4
							loBar.Show_bar()
						ENDDO
		
						* Ocultar la barra de espera y mostrar página
						loBar.Hide()
						objIE.Visible =.T.	
							
						* Introducir los valores en el formulario
						objIE.document.Constancia.cuit.value=allt(CHRTRAN(this.propcuit,"-",""))
						objIE.document.Constancia.captchaField.focus()
					ENDIF 
				ENDIF
			ENDIF
			
		CATCH TO loex
			loex.UserValue=PROGRAM()
			this.showerror(loex)
		FINALLY
			loBar = null
			objIe = null
			IF NOT EMPTY(m.lcMessage)
				MESSAGEBOX(m.lcMessage,0,"Mensaje del Sistema")
			ENDIF 
			
		ENDTRY 
		
	ENDPROC

	PROCEDURE mtdconsultaanses		&& Metodo que consulta el CUIL en el navegador
		TRY 
			LOCAL lobar,;
				loEx as Exception,;
				objAnses as Object,;
				lcMessage
				
			lcMessage = "No hay conexión a Internet"
			IF this.havinternet()
				lcMessage = "No se puede mostrar la página: "+CHR(13)+this.propdiranses 
			
				IF this.mtdcomprobarconexion(this.propdirafip)
					lcMessage = ""			
				
					loBar = NEWOBJECT("frmConectando","afip_anses.vcx")
					
					objAnses=Createobject("InternetExplorer.Application")
					IF VARTYPE(objAnses) = "O"
						loBar.Show()
						
						objAnses.navigate(this.propdiranses)
		
						loBar.Show_Bar()
						DO While objAnses.busy OR objAnses.readystate#4
							loBar.Show_bar()
						ENDDO
						
						loBar.HIde()
						objAnses.Visible =.T.
						
						objAnses.document.aspnetForm.ctl00_Contenido_Apellido.Value = ALLTRIM(this.propapellido)
						objAnses.document.aspnetForm.ctl00_Contenido_Apellido_Casada.Value = ALLTRIM(this.propapellidocasada)
						objAnses.document.aspnetForm.ctl00_Contenido_Nombre.Value = ALLTRIM(this.propnombre)
						DO CASE
							CASE this.propsexo = 0
								objAnses.document.aspnetForm.ctl00_Contenido_Sexo_0.Click()
							CASE this.propsexo = 1	
								objAnses.document.aspnetForm.ctl00_Contenido_Sexo_1.Click() 
							OTHERWISE
								objAnses.document.aspnetForm.ctl00_Contenido_Sexo_1.Click() && por defecto masculino
						ENDCASE
						objAnses.document.aspnetForm.ctl00_Contenido_Nro_Doc.Value = CHRTRAN(ALLTRIM(this.propdni),".","")
						objAnses.document.aspnetForm.ctl00_Contenido_Fecha.Value = PADL(ALLTRIM(STR(DAY(this.propfecnac))),2,"0")+ ;
						 "/" + PADL(ALLTRIM(STR(MONTH(this.propfecnac))),2,"0") + "/" + ALLTRIM(STR(YEAR(this.propfecnac)))
						objAnses.document.aspnetForm.ctl00_Contenido_Estado_Civil.Value = this.propestcivil
						objAnses.document.aspnetForm.ctl00_Contenido_CodImagen.focus()
					ENDIF
				ENDIF
			ENDIF
			
		CATCH TO loex
			loex.UserValue=PROGRAM()
			this.showerror(loex)
		FINALLY 
			loBar = null
			objAnses = null
			IF NOT EMPTY(m.lcMessage)
				MESSAGEBOX(m.lcMessage,0,"Mensaje del sistema")
			ENDIF 
		ENDTRY 
			
		 
	ENDPROC

	PROCEDURE mtd_consultacae
		LPARAMETERS tcCuit,tcCai,tdFEcha,tcComprob,tcCodAfip,tnImporte,tcTipoDoc,tlPropio
		
		
		tcTipoDoc = EVL(tcTipoDoc,"80")
		
		*afip_Anses.Vcx//.CustAfipAnses//obj.mtd_ValidezComprob(lcCuit,lcCai,ldFEcha,lcFactura,lcCodafip)
		IF !this.Havinternet()
			MESSAGEBOX("No hay conexión a Internet",0,"Mensaje del Sistema")
			RETURN
		ENDIF 
		
		LOCAL cDia,cMes,cAno,cPtoVenta,cNumero,lnLen,lcImporte,;
			lcCuitREceptor
		
		tcCuit= this.just_digits(m.tcCuit)
		tcCai = this.just_digits(m.tcCai)
		cDia = PADL(TRANSFORM(DAY(m.tdFEcha)),2,"0")
		cMes = PADL(TRANSFORM(MONTH(m.tdFecha)),2,"0")
		cAno = TRANSFORM(YEAR(m.tdFecha))
		tcComprob = this.just_digits(m.tcComprob)
		tnImporte = ABS(tnImporte)
		IF tlPropio
			lcCuitReceptor = m.tcCuit
			tcCuit = this.just_digits(micuitEmp)
		ELSE
			lcCuitReceptor = this.just_digits(miCuitEmp)
		ENDIF 
		
		lnLen = LEN(m.tcComprob)
		IF lnLen > 12
			tcComprob = RIGHT(m.tcComprob,12)
		ENDIF
		
		cPtoVenta = LEFT(m.tcComprob,4)
		cNumero = TRANSFORM(VAL(RIGHT(m.tcComprob,8)))
		*tcCodAfip=PADL(m.tcCodafip,3,CHR(32))
		tcCodAfip =TRANSFORM(VAL(m.tcCodAfip))
		lcImporte = LTRIM(STR(m.tnImporte,14,2))
		tcTipoDoc = TRANSFORM(VAL(m.tcTipoDoc))
		RELEASE objIe
		PUBLIC objIe
		
		lcRes = this.mtdcomprobarconexion(this.url_comprobantes)
		
		IF lcRes THEN 
			TRY 
			
				LOCAL loex As Exception,lShowError,;
					loBar as Object
				lShowError = .t.			
				loBar = NEWOBJECT("frmConectando","afip_anses.vcx")
		
			
				* Crea un objeto Explorer y lo hace visible
				objIE =Createobject("InternetExplorer.Application")
				IF VARTYPE(objIE)="O" 
					
					lShowError = .f.
					
					loBar.Show()
					*Dirección a la que tiene que apuntar
					IR_A = ALLTRIM(this.url_factura_electronica)
		*			this.url_comprobantes)
					objIE.navigate(ir_a)
		
					* Espera mientras se conecta a la dirección indicada ...
					loBar.Show_Bar()
					DO While objIE.busy OR objIE.readystate#4
						loBar.Show_bar()
					ENDDO
		
					loBar = null
					objIE.Visible =.T.	
					objIE.Document.getelementbyid("p_CUIT").Value = m.tcCuit	&& EMISOR
					objIE.Document.getelementbyid("p_CAE").Value = m.tcCai
					objIE.Document.getelementbyid("p_fch_emision_day").Value = m.cDia
					objIE.Document.getelementbyid("p_fch_emision_month").Value = m.cMes
					objIE.Document.getelementbyid("p_fch_emision_year").Value = m.cAno
					objIE.Document.getelementbyid("p_tipo_cbte").value = m.tcCodafip
					objIE.Document.getelementbyid("p_pto_vta").Value = m.cPtoVenta
					objIE.Document.getelementbyid("p_nro_cbte").Value = m.cNumero
					objIE.Document.getelementbyid("p_importe").Value = m.lcImporte			
					objIE.Document.getelementbyid("p_tipo_doc").Value = m.tcTipoDoc
					objIE.Document.getelementbyid("p_nro_doc").Value = m.lcCuitREceptor						
				ENDIF 
			
			CATCH TO loex
				loex.UserValue=PROGRAM()
				IF lShowError
					This.showerror(loex)
				ENDIF 
		
			FINALLY
				loBar = null
				objIE= null
			ENDTRY 
			
		ELSE 
			MESSAGEBOX("No se puede mostrar la pagina, compruebe su conexión de Internet",0+48,"Error")
		ENDIF 
	ENDPROC

	PROCEDURE mtd_validezcomprob
		LPARAMETERS tcCuit,tcCai,tdFEcha,tcComprob,tcCodAfip,tlPropio
		
		*afip_Anses.Vcx//.CustAfipAnses//obj.mtd_ValidezComprob(lcCuit,lcCai,ldFEcha,lcFactura,lcCodafip)
		* Metodo para comprobantes de IMprenta con Nro de CAI
		* ----------------------------------------------------
		
		TRY
			LOCAL loex As Exception,lShowError,;
				loBar as Object,;
				objIe as Object, ;
				cDia,cMes,cAno,;
				cPtoVenta,cNumero,;
				lnLen,;
				lcMessage
				
			lcMessage = "No hay conexión a Internet"
			IF this.Havinternet()	
				lcMessage= "No se puede mostrar la página:"+CHR(13);
					+ this.url_comprobantes
				IF this.mtdcomprobarconexion(this.url_comprobantes)
					lcMessage = ""		
					
					tcCuit= IIF(m.tlpropio,this.just_digits(miCuitEmp),this.just_digits(m.tcCuit))
					tcCai = this.just_digits(m.tcCai)
					cDia = PADL(TRANSFORM(DAY(m.tdFEcha)),2,"0")
					cMes = PADL(TRANSFORM(MONTH(m.tdFecha)),2,"0")
					cAno = TRANSFORM(YEAR(m.tdFecha))
					tcComprob = this.just_digits(m.tcComprob)
		
					lnLen = LEN(m.tcComprob)
					IF lnLen > 12
						tcComprob = RIGHT(m.tcComprob,12)
					ENDIF
		
					cPtoVenta = LEFT(m.tcComprob,4)
					cNumero = TRANSFORM(VAL(RIGHT(m.tcComprob,8)))
					tcCodAfip=PADL(m.tcCodafip,3,CHR(32))
		
					lShowError = .t.			
					loBar = NEWOBJECT("frmConectando","afip_anses.vcx")
		
				
					* Crea un objeto Explorer y lo hace visible
					objIE =Createobject("InternetExplorer.Application")
					IF VARTYPE(objIE)="O" 
						
						lShowError = .f.
						
						loBar.Show()
						*Dirección a la que tiene que apuntar
						IR_A = ALLTRIM(this.url_comprobantes)
						objIE.navigate(ir_a)
		
						* Espera mientras se conecta a la dirección indicada ...
						loBar.Show_Bar()
						DO While objIE.busy OR objIE.readystate#4
							loBar.Show_bar()
						ENDDO
		
						loBar = null
						objIE.Visible =.T.	
						objIE.Document.getelementbyid("fcuit").Value = m.tcCuit
						objIE.Document.getelementbyid("fcai").Value = m.tcCai
						objIE.Document.getelementbyid("fdia").Value = m.cDia
						objIE.Document.getelementbyid("fmes").Value = m.cMes
						objIE.Document.getelementbyid("fanio").Value = m.cAno
						objIE.Document.getelementbyid("fnro_comprob").value = m.tcCodafip
						objIE.Document.getelementbyid("fpvta").Value = m.cPtoVenta
						objIE.Document.getelementbyid("fnumero").Value = m.cNumero
		
					ENDIF
				ENDIF	
			ENDIF 
		CATCH TO loex
			loex.UserValue=PROGRAM()
			IF lShowError
				This.showerror(loex)
			ENDIF 
		
		FINALLY
			loBar = null
			objIE= null
			IF NOT EMPTY(m.lcmessage)
				MESSAGEBOX(m.lcMessage,0,"Mensaje del Sistema")
			ENDIF 
		ENDTRY 
			
		 
	ENDPROC

	PROCEDURE showerror
		LPARAMETERS toExcep,tlNotShow,tcCaption
		*--------------------------------------
		tcCaption=EVL(tcCaption,"Mensaje del Sistema")
		LOCAL lcMens
		lcMens="Fecha "+TRANSFORM(DATETIME());
			+CHR(13)+"Mensaje: "+toExcep.message;
			+CHR(13)+"ErrorNo: "+TRANSFORM(toExcep.Errorno);
			+CHR(13)+"Llamada: "+toExcep.Uservalue 
		IF _vfp.StartMode=0
			lcMens=lcMens+CHR(13)+"linea "+TRANSFORM(toExcep.lineno)
		ENDIF
		
		STRTOFILE(lcMens+CHR(13)+CHR(13),"ThError.log",1)
		lcMens="Se ha producido un error:"+chr(13)+lcMens
		IF !tlNotShow
			MESSAGEBOX(lcMens,0,tcCaption)
		ENDIF
		
	ENDPROC

ENDDEFINE
