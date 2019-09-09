*SET PATH TO T:\FWSU\PRG;F:\SUELDOS\EMPRE1
SET PROCEDURE TO C:\FWSU\PRG\CLASSLIQ
Obj = CREATEOBJECT('configurar')
Obj.SeteoPat(1)
arch = "82019"
liq = arch
X = FILETOSTR("C:\FWSU\PRG\CRVI.PRG")
********************
*ESTA CADENA QUEDA FIJA
CADBU = "12014"
************************
CADREP = liq
vi = STRTRAN(X,CADBU,CADREP)
STRTOFILE(vi,"C:\FWSU\PRG\CRVISD.PRG",0)
WAIT WINDOW "PROCESO TERMINADO"
*MODIFY FILE "T:\FWSU\PRG\CRVISD.PRG"
*SET STEP ON 
DO CRVISD WITH liq
* este procedimiento es para crear la vista de liquidacion de sueldo
* 1 se usa creovista que guarda  la vista en crvisd
* 2 se corre el progama crvisd * prueba de segundo commit