SET TALK OFF
SET DELETED ON
SET PATH TO C:\SUERUT\EMPRE1
CREATE CURSOR sueldo (haber n(10,2),sinaporte n(10,2),descuento n(10,2),neto n(10,2),mes n(2),tipo n(2),ano n(4)) 
clear
varano = 0
varano = 2005
FOR I = 1 TO 11
    
 FOR x = 1 TO  12
    
   
    ?varano
    archivo = IIF(x<= 6, STR(x,1)+STR(varano,4),STR(x,2)+STR(varano,4))
    ?archivo
   IF FILE(archivo + '.dbf')
     SELECT SUM(aporte) as aporte ,SUM(sinaporte) as sinaporte, SUM(IIF(CONCEPTO <> 130,DESCUENTO,0))as descuento,liquida FROM &archivo WHERE legajo = 536 GROUP BY liquida INTO CURSOR liquida
     INSERT INTO sueldo(haber,sinaporte,descuento,neto,mes,tipo,ano) VALUES (liquida.aporte,liquida.sinaporte,liquida.descuento,(liquida.aporte + liquida.sinaporte - liquida.descuento),x,liquida.liquida,varano)
   ENDIF   
       
  NEXT
  varano = varano + 1
NEXT  
SELECT SUELDO
BROWSE