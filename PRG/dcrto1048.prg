SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET EXCLUSIVE OFF
SET DELETED ON
CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
x=CREATEOBJECT('configurar')
x.Seteopat(1)
SET CLASSLIB TO rh 
ms = 1
an = 2019
op= CREATEOBJECT('abretabla')
op.optabla(ms,an)
SELECT legajo,nombre,categoria FROM personal WHERE activo = "A" .and. ALLTRIM(categoria) <> "DIRECTOR" .and. legajo <> 19;
into cursor lista

SCAN
   INSERT INTO 12019 (legajo,concepto,liquida,descrip,sinaporte) values(lista.legajo,448,1,"DECRT. 1048/18 CTA 2",2500)
  
ENDSCAN

WAIT WINDOW "Proceso Terminado"