SET PATH TO F:\SUELDOS\EMPRE1
SET DELETED ON
SELECT LEGAJO,CANTIDAD FROM 32016 WHERE CONCEPTO = 20 INTO CURSOR VAC
VARMES = 3
VARANO = 2016

SCAN
      SELECT LEGAJO FROM COMENTS WHERE LEGAJO = VAC.LEGAJO .AND. MES = VARMES .AND. ANO = VARANO;
      INTO CURSOR EXISTE
      ? STR(LEGAJO,4)
      IF EOF()    
         INSERT INTO COMENTS(MES,ANO,LEGAJO,COMENTS) VALUES (VARMES,VARANO,VAC.LEGAJO,"LIQ.DE VACACIONES")
      ENDIF     

      SELECT VAC  
ENDSCAN