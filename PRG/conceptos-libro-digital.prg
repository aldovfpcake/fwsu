SET EXCLUSIVE OFF
OPEN DATABASE k:\lsafip\lsafip.dbc SHARED
VVARCHI = " "

DO WHILE EMPTY(VVARCHI)
   VVARCHI = INPUTBOX("Ingrese Concepto a Actualizar","Ingrese",VVARCHI,5600)
ENDDO


VarCODIGOAFIP =110000
VarIDCONCAFIP  = "1"
VarCODIGO = INT(VAL(VVARCHI))
 UPDATE concuser SET IDCONCAFIP=VarIDCONCAFIP,CODIGOAFIP=VarCODIGOAFIP,;
 A_SIPA   = .T.,;
 C_SIPA   = .T.,;
 A_INSSJYP= .T.,;
 C_INSSJYP= .T.,;
 A_OSOCIAL= .T.,;
 C_OSOCIAL= .T.,;
 A_ANSSAL=  .T.,;
 C_ANSSAL=  .T.,;
 C_ASIGFAM= .T.,;
 C_FNE= .T.,;
 C_RIESGOS= .T.;
 WHERE CODIGO = VarCODIGO
 
  IF _tally = 1
    WAIT WINDOW "Actualización exitosa"
  ELSE
    WAIT WINDOW "ERROR"
  ENDIF    