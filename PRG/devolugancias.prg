SET DELETED ON
SET PATH TO F:\SUELDOS\EMPRE1
X= GETFILE()
USE (X)
GO TOP
SCAN
     IF SALDO > 0
         ? STR(LEGAJO,4)+ " "+NOMBRE+ " "+ STR(SALDO,12,2)
         INSERT INTO 72020 (legajo,concepto,descrip,sinaporte,liquida) values;
         (devolug.legajo,654,"Imp. A las Gan. ley 27549",devolug.saldo,5)
     ENDIF
     SELECT DEVOLUG

ENDSCAN