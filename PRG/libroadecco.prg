SET DATE ITALIAN
SET CENTURY ON
SET DELETED ON
PUBLIC PERIODO AS String
SET PATH TO c:\FWSU\FORMS;c:\FWSU\PRG;F:\SUELDOS\EMPRE1;F:\SUELDOS
OPEN DATABASE SUELDOS SHARED
PERIODO = "SETIEMBRE 2017"
REPLACE ALL FECHAING WITH CTOD("01-09-2017")
REPLACE ALL FECHAEGRESO WITH CTOD("30-09-2017")
REPORT FORM LIBROADECCO NOCONSOLE TO PRINTER PROMPT

