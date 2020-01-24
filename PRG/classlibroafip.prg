DEFINE CLASS LIBROAFIP AS Custom
        liquida = "102018"
        
		PROCEDURE init()
		   SET PROCEDURE TO C:\FWSU\prg\CLASSLIQ
		   x=CREATEOBJECT('configurar')
           x.Seteopat(1) 
           *lcTextFile = "C:\suerut\Libro-Sueldo-Digital-Afip\LSD_ARMADO TXT _Liquidaciones.xlsx"
           *oexcel = CREATEOBJECT("Excel.Application")
           **oexcel.workbooks.Open(lcTextFile,,.t.)
           *this.hoja2(oexcel)
           *this.fin(oexcel)
           this.linea3
            
		Endproc


        PROCEDURE hoja2
            PARAMETERS oexcel 
            SELECT sue3
            GO TOP
            GO 5
            cbu          = "1500010700006060242332"
            fechapago    ="20191101"
            acreditacion = "3"
            registro     = "02" 
            WITH oexcel.worksheets(2)
                 j=5
                SCAN WHILE j <= 18
                     cj       = ALLTRIM(STR(j, 10, 0))    
                    .range("B"+cj).value =  registro
                    .range("C"+cj).value =  sue3.cuil   
                    .range("F"+cj).value =  cbu
                    .range("H"+cj).value =  fechapago 
                    .range("J"+cj).value =  acreditacion
                     j= j+1
                ENDSCAN 
            ENDWITH 
        Endproc  
        
        
        PROCEDURE HOJA3
            PARAMETERS oexcel 
            SELECT sue3
            GO TOP
            GO 5
            registro = "03"
            WITH oexcel.worksheets(2)
                 j=5
                SCAN WHILE j <= 18
                     cj       = ALLTRIM(STR(j, 10, 0))    
                     this.cargocursor
                     
                    
                     j= j+1
                ENDSCAN 
         Endproc
        
        
         PROCEDURE CARGOCURSOR 
           CREATE CURSOR recibo(cuil c(12), concepto n(3),cantidad n(10),importe n(10,2),DBCR c(1))
           STORE 0 TO VarJub,VarPami,VarObraso,VarSind
           
           VarJub    = sue3,sbruto*0.11   
           VarPami   = sue3.sbruto*0.03 
           Varobraso = sue3.sbruto*0.03
           Varsind   = sue3.sbruto*0.03
                         
           INSERT INTO recibo (cuil,concepto,cantidad,importe,dbcr) VALUES(sue3.cuil,1,30,sue3.sbruto,"C")  
           INSERT INTO recibo (cuil,concepto,cantidad,importe,dbcr) VALUES(sue3.cuil,59,30,sue3.sinaporte,"C")
           INSERT INTO recibo (cuil,concepto,cantidad,importe,dbcr) VALUES(sue3.cuil,800,11,VarJub,"D")
           INSERT INTO recibo (cuil,concepto,cantidad,importe,dbcr) VALUES(sue3.cuil,810,11,VarPami,"D")
           INSERT INTO recibo (cuil,concepto,cantidad,importe,dbcr) VALUES(sue3.cuil,820,11,Varobraso,"D")
           INSERT INTO recibo (cuil,concepto,cantidad,importe,dbcr) VALUES(sue3.cuil,830,11,Varsind,"D")

         Endproc 

        PROCEDURE FIN
            PARAMETERS oexcel
            oexcel.visible = .T.
            RELEASE oexcel
        ENDPROC  

       PROCEDURE LINEA3   
           SET POINT TO " "
           Identificador = "03" 
           txtcuil          = SPACE(11)
           txtconcepto      = SPACE(10)
           txtcantidad      = SPACE(5)
           
           SELECT legajo,concepto,cantidad,aporte,sinaporte,descuento FROM  (this.liquida) WHERE legajo =4 ORDER BY concepto;
           INTO CURSOR recibo
           txtcuil = this.buscocuil(recibo.legajo)
          
            
           fso = CreateObject('Scripting.FileSystemObject')
           tf = fso.CreateTextFile('c:\testfile.txt', .t.)
           SELECT RECIBO
           SCAN
               
               txtconcepto   = ALLTRIM(STR(concepto,3))
               LargoConcepto = LEN(txtconcepto)
               LargoSpacios  = 10-largoConcepto
               txtconcepto   = txtconcepto +SPACE(largoSpacios)
               **************
               txtcantidad   = ALLTRIM(STR(cantidad,5))
               LargoConcepto = LEN(txtcantidad)
               LargoSpacios  = 5-largoConcepto
               txtcantidad   = txtcantidad +SPACE(largoSpacios)
               txtunidades   = SPACE(1) 
               txtdebitocred = SPACE(1)
               txtimporte    = SPACE(15)


               SET STEP ON 
               IF LargoConcepto = 2
                  txtcantidad   = RTRIM("0")+  ALLTRIM(txtcantidad)+"00"+txtunidades  
               ELSE
                  IF largoConcepto = 1
                     txtcantidad = "00000"   
                  ENDIF
               ENDIF             
               
               
               IF aporte <> 0
                  txtimporte = ALLTRIM(STRTRAN(STR(aporte,12,2),SPACE(1)))
                  txtdebitocred = "C"
               ENDIF
               
               IF sinaporte <> 0
                  txtimporte = ALLTRIM(STRTRAN(STR(sinaporte,12,2),SPACE(1)))
                  txtdebitocred = "C"
               ENDIF
               
               IF descuento <> 0
                  txtimporte = ALLTRIM(STRTRAN(STR(descuento,12,2),SPACE(1)))
                  txtdebitocred = "D"
               ENDIF
               
               txtlargo  = LEN(txtimporte)
               txtimporte  = REPLICATE("0",15-txtlargo) + txtimporte
               
               
               linea = " "
               linea = identificador + ALLTRIM(txtcuil)+txtconcepto+txtcantidad+txtunidades+txtimporte+ STR(LEN(txtimporte))
               tf.WriteLine(linea)
           ENDSCAN       
           
           tf.Close

     

       ENDPROC 
     
     
     
       
       
       FUNCTION buscocuil
          PARAMETERS VarLegajo
          SELECT cuil FROM personal WHERE legajo = VarLegajo INTO CURSOR bcuil
          N = " "
          I = 1
          DO WHILE  I< 15
             X = SUBSTR(bcuil.cuil,I,1) 
             IF X$"0123456789"
                N = N + X
             ENDIF     
             I = I + 1
          ENDDO   
        RETURN N 
       
       
       

ENDDEFINE




