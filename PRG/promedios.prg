SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET EXCLUSIVE OFF
SET DELETED ON
CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
x.Seteopat(2)
SET CLASSLIB TO rh 

LOCAL VarMes,VarLeg 

VarMes = 10
Varleg = 255

*CREATE CURSOR MESPROM(N,10,2),NOM(C,12)
TOTAL = 0
FOR I =1 TO 6
    arch = STR(VarMes,2) + "2019"
    
    VarMes = VarMes -1
    SELECT SUM(IIF(concepto = 199 .or. concepto =18,0,aporte)) as su FROM &arch WHERE legajo = VarLeg;
    INTO CURSOR sutemp
    ? arch +" "+ STR(sutemp.su,10,2)
    TOTAL = total+ sutemp.su
NEXT
?"Total......:" + STR(total,12,2)
?"Promedio...:" + STR(Total/6,12,2)