Local lnFecFin As Number,  ;
	lnFecIni As Number,	   ;
	loAMD As Object

lnFecIni = Date(2000, 2, 20)
lnFecFin = Date(2017, 9,  5)

loAMD = DifAMD(m.lnFecIni, m.lnFecFin)

Messagebox( Textmerge("Antigüedad: <<loAMD.nAAAA>> años, <<loAMD.nMM>> meses, <<loAMD.nDD>> días"))
*
*--------------------------------------------------------------------------------------------------------
*
Function DifAMD(tdFec1, tdFec2 As Date) As Object

Local ldFec1 As Date,  ;
	ldFec2 As Date,	   ;
	ldUltFec As Date,  ;
	lnAAAA As Number,  ;
	lnDD As Number,	   ;
	lnMM As Number,	   ;
	loAMD As "Empty"

ldFec1 = Min(m.tdFec1, m.tdFec2)
ldFec2 = Max(m.tdFec1, m.tdFec2)
lnAAAA = 0
lnMM   = 0
lnDD   = 0

lnAAAA	 = Int((Val(Dtos(m.ldFec2)) - Val(Dtos(m.ldFec1))) / 10000)
ldFec1	 = Gomonth(m.ldFec1, 12 * m.lnAAAA)
ldUltFec = m.ldFec1

Do While m.ldFec2 > m.ldFec1
	ldUltFec = m.ldFec1
	ldFec1	 = Gomonth(m.ldFec1, 1)
	If m.ldFec1 <= m.ldFec2
		lnMM = m.lnMM + 1
	Endif
Enddo

lnDD = m.ldFec2 - m.ldUltFec
If m.lnDD >= m.ldFec2 - Gomonth(m.ldFec2, -1)
	lnDD = 0
Endif

loAMD = Createobject("Empty")
AddProperty(m.loAMD, "nAAAA", m.lnAAAA)
AddProperty(m.loAMD, "nMM", m.lnMM)
AddProperty(m.loAMD, "nDD", m.lnDD)

Return m.loAMD

Endfunc
