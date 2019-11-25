SET PATH TO F:\SUELDOS\EMPRE1
SET DELETED ON
SET EXCLUSIVE OFF  
SET CLASSLIB TO c:\fwsu\clases\rh
PUBLIC xs as Object
PUBLIC MESES[6],VardiasVac,VarPromedio,Vartotal

VVARCHI = " "
DO WHILE EMPTY(VVARCHI)
   VVARCHI = INPUTBOX("Ingrese legajo)","Ingrese",VVARCHI,5600)
ENDDO

Varlegajo = VAL(VVARCHI)



VVARCHI = " "
DO WHILE EMPTY(VVARCHI)
   VVARCHI = INPUTBOX("Ingrese dias de vacaciones","Ingrese",VVARCHI,5600)
ENDDO
MESES[1] = "MARZO"
MESES[2] = "ABRIL"
MESES[3] = "MAYO"
MESES[4] = "JUNIO"
MESES[5] = "JULIO"
MESES[6] = "AGOSTO"
xs =  CREATEOBJECT("detalleliqvac",Varlegajo,1)
VardiasVac = VAL(VVARCHI)
Vartotal    = informe.s3+  informe.s4 + informe.s5+ informe.s6+ informe.s7+informe.s8
VarPromedio = ROUND((informe.s3+ informe.s4+ informe.s5+ informe.s6+ informe.s7+informe.s8)/6,2)
MODIFY REPORT detallevac
REPORT FORM detallevac NOCONSOLE  PREVIEW 
RELEASE MESES,VardiasVac,Vartotal,VarPromedio
*CLOSE TABLES ALL
