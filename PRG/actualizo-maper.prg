
SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET EXCLUSIVE OFF
SET DELETED ON
CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
x.Seteopat(1)
SET CLASSLIB TO rh 





vvleg = 831
update maper set concepto = 300;
       where concepto = 28;
       and legajo = vvleg and tipoliq = 3

update maper set concepto = 800;
       where concepto = 80 .or. concepto = 131 ;
       and legajo = vvleg and tipoliq = 3       

update maper set concepto = 810;
       where concepto = 81;
       and legajo = vvleg and tipoliq = 3              

update maper set concepto = 820;
       where concepto = 82;
       and legajo = vvleg and tipoliq = 3                     

update maper set concepto = 830;
       where concepto = 83;
       and legajo = vvleg and tipoliq = 3                            

update maper set concepto = 840;
       where concepto = 84;
       and legajo = vvleg and tipoliq = 3                                   