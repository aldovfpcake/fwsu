SET DATE ITALIAN
SET SYSFORMATS ON
SET DELETED ON
loFS = CREATEOBJECT("Scripting.FileSystemObject")
loFile= loFS.OpenTextFile("C:\suerut\presentacion-2\ruta12.txt", 1)
CLEAR
borrar()
VarFchingreso = CTOD('01-02-2019')
VarFchegreso  = CTOD('28-02-2019')
*SET STEP ON 
Vartotal = 0
DO WHILE NOT loFile.AtEndOfStream
  lcLine = loFile.ReadLine()
   VarContrato  =SUBSTR(lcline,59,3)
   VarSinaporte =SUBSTR(lcline,74,6)
   ?Varsinaporte 
   Vartotal = Vartotal + VAL(VarSinaporte) 
   IF VarContrato = "102"
      ?SUBSTR(lcline,1,42) 
      VarCuil    = SUBSTR(lcline,1,11)
      VarNombre  = SUBSTR(lcline,12,30)
      VarSueldo  = SUBSTRC(lcline,264,6)
      VarDoc1    = SUBSTRC(VarCuil,3,8)
      
      * + " " + Nombre..:"+VarNombre + " "+ "Sueldo...:"+VarSueldo
      insertar()      
   ENDIF
  
  
ENDDO 	
loFile.Close()
?"Total"
?Vartotal



***********************
FUNCTION borrar()
*********************
DELETE FROM persoeventual



*********************
FUNCTION insertar()
*********************

?"Cuil....:"+ VarCuil +" " + "Nombre..:" + VarNombre + " "+ "Doc..:"+ VarDoc1 
      ? "Sueldo...:"+ VarSueldo
      ? VAL(VarSueldo)  
  VarImporte = VAL(VarSueldo)    
  INSERT INTO persoeventual (nombre,categoria,cuil,documento,fechaing,fechaegreso,remumera);
  values(VarNombre,'PEON',VarCuil,VarDoc1,VarFchingreso,VarFchegreso,VarImporte)
  
      
RETURN 0      