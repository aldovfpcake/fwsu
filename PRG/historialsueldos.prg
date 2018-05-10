SET TALK OFF
SET DELETED ON
*SET PATH TO F:\SUELDOS\EMPRE1
SET PATH TO C:\SUERUT\EMPRE3
SET EXCLUSIVE OFF

CREATE CURSOR sueldo (haber n(10,2),sinaporte n(10,2),descuento n(10,2),neto n(10,2),km n(10,2),ctrol n(10,2),mes n(2),tipo n(2),ano n(4)) 
clear
varano = 0
*historial de sueldos a partir del año (varano)
varano = 2018 
vvlegajo = 15
clear

FOR I = 1 TO 11
    
 FOR x = 1 TO  12
    
   
    ?varano
    archivo = IIF(x<= 6, STR(x,1)+STR(varano,4),STR(x,2)+STR(varano,4))
    ?archivo
   IF FILE(archivo + '.dbf')
     SELECT SUM(aporte) as aporte ,SUM(sinaporte) as sinaporte,SUM(IIF(CONCEPTO =17 .OR. CONCEPTO = 23,APORTE,0))AS KM,SUM(IIF(CONCEPTO =14,APORTE,0))AS ctrld,;
     SUM(IIF(CONCEPTO =130 .OR. CONCEPTO =99,0,DESCUENTO))as descuento,liquida FROM &archivo WHERE legajo = vvlegajo .and. liquida =2 GROUP BY LIQUIDA INTO CURSOR liquida
   *  SELECT SUM(aporte) as aporte ,SUM(sinaporte) as sinaporte,SUM(IIF(CONCEPTO =17 .OR. CONCEPTO = 23,APORTE,0))AS KM,SUM(IIF(CONCEPTO =14,APORTE,0))AS ctrld,;
     SUM(DESCUENTO)as descuento,liquida FROM &archivo WHERE legajo = vvlegajo  GROUP BY LIQUIDA INTO CURSOR liquida
     
     
     
     *SELECT SUM(aporte) as aporte ,SUM(sinaporte) as sinaporte,SUM(IIF(CONCEPTO =31 .OR. CONCEPTO = 36,APORTE,0))AS KM,SUM(IIF(CONCEPTO =14,APORTE,0))AS ctrld,;
     SUM(DESCUENTO)as descuento,liquida FROM &archivo WHERE legajo = vvlegajo GROUP BY LIQUIDA INTO CURSOR liquida
     
     
     SELECT LIQUIDA
     INSERT INTO sueldo(haber,sinaporte,descuento,neto,km,ctrol,mes,tipo,ano) VALUES (liquida.aporte,liquida.sinaporte,liquida.descuento,(liquida.aporte + liquida.sinaporte - liquida.descuento),liquida.km,liquida.ctrld,x,liquida.liquida,varano)
  
   ENDIF   
       
  NEXT
  varano = varano + 1
NEXT  
SELECT SUELDO
BROWSE