SET deleted ON
SET PATH TO c:\suerut\demo
archivo = "c:\suerut\listados\sueldoschoferes"
USE &archivo ALIAS chf AGAIN
GO 6
LOCAL VarLegajo,Varconcepto,Vararchliq,VarCantidad,VarIndice
Vararchliq = "92020"

DIMENSION concept[15] 
concept[1] = 401
concept[2] = 403
concept[3]=  2
concept[4]=  242
concept[5]=  243
concept[6]=  244
concept[7]=  245
concept[8]=  8
concept[9]=  246
concept[10]= 31
concept[11]= 42 
concept[12]= 7
concept[13]=  35
concept[14]=  2000
concept[15]=  308



VarIndice = 6

clear
SELECT chf
SCAN
    Varlegajo    = VAL(EVALUATE(FIELD(1)))
 FOR I =1 TO 15
    SELECT chf
    VarCantidad  = VAL(EVALUATE(FIELD(VarIndice)))
    VarConcepto  = concept[I]
    ?Varlegajo
    ?VarConcepto
    IF VarCantidad <> 0
       SELECT concepto from &Vararchliq WHERE concepto = VarConcepto .and. legajo = Varlegajo .and. liquida = 3;
       INTO CURSOR existe
       IF _tally = 0
         INSERT INTO &Vararchliq (legajo,concepto,cantidad,liquida) VALUES (Varlegajo,Varconcepto,VarCantidad,3) 
        ? "Insertando ..:" + STR(Varlegajo,4) + " " + STR(VarConcepto,3) + " " + STR(VarCantidad) 
        
       ENDIF   
    ENDIF 
     VarIndice = VarIndice + 1
  NEXT
  SELECT chf 
  Varindice = 6
  I=1 
  
ENDSCAN
CLOSE TABLES ALL
OPEN DATABASE c:\suerut\demo\sueldos
SELECT 0
USE curliq nodata
SELECT 0
USE &archivo ALIAS chf AGAIN
SELECT chf
SCAN
    Varlegajo    = VAL(EVALUATE(FIELD(1)))
    SELECT curliq
    Vlegajo = Varlegajo
    Vliquida = 3
    REQUERY()
    DO  c:\fwsu\prg\liquidacion-automatica-demo WITH Varlegajo
    SELECT chf

ENDSCAN


