PARAMETER merror, mess, mess1, mprog, mlineno

DO FORM FORMERROR

CLEAR
? 'Error n�mero: ' + LTRIM(STR(merror))
? 'Mensaje de error: ' + mess
? 'L�nea de c�digo con error: ' + mess1
? 'N�mero de l�nea del error: ' + LTRIM(STR(mlineno))
? 'Programa con error: ' + mprog