PARAMETERS vvarchi,Varlegajo,VarCtdias
SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET EXCLUSIVE OFF
SET DELETED ON
CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
x.Seteopat(1)
SET CLASSLIB TO rh 



PUBLIC xs as Object
PUBLIC MESES[6],VardiasVac,VarPromedio,Vartotal,VarBasico

VVARCHI = " "
*DO WHILE EMPTY(VVARCHI)
*   VVARCHI = INPUTBOX("Ingrese legajo)","Ingrese",VVARCHI,5600)
*ENDDO

*Varlegajo = 


*VVARCHI = " "
*DO WHILE EMPTY(VVARCHI)
*   VVARCHI = INPUTBOX("Ingrese dias de vacaciones","Ingrese",VVARCHI,5600)
*ENDDO
MESES[1] = "JULIO"
MESES[2] = "AGOSTO"
MESES[3] = "SETIEMBRE"
MESES[4] = "OCTUBRE"
MESES[5] = "NOVIEMBRE"
MESES[6] = "DICIEMBRE"
xs =  CREATEOBJECT("detalleliqvac",Varlegajo,1)
*VarBasico = xs.basico
VarBasico = 37799.11
*VardiasVac = VAL(VVARCHI)
VardiasVac = VarCtdias
Vartotal    = informe.s7+ informe.s8+ informe.s9+informe.s10+informe.s11+informe.s12
VarPromedio = ROUND(((informe.s7+ informe.s8+ informe.s9+informe.s10+informe.s11+informe.s12)/6),2)
*MODIFY REPORT detallevac
DO FOXYPREVIEWER.APP
REPORT FORM detallevac  TO PRINT
RELEASE MESES,VardiasVac,Vartotal,VarPromedio,VarBasico
*CLOSE TABLES ALL
