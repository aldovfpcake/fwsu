SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
SET CLASSLIB TO C:\FWSU\CLASES\RH
SET EXCLUSIVE OFF
SET DELETED ON
*CLOSE TABLES all
*SET PATH TO c:\suerut\empre1
* 750 pedraza pablo
*
x=CREATEOBJECT('configurar')
x.Seteopat(1)
*borrar()
*ver()

USE f:\sueldos\empre1\sueldosfijos again
SCAN

    DO lq-autom-liquida-sac
    SELECT sueldosfijos
     
ENDSCAN