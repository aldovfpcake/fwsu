**************************************************
*-- Class:        reportesueldo (c:\fwsu\clases\rh.vcx)
*-- ParentClass:  custom
*-- BaseClass:    custom
*-- Time Stamp:   07/12/17 10:34:13 AM
*-- genera reporte de sueldo
*
DEFINE CLASS reportesueldo AS custom

    
	filtro = 3
	*-- Esta propiedad determina si el reporte excluyendo un tipo de liquida
	distinta = 0
	*-- vista previa 0 imprime 1 visualiza
	vistapre = 0
	liquida = "62017"
	Name = "reportesueldo"


	*-- genera reporte de sueldo
	PROCEDURE reporte
		SET DELETED ON
		IF this.distinta = 0
 		   SELECT legajo as chapa,this.nombrep() as nombre ,this.seccion()as seccion,this.banc() as banco,this.cuentabanc() as cuenta ,this.cuil() as cuil,SUM(aporte + sinaporte -descuento)as sntecob,SUM(valoruni)as pagdo,SUM(IIF(CONCEPTO = 99,DESCUENTO,0.00))as sadel,;
		   SUM(IIF(CONCEPTO=14,CANTIDAD,0.00))as CantCtrol,SUM(IIF(CONCEPTO=14,aporte,0.00))as ImptCtrol,;
		   SUM(IIF(CONCEPTO=17,CANTIDAD,0.00))as CantKMn,SUM(IIF(CONCEPTO=17,APORTE,0.00))as KMn,;
		   SUM(IIF(CONCEPTO=23,CANTIDAD,0.00))as CantKM100,;
		   SUM(IIF(CONCEPTO =23,APORTE,0.00))as KM100,SUM(IIF(CONCEPTO =24,APORTE,0.00))as FR,;
		   SUM(IIF(CONCEPTO = 130,DESCUENTO,0.00))AS ganancia, SUM(IIF(CONCEPTO =10000,APORTE,0.00)) as sneto,SUM(IIF(CONCEPTO =123,DESCUENTO,0.00))as smutual,;
		   SUM(IIF(CONCEPTO = 126.OR.CONCEPTO = 127 .OR. CONCEPTO = 142 .OR. CONCEPTO = 150 .OR. CONCEPTO = 153,DESCUENTO,0.00))AS embargo,;
		   this.totsu() as totalsu,this.tarjeta() as tarjeta,SUM(APORTE) as sbruto ;
		   FROM 62017 WHERE liquida = this.filtro group BY liquida,legajo INTO CURSOR SUE3 READWRITE
		ELSE
		   SELECT legajo as chapa,this.nombrep() as nombre ,this.seccion()as seccion,this.banc() as banco,this.cuentabanc() as cuenta ,this.cuil() as cuil, SUM(aporte + sinaporte -descuento)as sntecob,SUM(valoruni)as pagdo,SUM(IIF(CONCEPTO = 99,DESCUENTO,0.00))as sadel,;
		   SUM(IIF(CONCEPTO=130,DESCUENTO,0.00))as snacion,SUM(IIF(CONCEPTO =123,DESCUENTO,0.00))as smutual,;
		   SUM(IIF(CONCEPTO = 126.OR.CONCEPTO = 127 .OR. CONCEPTO = 142 .OR. CONCEPTO = 150 .OR. CONCEPTO = 153,DESCUENTO,0.00))AS embargo,SUM(IIF(CONCEPTO =10000,APORTE,0.00)) as sneto,;
		   this.totsu() as totalsu,this.tarjeta() as tarjeta,SUM(APORTE)as sbruto ;
		   FROM liquida WHERE liquida <> this.distinta group BY liquida,legajo INTO CURSOR SUE3 READWRITE
		ENDIF
		   
		SELECT SUE3
		CLEAR
		GO TOP
		SCAN
		    
		    SELECT LEGAJO,NOMBRE,FECHABAJA,DEPART,SECCION,CUENTABANC,CUIL FROM PERSONAL WHERE LEGAJO = SUE3.CHAPA INTO CURSOR EXISTE
		    SELECT EXISTE
		    
		       
		    IF .NOT. EOF()
		       IF .NOT.EMPTY(FECHABAJA)
		            VarStrNom = EXISTE.NOMBRE
		            REPLACE SUE3.NOMBRE  WITH SUBSTR(VarStrNom,1,10)+ "***BAJA**"
		            REPLACE SUE3.BANCO   WITH "PAGADO" 
		       ELSE     
		            REPLACE SUE3.NOMBRE WITH EXISTE.NOMBRE
		            REPLACE SUE3.BANCO   WITH EXISTE.DEPART 
		        ENDIF
		       REPLACE SUE3.SECCION WITH EXISTE.SECCION
		       REPLACE SUE3.CUIL    WITH EXISTE.CUIL
		       REPLACE SUE3.CUENTA  WITH EXISTE.CUENTABANC
		       REPLACE SUE3.SNETO   WITH ( SUE3.SNTECOB+ SUE3.SADEL + SUE3.GANANCIA +SUE3.SMUTUAL+SUE3.EMBARGO)
		       REPLACE SUE3.TOTALSU WITH ( SUE3.SNTECOB+ SUE3.SADEL + SUE3.GANANCIA + SUE3.SMUTUAL+SUE3.EMBARGO) 
		       IF SUE3.SNETO < 0
		          MESSAGEBOX("Error Sueldo Negativo" + nombre,16,"Atencion")
		       ENDIF   
		              
		       IF SUE3.PAGDO <> 0
		          REPLACE SUE3.BANCO WITH "PAGADO"
		       ENDIF   
		       
		       IF .NOT. EMPTY(EXISTE.CUENTABANC) 
		          REPLACE SUE3.TARJETA  WITH "BANELCO"
		       ENDIF
		       
		    ENDIF
		    SELECT EXISTE
		    USE
		    SELECT SUE3
		    

		ENDSCAN
		*SELECT SUE3
		*INDEX ON BANCO + STR(CHAPA,4) TO X-SUE3
		*IF this.vistapre = 0
		*   REPORT FORM SUELDOSVF NOCONSOLE  TO PRINTER PROMPT
		*ELSE
		*   REPORT FORM  SUELDOSVF  NOCONSOLE PREVIEW
		*ENDIF   
	ENDPROC


	*-- metodo de consutla devuelve
	PROCEDURE totsu
		vvsuel = 0.00
		return vvsuel
	ENDPROC


	*-- retorna campo en balnco
	PROCEDURE cuentabanc
		vvbanco = SPACE(15)
		RETURN vvbanco
	ENDPROC


	PROCEDURE tarjeta
		vvtarjeta = SPACE(12)

		RETURN vvtarjeta
	ENDPROC


	PROCEDURE banc
		vvbanco = SPACE(15)
		RETURN vvbanco
	ENDPROC


	*-- retorna espacios para guardar el nombre del empleado
	PROCEDURE nombrep
		vvnombre = SPACE(25)
		RETURN vvnombre
	ENDPROC


	PROCEDURE cuil
		vvcuil = SPACE(13)
		RETURN vvcuil
	ENDPROC


	PROCEDURE seccion
		vvsec = SPACE(15)
		RETURN vvsec
	ENDPROC


ENDDEFINE
*
*-- EndDefine: reportesueldo
**************************************************



