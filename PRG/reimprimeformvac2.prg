SET DATE ITALIAN
SET CENTURY ON
SET PATH TO C:\FWSU\FORMS;C:\FWSU\PRG;C:\FWSU\CLASES;F:\EMPRE2;F:\
SET EXCLUSIVE OFF

VVARCHI = " "
DO WHILE EMPTY(VVARCHI)
   VVARCHI = INPUTBOX("Ingrese legajo)","Ingrese",VVARCHI,5600)
ENDDO

Varlegajo = VAL(VVARCHI)



*SELECT legajo,nombre,documento FROM personal WHERE legajo = Varlegajo INTO TABLE lper
*SELECT vacaci.legajo,vacaci.desde, vacaci.hasta,vacaci.dias,vacaci.ano FROM vacaci WHERE legajo = Varlegajo .and. ano = 2018 INTO CURSOR lvc
SELECT l.legajo,l.nombre,l.documento,l.cuil,s.desde,s.hasta,s.dias,s.ano FROM personal l INNER JOIN vacaci s ON l.legajo = Varlegajo AND s.legajo =Varlegajo  AND s.ano = 2019 into CURSOR vacaciones
DO FOXYPREVIEWER.APP 
REPORT FORM vacformu2 PREVIEW 
