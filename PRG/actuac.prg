SET PATH TO F:\SUELDOS\EMPRE1
SET DELETED ON
SELECT LEGAJO,CANTIDAD FROM 42016 WHERE CONCEPTO = 20 INTO CURSOR VAC
VARMES = 5
VARANO = 2016
clear
SCAN
      SELECT LEGAJO,COMENTS FROM COMENTS WHERE LEGAJO = VAC.LEGAJO .AND. MES = VARMES .AND. ANO = VARANO;
      INTO CURSOR EXISTE
      ? STR(LEGAJO,4)
      STROMG = "VAC LIQUIDADAS" + STR(VARMES,2) + " CANTIDAD" + STR(VAC.CANTIDAD,2)
      IF EOF()    
         INSERT INTO COMENTS(MES,ANO,LEGAJO,COMENTS) VALUES (VARMES,VARANO,VAC.LEGAJO,STROMG)
      ELSE
         
         VarStrexiste = existe.coments
         VarStrexiste= VarStrexiste + "-" + STROMG
         UPDATE coments SET coments = VarStrexiste WHERE ano= varano .and. mes = varmes .and. legajo = vac.legajo
                 
       
      ENDIF     

      SELECT VAC  
ENDSCAN