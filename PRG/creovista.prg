X = FILETOSTR("T:\FWSU\PRG\CRVI.PRG")
CADBU = "12014"
CADREP = "B62014"
vi = STRTRAN(X,CADBU,CADREP)
STRTOFILE(vi,"T:\FWSU\PRG\CRVISD.PRG",0)
WAIT WINDOW "PROCESO TERMINADO"
MODIFY FILE "T:\FWSU\PRG\CRVISD.PRG"
* este procedimiento es para crear la vista de liquidacion de sueldo
* 1 se usa creovista que guarda  la vista en crvisd
* 2 se corre el progama crvisd 