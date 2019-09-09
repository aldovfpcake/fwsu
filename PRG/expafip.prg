
SET PROCEDURE TO c:\fwsu\prg\clasesicoss
fso = CreateObject('Scripting.FileSystemObject')
tf = fso.CreateTextFile('c:\testfile2.txt', .t.)
s= CREATEOBJECT("sicoss")
SELECT sue3
SCAN 
s.cuil = cuil
s.setnombre(nombre)
s.conyuge   = STR(conyuge,1)
s.hijos     = "0"+STR(hijos,1)
s.SetCondicion(CONDICION)
s.Setactividad(ACTIVIDAD)

  ?"0"+ alltrim(codsitu)
  ?codsitu
  
 IF LEN(ALLTRIM(modalidad))=1 
        VarModalidad = "00"+ALLTRIM(modalidad)
 ENDIF       
 IF LEN(ALLTRIM(modalidad))=2
        VarModalidad = "0"+ALLTRIM(modalidad)
 ENDIF 
 excedentesaportes = "002000,00"
 excedentesobrasoc = "000000,00" 
 provincialocalidad = ""
 aporteadicionalobrs="000000.00"
 vvsadi = 0
  vvsadi = sbruto - (sac+horasextra+vacaciones+premios)
  vvbas  = sac+horasextra+basico+vacaciones+premios
  
  if vvbas  > sbruto .or. basico > sbruto .or. descudi <>0 
     vvbas =  vvsadi 
  else   
     if vvbas < 0
        vvbas = 0
     endif  
      vvbas = basico
  ENDIF
  vvadicio = 0
    
  vvadicio = sue3->sbruto  -(sue3->horasextra +sue3->sac+sue3->vacaciones+vvbas+sue3->premios)
  if vvadicio < 0
     vvadicio = 0
     vvadicio = sue3->sbruto       
  endif   
  vvoriginal=1
 SELECT situaret,situaret2,situaret3,diani1,diani2,diani3 FROM personal WHERE sue3.chapa = legajo INTO CURSOR tablaper
 SELECT sue3
  linea = ALLTRIM(s.cuil)+s.nombre+s.conyuge+s.hijos+"0"+ALLTRIM(codsitu)+"0"+ALLTRIM(condicion)+"0"+ALLTRIM(actividad)+zona+"00,00"+varmodalidad+CODOBRASO;
  +"0"+STR(fami,1)+str(sviatico+sbruto,12,2)+STr(sbruto,12,2)+"000000,00"+"000000,00"+"000000,00"+excedentesaportes+excedentesobrasoc+LOCPROV+STr(sbruto,12,2);
  + STr(sbruto,12,2)+STr(sbruto,12,2)+"0"+STR(CODSINIEST,1)+"0"+"000000.00"+"1"+aporteadicionalobrs+"1"+PADL(ALLTRIM(tablaper.situaret),2,"00")+PADL(ALLTRIM(STR(TABLAPER.diani1,2)),2,"00");
  +PADL(ALLTRIM(tablaper.situaret2),2,"00")+PADL(ALLTRIM(STR(TABLAPER.diani2,2)),2,"00")+PADL(ALLTRIM(tablaper.situaret3),2,"00")+PADL(ALLTRIM(STR(TABLAPER.diani3,2)),2,"00")+STR(vvbas,12,2)+STR(sac,12,2)+;
  STR(HORASEXTRA,12,2)+"000000000.00"+STR(VACACIONES,12,2)+TRANSFORM(diastra,"999999999")+ +STR(sbruto,12,2)+convencio+"000000000.00"+STR(VVORIGINAL,1)+STR(vvadicio,12,2);
  +STR(premios,12,2)+STr(sbruto,12,2)+"000000000.00"+TRANSFORM(CANTHORAS,"999")+STR(SVIATICO,12,2)+"000000000.00"+"000000.00"+STR(sbruto,12,2);
  +"000000.00"+"000"+"T"+"000000000.00"
                                                                                                                      
                                                                                                                   
  tf.WriteLine(linea)

ENDSCAN

tf.close