SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET EXCLUSIVE OFF
SET DELETED ON
CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
x.Seteopat(2)
SET CLASSLIB TO rh 

LOCAL VarMes,VarLeg 
clear
VarMes = 4
Varleg = 250

*CREATE CURSOR MESPROM(N,10,2),NOM(C,12)
TOTAL = 0
LOCAL VarPaso , Varmes
************
Varmes = 3
************** 
VarPaso = 0
FOR I =1 TO 6
    IF I > 3
       IF Varpaso = 0
          Varmes = 12
          VarPaso = 1
        Endif   
        arch = STR(VarMes,2) + "2019"
        VarMes = VarMes -1
    ELSE
        
        arch = STR(VarMes,2) + "2020"  
        VarMes = VarMes -1
    ENDIF  
    SELECT SUM(IIF(concepto = 199 .or. concepto =18 .or. concepto =1 .or.concepto = 304 .or. concepto = 204,0,aporte)) as su FROM &arch WHERE legajo = VarLeg;
    INTO CURSOR sutemp
    ? arch +" "+ STR(sutemp.su,10,2)
    TOTAL = total+ sutemp.su
NEXT
?"Total......:" + STR(total,12,2)
?"Promedio...:" + STR(Total/6,12,2)
?"Valor Hora :" + STR( (total/6)/200,12,2)
