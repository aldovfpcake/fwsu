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

*Varlegajo = VAL(VVARCHI)



*VVARCHI = " "
*DO WHILE EMPTY(VVARCHI)
*   VVARCHI = INPUTBOX("Ingrese dias de vacaciones","Ingrese",VVARCHI,5600)
*ENDDO
MESES[1] = "MAYO"
MESES[2] = "JUNIO"
MESES[3] = "JULIO"
MESES[4] = "AGOSTO"
MESES[5] = "SETIEMBRE"
MESES[6] = "OCTUBRE"
xs =  CREATEOBJECT("detalleliqvac",Varlegajo,1)
VarBasico = xs.basico
*VardiasVac = VAL(VVARCHI)
VardiasVac = VarCtdias
Vartotal    = informe.s5+  informe.s6 + informe.s7+ informe.s8+ informe.s9+informe.s10
VarPromedio = ROUND((informe.s5+  informe.s6 + informe.s7+ informe.s8+ informe.s9+informe.s10 )/6,2)
*MODIFY REPORT detallevac
DO FOXYPREVIEWER.APP
REPORT FORM detallevac TO print 
RELEASE MESES,VardiasVac,Vartotal,VarPromedio,VarBasico
*CLOSE TABLES ALL
