DEFINE CLASS excelafip as Custom



  PROCEDURE OPENLIBRO
    MiArchivoExcel = GETFILE()
	oExcel = CreateObject("Excel.Application")
	oExcel.Workbooks.Open(MiArchivoExcel)
	oExcel.sheets(2).Select
    oExcel.visible = .t.
  ENDPROC





ENDDEFINE
