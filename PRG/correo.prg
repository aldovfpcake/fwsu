*LOCAL loCfg, loMsg, lcFile, loErr
*TRY
*  loCfg = CREATEOBJECT("CDO.Configuration")
*  WITH loCfg.Fields
*    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "smtp.gmail.com"
*    .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465 && ó 587
*    .Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
*    .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = .T.
*    .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = .T.
*    .Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "alvalen@gmail.com"
*    .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "lobyta2349"
*    .Update
*  ENDWITH
*  loMsg = CREATEOBJECT ("CDO.Message")
*  WITH loMsg
*    .Configuration = loCfg
*    *-- Remitenete y destinatarios
*    .From = "aldo <alvalen@gmail.com>"
*    .To = "alprogramgit@gmail.com"
    *Cc = "Usuario Dos <user2@gmail.com>"
    *- Notificación de lectura
*    .Fields("urn:schemas:mailheader:disposition-notification-to") = .From
*    .Fields("urn:schemas:mailheader:return-receipt-to") = .From
*    .Fields.Update
    *-- Tema
*    .Subject = "Ejemplo del " + TTOC(DATETIME())
    *-- Formato HTML desde la Web
 *   .CreateMHTMLBody("http://comunidadvfp.blogspot.com/p/acerca-de.html", 0)
    *-- Archivo adjunto
    *lcFile = GETFILE()
   * IF NOT EMPTY(lcFile)
    *  .AddAttachment(lcFile)
    *ENDIF
    *-- Envio el mensaje
*    .Send()
*  ENDWITH
*CATCH TO loErr 
*  MESSAGEBOX("No se pudo enviar el mensaje" + CHR(13) + ;
*    "Error: " + TRANSFORM(loErr.ErrorNo) + CHR(13) + ;
*    "Mensaje: " + loErr.Message , 16, "Error")
*FINALLY
*  loMsg = NULL
*  loCfg = NULL
*ENDTRY

loOutlook = CREATEOBJECT("Outlook.Application")
loNameSpace = loOutlook.GetNameSpace("MAPI")
 
*-- Ejecuto los métodos
loNameSpace.Logon("aldov@r12.com.ar - Google Apps" , "654321r12")
loMailItem = loOutlook.CreateItem(0)
loMailItem.Recipients.ADD("aldov@r12.com.ar")
loMailItem.Subject = "Titulo"
loMailItem.Body = "Texto"
*lnombre = SUBSTR(cgempresa,1,AT(" ",cgempresa)-1)
*larchivo=ArchivosAdjuntos
*IF !EMPTY(larchivo)
*	IF FILE(larchivo)*
*	loMailItem.Attachments.ADD(larchivo)
*	ENDIF
*ENDIF
*larchivo= ALLTRIM(safemp.dautorizados)+'CR_'+lnombre+substr(tfcntpdt.nret,7,9)+'_'+ STRTRAN(DTOC(tfcntpdt.fecha),"/","")+".XML"
*IF FILE(larchivo)
*loMailItem.Attachments.ADD(larchivo)
*ENDIF
loMailItem.Send
loNameSpace.Logoff