
PARAMETERS importe
*SET STEP ON 
Charnum = STR(importe,10,2)
*?LEN (ALLTRIM(Charnum))
*?ALLTRIM(Charnum)

*WAIT WINDOW LEN(ALLTRIM(Charnum))
DO Case
   CASE LEN(ALLTRIM(Charnum))   = 10
        nume       = ALLTRIM("0"+ ALLTRIM(Charnum))   


   CASE LEN(ALLTRIM(Charnum))   = 9
        nume = ALLTRIM( "00" + ALLTRIM(Charnum))     
   
   CASE LEN(ALLTRIM(Charnum))   = 7
        nume       = ALLTRIM("0000" + ALLTRIM(Charnum))
 

   CASE LEN(ALLTRIM(Charnum))   = 6
        nume = ALLTRIM("00000" +ALLTRIM(Charnum))
        CadMiles   = ALLTRIM("0000" +ALLTRIM(Charnum)) 
        CadMiles   = SUBSTR(CadMiles,1,7)
   CASE LEN(ALLTRIM(Charnum))   = 8
        nume = ALLTRIM("000" + ALLTRIM(Charnum))

   CASE LEN(ALLTRIM(Charnum))   = 5
        CadMiles   = " "
        CadMiles   = ALLTRIM("000000" + ALLTRIM(Charnum))
        nume       = ALLTRIM("000000" + ALLTRIM(Charnum))
        CadMiles   = SUBSTR(CadMiles,1,7)
   
   CASE LEN(ALLTRIM(Charnum))   = 4
        CadMiles   = " "
        CadMiles   = ALLTRIM("0000000" + ALLTRIM(Charnum))
        nume       = ALLTRIM("000000" + ALLTRIM(Charnum))
        CadMiles   = SUBSTR(CadMiles,1,7)
     
ENDCASE 



*       1234567891 
*
*        123456789-1
*Nume =  "0001431.82"
*         120102.35
*          117343.82
*        123456789-1 
CLEAR

*? "Nume " + nume
SW   = " "
CadMillones = "00000"+SUBSTR(nume,1,2)
CadMillones = ConvierteCifra(CadMillones,SW)
CadMillones = CadMillones
CadMiles   = " "
CadMiles   = "0000"+SUBSTR(nume,3,3)
SW ="1"
CadMiles   = ConvierteCifra(CadMiles,SW)
CadMiles   = CadMiles 
CadCien    = " "
CadCien    = "0000"+SUBSTR(Nume,6,1)+"00"
*?CadCien
CadCien    =  ConvierteCifra(CadCien,SW)
CadDecena  = " "
CadDecena  = "00000"+SUBSTR(Nume,7,2)
*?CadDecena
CadDecena =  ConvierteCifra(CadDecena,SW) 

LetraNumero = " "
IF .Not.Empty(CadMillones)
        CadMillones = CadMillones + "MILLONES"
        LetraNumero =  (CadMillones)+" " +ALLTRIM(CadMiles)+" "+ALLTRIM(CadCien)+" "+ALLTRIM(CadDecena)
ELSE
    IF .Not. EMPTY(CadMiles)
        CadMiles = CadMiles + " MIL"
        LetraNumero = RTRIM(CadMiles)+" "+ALLTRIM(CadCien)+" "+ALLTRIM(CadDecena) 
    ELSE   
       IF .Not. EMPTY(Cadcien)
         LetraNumero = ALLTRIM(CadCien)+" "+ALLTRIM(CadDecena)  
       ELSE
         LetraNumero = ALLTRIM(CadDecena) 
       ENDIF
    ENDIF   
ENDIF

?LetraNumero


return

Function ConvierteCifra(Texto, SW)
       
   
    Centena    = " "
    Decena     = " "
    Unidad     = " "
    txtCentena = " "
    txtDecena  = " "
    txtUnidad  = " " 
    Centena    =  SUBSTR(Texto, 5, 1)
    Decena     =  SUBSTR(Texto, 6, 1)
    Unidad     =  SUBSTR(Texto, 7, 1)
    
    Do Case Centena
       Case Centena   = "1"
             txtCentena = "CIEN"
             If Decena  <> " "
                txtCentena = "CIENTO"
             EndIf
        Case Centena  ="2"
             txtCentena = "DOSCIENTOS"
        Case Centena  ="3"
             txtCentena = "TRESCIENTOS"
        CASE Centena  = "4"
             txtCentena = "CUATROCIENTOS"
        Case Centena  =  "5"
             txtCentena = "QUINIENTOS"
        Case Centena  ="6"
             txtCentena = "SEISCIENTOS"
        Case Centena  ="7"
             txtCentena = "SETECIENTOS"
        Case Centena  ="8"
             txtCentena = "OCHOCIENTOS"
        Case Centena  ="9"
             txtCentena = "NOVECIENTOS"
    EndCase
    
    
    Do Case Decena
             Case Decena = "1"
                    txtDecena = "DIEZ"
                    if Unidad = "1"
                             txtDecena = "ONCE"
                        Endif 
                        if Unidad = "2"
                             txtDecena = "DOCE"
                        Endif
                        if Unidad = "3"
                             txtDecena = "TRECE"
                        Endif
                        if Unidad = "4"
                            txtDecena = "CATORCE"
                        Endif
                        if   Unidad = "5"
                             txtDecena = "QUINCE"
                        Endif
                        if   Unidad = "6"
                             txtDecena = "DIECISEIS"
                        Endif
                        
                        if Unidad = "7"
                             txtDecena = "DIECISIETE"
                        Endif
                        
                        if Unidad = "8"
                             txtDecena = "DIECIOCHO"
                        Endif
                        
                        if Unidad ="9"
                             txtDecena = "DIECINUEVE"
                        Endif
                    
                    
            Case Decena ="2"
                    txtDecena = "VEINTE"
                    If Unidad <> "0" Then
                      txtDecena = "VEINTI"
                    EndIf
            Case Decena ="3"
                    txtDecena = "TREINTA"
                    If Unidad <> "0" Then
                       txtDecena = "TREINTA Y "
                    EndIf
            Case Decena = "4"
                    txtDecena = "CUARENTA"
                    If Unidad <> "0" Then
                       txtDecena = "CUARENTA Y "
                    EndIf
            Case Decena = "5"
                    txtDecena = "CINCUENTA"
                    If Unidad <> "0" Then
                      txtDecena = "CINCUENTA Y "
                    EndIf
            Case Decena ="6"
                    txtDecena = "SESENTA"
                    If Unidad <> "0" Then
                       txtDecena = "SESENTA Y "
                    EndIf
            Case Decena = "7"
                    txtDecena = "SETENTA"
                    If Unidad <> "0" Then
                       txtDecena = "SETENTA Y "
                    EndIf
            Case Decena = "8"
                    txtDecena = "OCHENTA"
                    If Unidad <> "0" Then
                       txtDecena = "OCHENTA Y "
                    EndIf
            Case Decena ="9"
                    txtDecena = "NOVENTA"
                    If Unidad <> "0" Then
                       txtDecena = "NOVENTA Y "
                    EndIf
    ENDCASE
    
    If Decena <> "1" Then
        Do  Case Unidad
            Case Unidad = "1"
                If SW <> " "
                    txtUnidad = "UN"
                Else
                    txtUnidad = "UNO"
                EndIf
            Case Unidad =  "2"
                 txtUnidad = "DOS"
            Case Unidad ="3"
                 txtUnidad = "TRES"
            Case Unidad ="4"
                 txtUnidad = "CUATRO"
            Case Unidad ="5"
                 txtUnidad = "CINCO"
            Case Unidad ="6"
                 txtUnidad = "SEIS"
            Case Unidad ="7"
                 txtUnidad = "SIETE"
            Case Unidad ="8"
                 txtUnidad = "OCHO"
            Case Unidad = "9"
                 txtUnidad = "NUEVE"
        EndCase 
Endif


  
*  ?txtCentena + " " + txtDecena + " "+ txtUnidad 
letras = " "
letras =  txtCentena + " " + txtDecena + " "+ txtUnidad
RETURN letras