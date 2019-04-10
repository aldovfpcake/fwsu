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
MESES[1] = "ENERO"
MESES[2] = "FEBRERO"
MESES[3] = "SETIEMBRE"
MESES[4] = "OCTUBRE"
MESES[5] = "NOVIEMBRE"
MESES[6] = "DICIEMBRE"
xs =  CREATEOBJECT("detalleliqvac",Varlegajo,1)
VardiasVac = VAL(VVARCHI)
Vartotal    = informe2.s1+  informe2.s2 + informe.s9+ informe.s10+ informe.s11+informe.s12
VarPromedio = ROUND((informe2.s1+ informe2.s2+ informe.s9+ informe.s10+ informe.s11+informe.s12)/6,2)
*MODIFY REPORT detallevac
REPORT FORM detallevac NOCONSOLE  PREVIEW 
RELEASE MESES,VardiasVac,Vartotal,VarPromedio
*CLOSE TABLES ALL
