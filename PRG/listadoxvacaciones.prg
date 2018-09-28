SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET CLASSLIB TO C:\FWSU\CLASES\RH
SET EXCLUSIVE OFF
SET DELETED ON
*CLOSE TABLES all
*SET PATH TO c:\suerut\empre1

x=CREATEOBJECT('configurar')
rh = CREATEOBJECT('legajoper')
x.Seteopat(1)
SELECT legajo,nombre,fechaing,antigant,rh.calcuant(CTOD('31-12-2018'),fechaing) as antg,;
antd(rh.calcuant(CTOD('31-12-2018'),fechaing),antigant),;
rh.calcuvac(antd(rh.calcuant(CTOD('31-12-2018'),fechaing),antigant));
FROM personal WHERE activo = "A" INTO CURSOR listap
 BROWSE
 
 
 
 ***************
 FUNCTION antd
 *****************
 PARAMETERS ant,antd
 RETURN ant+antd