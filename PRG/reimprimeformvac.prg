
SET DATE ITALIAN
SET PATH TO C:\FWSU\FORMS;C:\FWSU\PRG;C:\FWSU\CLASES;F:\SUELDOS\EMPRE1;F:\SUELDOS
SET CENTURY ON
SET EXCLUSIVE OFF
*SET PRINTER TO NAME GETPRINTER()

VVARCHI = " "
DO WHILE EMPTY(VVARCHI)
   VVARCHI = INPUTBOX("Ingrese legajo)","Ingrese",VVARCHI,5600)
ENDDO

Varlegajo = VAL(VVARCHI)

SELECT legajo,nombre,documento FROM personal WHERE legajo = Varlegajo INTO CURSOR lper
SELECT vacaci.legajo,vacaci.desde, vacaci.hasta,vacaci.dias,vacaci.ano FROM vacaci WHERE legajo = Varlegajo .and. ano = 2018 INTO CURSOR lvc
SELECT l.legajo,l.nombre,l.documento,s.desde,s.hasta,s.dias,s.ano FROM lper l INNER JOIN lvc s ON l.legajo = s.legajo;
into CURSOR vacaciones
*DO FOXYPREVIEWER.APP 
FOR i = 1 TO 2
REPORT FORM FORMVAC TO PRINTER
NEXT 
