SET EXCLUSIVE OFF
SET DATE ITALIAN
SET CENTURY ON
*SET PATH TO F:\FOXPRO2\TACSAPRV.DAT
SET PATH TO F:\FOXPRO2\TRANSPRV.DAT
SELECT asiedet.date,asiedet.fecha,asiedet.cuenta,asiedet.debe,asiedet.haber,asiedet.nroasie,asiedet.secuen  FROM asiedet WHERE asiedet.cuenta = "211040100" .and. asiedet.fecha >= CTOD("01-05-2020") INTO CURSOR detalle
SELECT asiecab.fecha,asiecab.fecha,asiecab.descrip,detalle.debe,detalle.haber FROM asiecab INNER JOIN detalle ON asiecab.fecha = detalle.fecha AND asiecab.secuen = detalle.secuen INTO CURSOR mayor
BROWSE
COPY TO c:\suerut\listados\mayortacsa TYPE XLS 