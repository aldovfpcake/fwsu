* prueba github
PARAMETERS vcon
*WAIT WINDOW "agrega desde aca" + STR(vpersolinea.legajo,3)
vlegajo    = vpersolinea.legajo
vconcepto  = vcon
vtipo      = _screen.ActiveForm.tipoliq
SELECT concepto FROM curliq INTO CURSOR extconp
SELECT curliq
INSERT INTO curliq(legajo,concepto,liquida) values(vlegajo,vconcepto,vtipo)
_screen.ActiveForm.grid1.column1.text1.Enabled = .T.
_screen.ActiveForm.grid1.column1.text1.readonly = .F.