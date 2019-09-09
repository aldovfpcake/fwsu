*SET PROCEDURE TO CRG1
*PARAMETERS VVORIGINAL

*
SET DELETED ON

VVARCHI = " "
DO WHILE EMPTY(VVARCHI)
   VVARCHI = INPUTBOX("Ingrese Periodo (mmaaaa)","Ingrese",VVARCHI,5600)
ENDDO


*VVARCHI = "72011"
SET SAFETY OFF
* VERSION 34 SICOSS 
SET PATH TO F:\SUELDOS\EMPRE1
*SET PATH TO C:\SUERUT\EMPRE1;C:\SUERUT
SET DEFAULT TO  C:\SUERUT\EMPRE1
SET PROCEDURE TO c:\SUERUT\CONSULTAS\FUGRAL
VVORIGINAL = 1
  SET EXCLUSIVE ON
  SELE 1
  USE  "F:\SUELDOS\empre1\" + VVARCHI ALIAS LIQUIDA SHARED
  USE &VVARCHI ALIAS LIQUIDA SHARED
  INDEX ON STR(LEGAJO,4) + STR(LIQUIDA,1) + STR(CONCEPTO,4) TO XLIQUIDA  
   
  SET ORDER TO 1
  SELE 2
  USE SUE3 EXCLUSIVE 
  ZAP
  INDEX ON STR(CHAPA,4) TO XSUE3
  SET INDEX TO SUE3
  SELE 3
  USE F:\SUELDOS\EMPRE1\PERSONAL SHARED 
  INDEX ON  STR (LEGAJO,4) TO PERSONAL
  SET ORDER TO 1
  *SET  INDEX TO PERSONAL
  SELE 4 
  USE ASIGFA 
  INDEX ON STR(LEGAJO,4) TO ASIGFA
  SELE 5
  USE CONTRB
  SELE 6
  USE ART
  SET EXCLUSIVE OFF



SELE LIQUIDA
GO TOP

VVLEG = 0
VVLIQ = 0

PUBLIC VVPASO
DECLARE VVPASO [20]

FOR I= 1 TO 20
    VVPASO[I]= 0 
NEXT


STORE 0 TO VVBRUTO,VVIATICO,VVNETO,VVADEL,VVNACION,VVSAL,VVRET,VVNACION,VVMUTUAL,VVCUOTAMUTUAL
STORE 0 TO VVEMBARGO,VVAJCREDMUTUAL,VVAJCREDNACION,VVFAMI,VVCANTHIJ
VVLEG =  LIQUIDA->LEGAJO
VVLIQ =  LIQUIDA->LIQUIDA
VVPAGO = 0

DO WHILE .NOT. EOF()
   IF LIQUIDA->APORTE # 0
      VVBRUTO = VVBRUTO + LIQUIDA->APORTE
   ENDIF   
   
   IF LIQUIDA->SINAPORTE # 0
       
      VVIATICO = VVIATICO + LIQUIDA->SINAPORTE
   ENDIF   
   
   IF LIQUIDA->CONCEPTO = 99
      VVADEL = LIQUIDA->DESCUENTO
   ENDIF   
   
  * IF LIQUIDA->CONCEPTO >= 50 .AND. LIQUIDA->CONCEPTO <= 58   
  *    VVSAL = VVSAL + LIQUIDA->SINAPORTE
  * ENDIF

   IF LIQUIDA->CONCEPTO = 131 .OR. LIQUIDA->CONCEPTO = 80
      VVPASO[14] = LIQUIDA->DESCUENTO 
   ENDIF

   IF LIQUIDA->CONCEPTO = 81
      VVPASO[15] = LIQUIDA->DESCUENTO 
   ENDIF

  IF LIQUIDA->CONCEPTO = 134 .OR. LIQUIDA->CONCEPTO =141 .OR. LIQUIDA->CONCEPTO = 143 
      VVTOTSAL = 0  
      VVTOTSAL = VVSAL
      VVHIJD   = 0
      VVHIJD   = LIQUIDA->SINAPORTE
      VVSAL    =  VVTOTSAL + VVHIJD
  ENDIF    


  * CARGA CANTIDAD DE HIJOS
   IF LIQUIDA->CONCEPTO >= 51 .AND. LIQUIDA->CONCEPTO <= 53.OR. LIQUIDA->CONCEPTO= 134 .OR. LIQUIDA->CONCEPTO = 143
      VVCANTHIJ = LIQUIDA->CANTIDAD
   ENDIF    

   IF LIQUIDA->CONCEPTO = 18
      VVPASO[2] = LIQUIDA->APORTE
   ENDIF

   
   IF LIQUIDA->CONCEPTO = 5 .OR. LIQUIDA->CONCEPTO = 6 .OR. LIQUIDA->CONCEPTO = 17 .OR. LIQUIDA->CONCEPTO = 23
      VVHST       = 0       
      VVHST       = VVPASO[3] + LIQUIDA->APORTE
      
      IF LIQUIDA->CONCEPTO = 5 .OR. LIQUIDA->CONCEPTO = 6
         VVPASO[11]  = VVPASO[11] + LIQUIDA->CANTIDAD 
      ENDIF   
        
      IF LIQUIDA->CONCEPTO = 17         
         VVH50      = 0
         VVSIMPLE   = 0
         VVSIMPLE   =  VVPASO[7]/192 
         VVH50      = (VVSIMPLE*0.50) + VVSIMPLE
         IF VVH50 <>0
           VVPASO[11] = LIQUIDA->CANTIDAD/VVH50
         ENDIF
         VVH50      = 0   
      ENDIF   


      IF LIQUIDA->CONCEPTO = 23         
         VVH50      = 0
         VVSIMPLE   = 0
         VVSIMPLE   = VVPASO[7]/192 
         VVH50      = VVSIMPLE + VVSIMPLE
         VVPASO[11] = LIQUIDA->CANTIDAD/VVH50
         
       ENDIF   

      VVPASO[3] = VVHST
   ENDIF

  IF LIQUIDA->CONCEPTO = 20 
     VVPASO[4] = LIQUIDA->APORTE  
  ENDIF

   
   IF LIQUIDA->CONCEPTO = 121
      VVCUOTAMUTUAL = LIQUIDA->DESCUENTO 
   ENDIF        
           
   IF LIQUIDA->CONCEPTO = 125 .OR. LIQUIDA->CONCEPTO = 130
      VVNACION = LIQUIDA->DESCUENTO 
   ENDIF 

   IF LIQUIDA->CONCEPTO = 123
      VVMUTUAL = LIQUIDA->DESCUENTO 
   ENDIF   

   IF LIQUIDA->CONCEPTO = 126 .OR. LIQUIDA->CONCEPTO = 133 .OR. LIQUIDA->CONCEPTO = 142 .OR. LIQUIDA->CONCEPTO =150
      VVEMBARGO = LIQUIDA->DESCUENTO
   ENDIF   
   
   IF LIQUIDA->CONCEPTO = 127
      VVAJCREDMUTUAL=LIQUIDA->DESCUENTO   
   ENDIF   
        
   IF LIQUIDA->CONCEPTO = 128    
      VVAJCREDNACION = LIQUIDA->DESCUENTO
   ENDIF   
      
   IF LIQUIDA->CONCEPTO = 86   
      VVFAMI = LIQUIDA->CANTIDAD
   ENDIF  

   IF LIQUIDA->DESCUENTO # 0 
      VVRET = VVRET+ LIQUIDA->DESCUENTO   
   ENDIF   
   
   IF LIQUIDA->VALORUNI<> 0
      VVPAGO = 1
   ENDIF
   
   IF LIQUIDA->CONCEPTO = 58
      VVPASO[6]= LIQUIDA->SINAPORTE
        
   ENDIF   
    

   IF LIQUIDA->CONCEPTO = 136 
      VVPASO[1] = LIQUIDA->SINAPORTE
   ENDIF   

   IF LIQUIDA->CONCEPTO = 22
      VVPASO[5] = LIQUIDA->CANTIDAD
   ENDIF   

   IF LIQUIDA->CONCEPTO = 1   
      VVPASO[7] = LIQUIDA->APORTE 
   ENDIF 

   *IF LIQUIDA->CONCEPTO = 63  
   *   VVPASO[8] = LIQUIDA->SINAPORTE  
   *ENDIF

   IF LIQUIDA->CONCEPTO = 4
      VVPASO[9] = LIQUIDA->APORTE
   ENDIF   

   IF LIQUIDA->CONCEPTO = 3
      VVPASO[10] = LIQUIDA->APORTE 
   ENDIF

   IF LIQUIDA->CONCEPTO = 30  
      VVPASO[12] = LIQUIDA->APORTE
   ENDIF

   SKIP
   IF LIQUIDA->LEGAJO # VVLEG    
      DO RPZLO WITH VVBRUTO,VVIATICO,VVADEL,VVRET,VVLEG,VVSAL,VVNACION,VVMUTUAL,VVPAGO,VVCUOTAMUTUAL,VVEMBARGO,VVAJCREDMUTUAL,VVAJCREDNACION,VVFAMI,VVCANTHIJ 
	  STORE 0 TO VVBRUTO,VVIATICO,VVNETO,VVADEL,VVNACION,VVSAL,VVRET,VVNACION,VVMUTUAL,VVPAGO     
      STORE 0 TO VVEMBARGO,VVAJCREDMUTUAL,VVAJCREDNACION,VVCUOTAMUTUAL,VVFAMI,VVCANTHIJ   
      FOR I= 1 TO 20
         VVPASO[I]= 0  
      NEXT
   ENDIF    
   VVLEG = LIQUIDA->LEGAJO     
   VVLIQ = LIQUIDA->LIQUIDA
ENDDO   
SELE SUE3
BROWSE
*DO EXPORTA WITH VVORIGINAL
*CLOSE TABLES
*DO EXPORTA3
RETURN






************************
PROCEDURE RPZLO
**********************
PARAMETERS VVBRUTO,VVIATICO,VVADEL,VVRET,VVLEG,VVSAL,VVNACION,VVMUTUAL,VVPAGO,VVCUOTAMUTUAL,VVEMBARGO,VVAJCREDMUTUAL,VVAJCREDNACION,VVFAMI,VVCANTHIJ  
VVTEMP = 0
VVTEMP = VVIATICO - VVSAL
VVIATICO = VVTEMP
NETO = 0
SELE PERSONAL
SEEK  STR(VVLEG,4)
VVTEMP = 0
VVTEMP = VVRET
VVRET  =  VVTEMP -(VVNACION+VVMUTUAL+VVADEL+VVEMBARGO) 
TRY
	SELE SUE3
	APPEND BLANK
	REPLACE CHAPA    WITH  VVLEG
	REPLACE NOMBRE   WITH  PERSONAL->NOMBRE
	REPLACE SBRUTO   WITH  VVBRUTO
	REPLACE SVIATICO WITH  VVIATICO
	REPLACE SADEL    WITH  VVADEL
	REPLACE BANCO    WITH  PERSONAL->DEPART
	REPLACE SNETO    WITH  ((VVBRUTO+VVIATICO+VVSAL)-VVRET)
	REPLACE SALARIOF WITH  VVSAL
	REPLACE SRETEN   WITH  VVRET
	REPLACE SNACION  WITH  VVNACION
	REPLACE SMUTUAL  WITH  VVMUTUAL
	REPLACE SNTECOB  WITH  (VVBRUTO + VVSAL+VVIATICO)-(VVRET+VVNACION+ VVMUTUAL+VVADEL+VVEMBARGO)
	REPLACE SECCION  WITH  PERSONAL->SECCION
	REPLACE BASICO   WITH  VVPASO[7]
CATCH TO xerror
    MESSAGEBOX("Error " + xerror.message,1,"Atención") 

ENDTRY	
IF PERSONAL->CUENTABANC # SPACE(15)
   REPLACE TARJETA WITH "BANELCO"
   REPLACE CUENTA  WITH  PERSONAL->CUENTABANC
ENDIF   
REPLACE SAC         WITH VVPASO[2]
REPLACE HORASEXTRA  WITH VVPASO[3]
REPLACE VACACIONES  WITH VVPASO[4]

IF VVPASO[5] <> 0
   REPLACE DIASTRA WITH  30 - VVPASO[5]
ELSE   
   REPLACE DIASTRA WITH 30
ENDIF


*IF PERSONAL->SECTOR = "CONDUCCION"
*   REPLACE TIKETS WITH(SBRUTO*0.20) 
*ENDIF

*IF PERSONAL->SECTOR = "MARKETING"
*   REPLACE TIKETS WITH (SBRUTO*0.10)
*ENDIF   

REPLACE DCTO1273 WITH VVPASO[1]

REPLACE AYUDA WITH VVPASO[6]

IF VVPAGO <> 0
   REPLACE BANCO   WITH "PAGADO"   
   REPLACE TARJETA WITH SPACE(7)        
   REPLACE CUENTA WITH SPACE(10)   
ENDIF   
REPLACE APOJUBI    WITH  VVPASO[14]
REPLACE APOPAMI    WITH  VVPASO[15]
REPLACE TOTALSU    WITH SNETO + TIKETS
REPLACE CREDITOMUT WITH VVMUTUAL
REPLACE CUOTAMUT   WITH VVCUOTAMUTUAL
REPLACE EMBARGO    WITH VVEMBARGO
REPLACE AJCRDMUTU  WITH VVAJCREDMUTUAL
REPLACE AJCRNAC    WITH VVAJCREDNACION  
REPLACE CUIL       WITH LTRIM(PASOCUIL(PERSONAL->CUIL))
IF FAMI = 0
   REPLACE FAMI WITH VVFAMI 
ENDIF
VHIJ = 0
VHIJ = SUMAHIJ(PERSONAL->LEGAJO)
REPLACE HIJOS       WITH VHIJ
VESPO = 0
VESPO = SUMAESPO(PERSONAL->LEGAJO)
REPLACE CONYUGE     WITH VESPO
IF PERSONAL->SITUARET = "2"
   REPLACE CODSITU     WITH "1"
ELSE   
   REPLACE CODSITU WITH PERSONAL->SITUARET
ENDIF   
REPLACE CONDICION   WITH PERSONAL->CONDCOD 
REPLACE ACTIVIDAD   WITH PERSONAL->CODIGOACTI
REPLACE ZONA        WITH PERSONAL->ZONAGEOGRA
REPLACE MODALIDAD   WITH PERSONAL->MCCDO
REPLACE CODOBRASO   WITH PERSONAL->DGIOBRASOC
REPLACE CODSINIEST  WITH VAL(PERSONAL->CODSINIEST) 
REPLACE LOCPROV     WITH PERSONAL->LOCALIDAD+' - '+PERSONAL->PROVINCIA
REPLACE CONVENCIO   WITH PERSONAL->CONVENCIO
REPLACE SNACION     WITH VVPASO[10]
IF CODSINIEST <> 0
   WAIT WINDOW "ATENCION REGISTRANDO CODIGO DE SINIESTRADO" + PERSONAL->NOMBRE   +   STR(CODSINIEST,1) 
ENDIF

IF PERSONAL->JUBILACION = 1
   REPLACE PTEADJUBI WITH 1
ENDIF   

IF .NOT. EMPTY(PERSONAL->FECHABAJA)
    vvdia = 0
    vvdia =  day(personal->fechabaja)
    *MESSAGE("ATENCION","EMPLEADO DE BAJA :" + PERSONAL->NOMBRE+ " " + DTOS(PERSONAL->FECHABAJA)+" " +str(vvdia,2) )
    REPLACE PERSONAL->SITUARET  WITH "1"
    REPLACE PERSONAL->DIANI1    WITH 1
    REPLACE DIASTRA WITH 30
    *REPLACE PERSONAL->SITUARET2 WITH " "     
    *REPLACE PERSONAL->DIANI2    WITH VVDIA
    *REPLACE PERSONAL->SITUARET3 WITH "1" 
ENDIF   



VVOBSOC = 0
VVOBSOC = (SBRUTO*CONTRB->OBRASOCIAL/100)


IF SBRUTO > 1000
   REPLACE ANSSAL   WITH (VVOBSOC*15)/100 
ELSE   
   REPLACE ANSSAL   WITH (VVOBSOC*10)/100
ENDIF   
VVBASICO = 0
VVBASICO = BASICO
REPLACE CONTASIGFA  WITH (SBRUTO*CONTRB->ASIGFAMILI)/100 
REPLACE CONTSINDIC  WITH (VVBASICO*2.5)/100
REPLACE CONTJUBILA  WITH (SBRUTO*CONTRB->JUBILACION)/100
REPLACE CONTPAMI    WITH (SBRUTO*CONTRB->INSSJP)/100
REPLACE FODODESEMP  WITH (SBRUTO*CONTRB->FDODESEMPL)/100



IF substr(personal->contrato,1,2) = "Ju"
    STORE 0 TO  VVA,VVBA 
    VVAP = (SBRUTO   * CONTRB->JUBILACION)/100  
    VVBA = (VVBASICO *0.025)
    REPLACE APORTE      WITH (VVAP+VVBA) 
    REPLACE CONTPAMI    WITH 0
    REPLACE FODODESEMP  WITH 0
    REPLACE ANSSAL      WITH 0
    REPLACE CONTASIGFA  WITH 0
    REPLACE CONTJUBILA  WITH (SBRUTO   * CONTRB->JUBILACION)/100
ENDIF
REPLACE ART WITH (((SBRUTO*ART->VARIABMASA)/100)+ (ART->TARIFAMENS))

IF PERSONAL->CATEGORIA = "DIRECTOR"
   REPLACE APORTE WITH 0
   REPLACE CONTPAMI    WITH 0
   REPLACE FODODESEMP  WITH 0
   REPLACE ANSSAL      WITH 0
   REPLACE CONTASIGFA  WITH 0
   REPLACE CONTJUBILA  WITH 0 
ENDIF   
STORE SPACE(2)TO VVSITU,VVST2,VVTUSI3
VVSITU  = PERSONAL->SITUARET
VVST2   = PERSONAL->SITUARET2
VVTUSI3 = PERSONAL->SITUARET3

REPLACE PERSONAL->SITUARET  WITH LTRIM(VVSITU)
REPLACE PERSONAL->SITUARET2 WITH LTRIM(VVST2)
REPLACE PERSONAL->SITUARET3 WITH LTRIM(VVTUSI3)
IF VVPASO[11] > 999
   WAIT WINDOW STR(VVPASO[11],16)
 *  REPLACE CANTHORAS  WITH VVPASO[11]/2
ELSE
   REPLACE CANTHORAS WITH VVPASO[11] 
ENDIF   
VVAPORTE  = 0
VVCONTRI  = 0
if CODOBRASO <> "000000"
      calcuob1(vvaporte)    
      calcuob2(vvcontri)              
ENDIF

REPLACE APOBRASOC  WITH VVAPORTE    
REPLACE CONTBRASOC WITH VVCONTRI  
REPLACE PREMIOS    WITH VVPASO[12]
REPLACE DESCUDI    WITH VVPASO[9]
SELE LIQUIDA

RETURN






       
       
       
       
       
       
       
       
       
       
******************
PROCEDURE EXPORTA
******************       
PARAMETERS VVORIGINAL
SELECT SUE3
*browse
*SET FILTER TO CHAPA = 1
*BROWSE FIELDS NOMBRE,CUIL,PREMIOS,HORASEXTRA,CANTHORAS,SBRUTO 
SET DEVICE TO SCREEN
DELETE FILE "C:\SUERUT\EMPRE1\DGI.TXT"
SET DEVICE TO FILE "C:\SUERUT\EMPRE1\DGI.TXT"
*SET DEVICE TO PRINT
*SET PRINT TO C:\SUERUT\EMPRE1\DGI.TXT




VVBAS  = 0
LIN = 0
LIN = 0
SELE SUE3
GO TOP
DO WHILE .NOT. EOF()
  @LIN,  0  SAY CUIL PICTURE "99999999999"
  *                                 123456798-123456789-123456789       
  @LIN, 11  SAY NOMBRE     PICTURE "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" 
  @LIN, 41  SAY CONYUGE    PICTURE "9"
  @LIN, 42  SAY "0"
  @LIN, 43  SAY HIJOS      PICTURE "9"
  @LIN, 44  SAY "0"  
  @LIN, 45  SAY CODSITU   PICTURE "!"
  @LIN, 46  SAY "0"
 
  @LIN, 47  SAY CONDICION PICTURE "!"
  @LIN, 48  SAY ACTIVIDAD PICTURE "!!"
  @LIN, 50  SAY ZONA      PICTURE "!!"
  @LIN,52   SAY "00000"
  @LIN, 57  SAY LTRIM(MODALIDAD) PICTURE "!!!" 
  @LIN, 60  SAY CODOBRASO PICTURE "!!!!!!"
  @LIN, 66  SAY "0"  
  @LIN, 67  SAY  FAMI      PICTURE "9"
  VVTOT = 0
  VVTOT = SVIATICO + SBRUTO
  @LIN,68   SAY VVTOT     PICTURE "999999.99"
  @LIN,77   SAY SBRUTO    PICTURE "999999.99"
  @LIN,86   SAY SALARIOF  PICTURE "999999.99"
  @LIN,95   SAY '000000000'
  *VVAPOR= 0
  *VVAPOR= (SBRUTO*1/100)
  *DO CASE
  *   CASE  VVAPOR > 10
  *         @LIN,104  SAY '0000'
  *         @LIN,108  SAY  VVAPOR PICTURE "99.99" 
  *   CASE VVAPOR < 10
  *         @LIN,104  SAY '00000' 
  *         @LIN,109  SAY  VVAPOR PICTURE "9.99" 
  *   CASE VVAPOR = 0     
  *         @LIN,104 SAY "000000.00"
  *ENDCASE
  @LIN,104  SAY  "000000.00"
  @LIN,113  SAY '000000000'
  @LIN,122  SAY '000000200'   
 *@LIN,122  SAY '000000000'
  @LIN,131  SAY LOCPROV   PICTURE '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
  @LIN,181  SAY SBRUTO PICTURE "999999.99"
  @LIN,190  SAY SBRUTO PICTURE "999999.99"
  @LIN,199  SAY SBRUTO PICTURE "999999.99"
  @LIN,208  SAY CODSINIEST PICTURE "9"  
  @LIN,220  SAY "4"
  *-----------------------------> TIPO EMPLEADOR
  *@LIN,220  SAY "4"
  * INCISO A =  4 
  * INCISO B  = 6//4
  * APORTE ADICIONAL OBRA SOCIAL
  *              123456789  
  @LIN,221  SAY "000000000"
 * IF PTEADJUBI = 1
  @LIN,230  SAY "1"  
 * ELSE
  *   @LIN,230   SAY "0"
  *ENDIF
  SELE PERSONAL
  SEEK STR(SUE3->CHAPA,4)
  IF FOUND()  
    *SITUACION REVISTA 1
    @LIN,231 SAY  PERSONAL->SITUARET PICTURE "!!"
    *DIA DE INICIO SITUACION DE REVISTA1
    @LIN,233 SAY  PERSONAL->DIANI1  PICTURE "99"   
    *SITUACION REVISTA 2
    @LIN,235 SAY  PERSONAL->SITUARET2 PICTURE "!!"
    * DIA DE INICIO SITUACION DE REVISTA2
    @LIN,237 SAY PERSONAL->DIANI2   PICTURE "99"
    * SITUACION REVISTA 3
    @LIN,239 SAY  PERSONAL->SITUARET3 PICTURE "!!" 
    * DIA DE INICIO SITUACION DE REVISTA 6
    @LIN,241 SAY PERSONAL->DIANI3 PICTURE "99"
    *SUELDO MAS ADICIONALES
  ENDIF
  SELE SUE3
  VVSADI = 0
  VVSADI = SBRUTO - (SAC+HORASEXTRA+VACACIONES+PREMIOS)
  VVBAS  = SAC+HORASEXTRA+BASICO+VACACIONES+PREMIOS
  
  IF VVBAS  > SBRUTO .OR. BASICO > SBRUTO .OR. DESCUDI <>0 
     VVBAS =  VVSADI 
  ELSE   
     IF VVBAS < 0
        VVBAS = 0
     ENDIF  
      VVBAS = BASICO
  ENDIF
  
  *   
  *VER TEMA                             123456789  
  
  @LIN,243 SAY  VVBAS  PICTURE "999999.99"
    * SAC
  @LIN,252 SAY SAC        PICTURE "999999.99"  
  * HORAS EXTRAS
  @LIN,261 SAY HORASEXTRA PICTURE "999999.99" 
  * ZONA DESFAVORABLE
  @LIN,270  SAY "000000000"
  * VACACIONES
  @LIN,279 SAY VACACIONES  PICTURE "999999.99"
  * CANTIDAD DE DIAS TRABAJADOS
  *             123456789  
  * @LIN,288 SAY "000000030"
  @LIN,288 SAY DIASTRA PICTURE "99"
  * REMUNERACION IMPONIBLE 5
  *                      123456789
  @LIN,297 SAY SUE3->SBRUTO PICTURE "999999.99" 
  * TRABAJADOR CONVENCIONADO 
  @LIN,306 SAY CONVENCIO PICTURE "!"
  @LIN,307 SAY "000000000"
  @LIN,316 SAY VVORIGINAL PICTURE "9" 
  VVADICIO = 0
    
  VVADICIO = SUE3->SBRUTO  -(SUE3->HORASEXTRA +SUE3->SAC+SUE3->VACACIONES+VVBAS+SUE3->PREMIOS)
  IF VVADICIO < 0
     VVADICIO = 0
     VVADICIO = SUE3->SBRUTO       
  ENDIF   
  
  
  *                              123456789   
  @LIN,317 SAY VVADICIO            PICTURE "999999.99"
  @LIN,326 SAY SUE3->PREMIOS       PICTURE "999999.99"
  *@LIN,335 SAY  "000000000"
  *
  @LIN,335 SAY SUE3->SBRUTO 	   PICTURE "999999.99"
  * remuneración imponible 7 Régimenes especiales (Docentes,etc.)
  @LIN,344 SAY  "000000000"
  @LIN,353 SAY SUE3->CANTHORAS     PICTURE "999"
  @LIN,356 SAY SUE3->SVIATICO 	   PICTURE "999999.99"
  @LIN,365 SAY "000000000"
  @LIN,374 SAY "000000000" 
  @LIN,383 SAY SUE3->SBRUTO 	   PICTURE "999999.99"
  @LIN,392 SAY "000000.00"
  @LIN,401 SAY "000"
  @LIN,404 SAY "1"  
 LIN = LIN + 1
  SKIP
ENDDO  
SET PRINTER OFF
SET DEVICE TO SCREEN
SET SAFETY OFF
*FCLOSE("C:\SUERUT\EMPRE1\DGI.TXT")

MODIFY FILE C:\SUERUT\EMPRE1\DGI.TXT
*!EDIT C:\SUERUT\EMPRE1\DGI.TXT

RETURN


*******************************
PROCEDURE EXPORTA3
*****************************+

s = CREATEOBJECT("sicoss")

RETURN










































































