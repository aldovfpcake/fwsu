SET EXCLUSIVE OFF
SET DELETED ON
SET PATH TO F:\SUELDOS\EMPRE1;c:\CNWGA\FORMS
OPEN DATABASE f:\sueldos\nwga\datos\ganancias SHARED VALIDATE
***********************
WNUMES = 7
VVARCHIVO = "72020"    
sldo()
SELECT p.legajo,p.nombre,s.importe,sala.neto FROM personal p INNER JOIN saldo2019 s ON s.legajo = p.legajo;
INNER JOIN sala ON p.legajo = sala.legajo where p.depart <> "LA BOCA" AND p.activo = "A" ORDER BY p.legajo INTO CURSOR lista
LOCAL VarSaldo
VarSaldo = 0
SCAN FOR lista.importe <>0
  ? STR(lista.legajo,4)+ " "+ lista.nombre+ STR(lista.importe,16,2) + " "+ STR(lista.neto,12,2) + " " +STR(lista.neto*0.35)
  
  *VarSaldo = VarSaldo + lista.importe
  UPDATE nlegajo SET agosto = lista.importe WHERE empresa = 1 .and. ano =2020 .and. legajo = lista.legajo .and. concepto = 607

ENDSCAN
*? "Total.........:" + STR(VarSaldo,18,2)
*COPY TO C:\SUERUT\LISTADOS\devgan-2019.xls TYPE XLS

CLOSE TABLES all
RETURN



**********************
FUNCTION sldo
********************


SELECT LEGAJO,SUM(APORTE) + SUM(SINAPORTE) - SUM(DESCUENTO) AS NETO  FROM &VVARCHIVO  WHERE LIQUIDA = 3; 
GROUP BY LEGAJO INTO CURSOR sala
RETURN 