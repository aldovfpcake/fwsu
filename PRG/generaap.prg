SET PROCEDURE TO c:\fwsu\prg\classliq
ob = CREATEOBJECT("configurar")
ob.Seteopat(1)

*BUILD EXE  "t:\fwsu\prg\lq" FROM "t:\fwsu\prg\lq.pjx"
BUILD APP "c:\fwsu\prg\lq" FROM "c:\fwsu\prg\lq2.pjx"
BUILD EXE  "C:\fwsu\prg\lq" FROM "c:\fwsu\prg\lq2.pjx"