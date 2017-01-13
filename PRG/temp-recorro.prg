SELECT TOP 10 legajo FROM f:\sueldos\empre1\personal WHERE activo = "A" GROUP BY legajo ORDER BY legajo;
into CURSOR listadopersonal
 
SCAN
 IF USED("Curliq")
     SELECT Curliq
     USE
     WAIT WINDOW "paso"
 endif    
 SELECT listadopersonal
 do u:\fwsu\prg\lqautom WITH listadopersonal.legajo,10
 
 SELECT Curliq
 USE
 SELECT listadopersonal
endscan 