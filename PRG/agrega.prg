* prueba github
PARAMETERS vcon
*WAIT WINDOW "agrega desde aca" + STR(vpersolinea.legajo,3)
_screen.ActiveForm.grid1.column2.setfocus
vlegajo    = vpersolinea.legajo
vconcepto  = vcon
vtipo      = _screen.ActiveForm.tipoliq
SELECT concepto FROM curliq INTO CURSOR extconp
SELECT curliq
GO BOTTOM 
INSERT INTO curliq(legajo,concepto,liquida) values(vlegajo,vconcepto,vtipo)
_screen.ActiveForm.grid1.column1.text1.Enabled = .T.
_screen.ActiveForm.grid1.column1.text1.readonly = .F.