SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET CLASSLIB TO C:\FWSU\CLASES\RH
SET EXCLUSIVE OFF
SET DELETED ON
*CLOSE TABLES all
*SET PATH TO c:\suerut\empre1

x=CREATEOBJECT('configurar')
rh = CREATEOBJECT('legajoper')
x.Seteopat(1)
SELECT legajo,nombre,fechaing,antigant,depart,rh.calcuant(CTOD('31-12-2019'),fechaing) as antg,;
antd(rh.calcuant(CTOD('31-12-2018'),fechaing),antigant),;
rh.calcuvac(antd(rh.calcuant(CTOD('31-12-2019'),fechaing),antigant)),(legajo/0) as valorva;
FROM personal WHERE activo = "A" INTO CURSOR listap readwrite
 BROWSE
 
 
 
 ***************
 FUNCTION antd
 *****************
 PARAMETERS ant,antd
 RETURN ant+antd