*CALCULO DE DIAS POR VACACIONES
SET PATH TO F:\SUELDOS\EMPRE1
SET CLASSLIB TO C:\FWSU\CLASES\rh
SET DATE ITALIAN
SET CENTURY ON

x = CREATEOBJECT("legajoper")
vfecha = CTOD("31-12-2017")
SELECT legajo,nombre,calc(fechaing) dias, (0*1) as sldo FROM personal WHERE activo = "A" ORDER BY LEGAJO INTO CURSOR lista readwrite;
X= SLDO()


*******************
FUNCTION calc
********************
PARAMETERS fechaing
dd = x.calcuant(vfecha,fechaing)
ctd = x.calcuvac(dd)
RETURN ctd

*******************
FUNCTION SLDO
******************
SELECT legajo,SUM(aporte) as sldo FROM 52017 GROUP BY legajo INTO CURSOR smay
browse
RETURN .T.
