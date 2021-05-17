SET PATH TO c:\fwsu\prg\classliq
SET PROCEDURE TO c:\fwsu\prg\classliq
ob = CREATEOBJECT("configurar")
SET SYSMENU TO
_Screen.caption = "Recursos Humanos"
ob.Seteo
ob.Seteopat(1)
_screen.Icon = 'C:\FWSU\PICTURES\074.ICO'
DO menu1.mpr
READ EVENTS