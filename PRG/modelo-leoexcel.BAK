LOCAL miExcel, lcConnstr, lcSQLCmd as String
LOCAL lnSuccess,lnSQLHand as Integer
LOCAL lcCursor as Cursor

miExcel= Getfile('xls, xlsx, xlsm, xlsb', 'Archivo:', 'Aceptar', 0, 'Seleccione una hoja de cálculo')
If Empty(miExcel)
	Return .F.
Endif

Local loExcel As Excel.Application
loExcel = Createobject("Excel.application")

m.loExcel.Workbooks.Open(miExcel)
m.loExcel.Sheets(1).Select

Local oSheet As Object, lcSheet As String
oSheet	= m.loExcel.ActiveSheet
lcSheet	= m.oSheet.Name

loExcel.DisplayAlerts = .F.
m.loExcel.Workbooks.Close()
m.loExcel.Quit()
loExcel = Null
Release m.oSheet, m.loExcel

lcConnstr = [Driver={Microsoft Excel Driver (*.xls)};DBQ=] + miExcel
lnSQLHand = Sqlstringconnect( m.lcConnstr )

lcSQLCmd  = [Select * FROM "] + m.lcSheet + [$"]
lnSuccess = SQLExec( m.lnSQLHand, m.lcSQLCmd, [xlResults] )

SQLDisconnect(m.lnSQLHand)

BROWSE TITLE ALIAS()
* ---> el alias del cursor final es xlResults
