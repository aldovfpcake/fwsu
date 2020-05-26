LOCAL loCfg, loMsg, lcFile, loErr
TRY
  loCfg = CREATEOBJECT("CDO.Configuration")
  lcSchema = "http://schemas.microsoft.com/cdo/configuration/"
  WITH loCfg.Fields
    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = ""
    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465 && ó 587
    .Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
    .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = .T.
    .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = .T.
    .Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "aldov@r12.com.ar"
    .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "654321r12"
    .Update
  ENDWITH
  loMsg = CREATEOBJECT ("CDO.Message")
  WITH loMsg
    .Configuration = loCfg
    *-- Remitenete y destinatarios
    .From = "aldov@r12.com.ar <aldov@r12.com.ar>"
    .To = "alvalen@gmail.com <alvalen@gmail.com>"
    .Cc = " "
    *- Notificación de lectura
    .Fields("urn:schemas:mailheader:disposition-notification-to") = .From
    .Fields("urn:schemas:mailheader:return-receipt-to") = .From
    .Fields.Update
    *-- Tema
    .Subject = "Ejemplo del " + TTOC(DATETIME())
    *-- Formato HTML desde la Web
    .CreateMHTMLBody("http://comunidadvfp.blogspot.com/p/acerca-de.html", 0)
    *-- Archivo adjunto
    lcFile = " "
    IF NOT EMPTY(lcFile)
      .AddAttachment(lcFile)
    ENDIF
    *-- Envio el mensaje
    .Send()
  ENDWITH
CATCH TO loErr 
  MESSAGEBOX("No se pudo enviar el mensaje" + CHR(13) + ;
    "Error: " + TRANSFORM(loErr.ErrorNo) + CHR(13) + ;
    "Mensaje: " + loErr.Message , 16, "Error")
FINALLY
  loMsg = NULL
  loCfg = NUL
ENDTRY  
