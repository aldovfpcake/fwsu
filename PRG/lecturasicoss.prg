SET DATE ITALIAN
SET SYSFORMATS ON
SET DELETED ON
loFS = CREATEOBJECT("Scripting.FileSystemObject")
loFile= loFS.OpenTextFile("C:\suerut\presentacion\RUTA12SICOSS.TXT", 1)
CLEAR
borrar()
VarFchingreso = CTOD('01-04-2018')
VarFchegreso  = CTOD('30-04-2018')
*SET STEP ON 
DO WHILE NOT loFile.AtEndOfStream
  lcLine = loFile.ReadLine()
   VarContrato =SUBSTR(lcline,65,3)
   
   IF VarContrato = "102"
      ?SUBSTR(lcline,1,42) 
      VarCuil    = SUBSTR(lcline,1,11)
      VarNombre  = SUBSTR(lcline,12,30)
      VarSueldo  = SUBSTRC(lcline,880,8)
      VarDoc1    = SUBSTRC(VarCuil,3,8)
      
      * + " " + Nombre..:"+VarNombre + " "+ "Sueldo...:"+VarSueldo
      insertar()      
   ENDIF
  
  
ENDDO 	
loFile.Close()




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