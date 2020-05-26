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
MESES[2] = "FEBRERO"
MESES[3] = "ENERO"
MESES[4] = "DICIEMBRE"
MESES[5] = "NOVIEMBRE"
MESES[6] = "OCTUBRE"
xs =  CREATEOBJECT("detalleliqvac",Varlegajo,1)
VardiasVac = VAL(VVARCHI)
Vartotal    = informe.s12+  informe.s11 + informe.s10+ informe2.s1+ informe2.s2+informe2.s3
VarPromedio = ROUND((informe.s12+  informe.s11 + informe.s10+ informe2.s1+ informe2.s2+informe2.s3)/6,2)
*MODIFY REPORT detallevac
DO FOXYPREVIEWER.APP
REPORT FORM detallevac NOCONSOLE  PREVIEW 
RELEASE MESES,VardiasVac,Vartotal,VarPromedio
*CLOSE TABLES ALL
