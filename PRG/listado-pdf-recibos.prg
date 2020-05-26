SET TALK OFF
SET PROCEDURE TO 
SET PROCEDURE TO c:\fwsu\prg\classliq
ob = CREATEOBJECT("configurar")
ob.Seteopat(2)
LOCAL chpas,i
DECLARE chpas [2]
chpas[1] = 247
chpas[2] = 248

FOR i=1 TO ALEN(chpas)
    DO imprereci WITH chpas[i]   

NEXT

return