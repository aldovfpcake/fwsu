PARAMETERS archivo
CLOSE tables
SET muLtilocks on
SET EXCLUSIVE OFF
SET SQLBUFFERING ON
SET SAFETY OFF
SELECT 0

*OPEN DATABASE f:\sueldos\sueldos
*archivo = "f:\sueldos\empre1\62014"
*
USE &archivo
CREATE SQL VIEW  curliq as;
SELECT legajo, concepto, tipoconcep, valoruni,  cantidad,; 
aporte, sinaporte, descuento, liquida, recibo, descrip, orden FROM  &archivo where legajo =?vlegajo  .and. liquida = ?vliquida;
order by concepto


dbsetprop("curliq" ,"View","SendUpdates",.T.)
DBSetProp("curliq","view","BatchUpdateCount",1)
DBSetProp("curliq","View","CompareMemo",.T.)
DBSetProp("curliq","View","FetchAsNeeded",.F.)
DBSetProp("curliq","View","FetchMemo",.T.)
DBSetProp("curliq","View","FetchSize",100)
DBSetProp("curliq","View","MaxRecords",-1)
DBSetProp("curliq","View","Prepared",.F.)
DBSetProp("curliq","View","UpdateType",1)
DBSetProp("curliq","View","UseMemoSize",255)
DBSetProp("curliq","View","Tables","52021")
DBSetProp("curliq","View","WhereType",3)

DBSetProp("curliq"+".legajo","Field","DataType","N(4)")
DBSetProp("curliq"+".legajo","Field","UpdateName","52021.legajo")
DBSetProp("curliq"+".legajo","Field","KeyField",.T.)
DBSetProp("curliq"+".legajo","Field","Updatable",.T.)

DBSetProp("curliq"+".concepto","Field","DataType","N(4)")
DBSetProp("curliq"+".concepto","Field","UpdateName","52021.concepto")
DBSetProp("curliq"+".concepto","Field","KeyField",.T.)
DBSetProp("curliq"+".concepto","Field","Updatable",.T.)

DBSetProp("curliq"+".tipoconcep","Field","DataType","C(11)")
DBSetProp("curliq"+".tipoconcep","Field","UpdateName","52021.tipoconcep")
DBSetProp("curliq"+".tipoconcep","Field","KeyField",.F.)
DBSetProp("curliq"+".tipoconcep","Field","Updatable",.T.)

DBSetProp("curliq"+".valoruni","Field","DataType","N(10,2)")
DBSetProp("curliq"+".valoruni","Field","UpdateName","52021.valoruni")
DBSetProp("curliq"+".valoruni","Field","KeyField",.F.)
DBSetProp("curliq"+".valoruni","Field","Updatable",.T.)

DBSetProp("curliq"+".cantidad","Field","DataType","N(10,4)")
DBSetProp("curliq"+".cantidad","Field","UpdateName","52021.cantidad")
DBSetProp("curliq"+".cantidad","Field","KeyField",.F.)
DBSetProp("curliq"+".cantidad","Field","Updatable",.T.)

DBSetProp("curliq"+".aporte","Field","DataType","N(10,2)")
DBSetProp("curliq"+".aporte","Field","UpdateName","52021.aporte")
DBSetProp("curliq"+".aporte","Field","KeyField",.F.)
DBSetProp("curliq"+".aporte","Field","Updatable",.T.)

DBSetProp("curliq"+".sinaporte","Field","DataType","N(10,2)")
DBSetProp("curliq"+".sinaporte","Field","UpdateName","52021.sinaporte")
DBSetProp("curliq"+".sinaporte","Field","KeyField",.F.)
DBSetProp("curliq"+".sinaporte","Field","Updatable",.T.)

DBSetProp("curliq"+".descuento","Field","DataType","N(10,2)")
DBSetProp("curliq"+".descuento","Field","UpdateName","52021.descuento")
DBSetProp("curliq"+".descuento","Field","KeyField",.F.)
DBSetProp("curliq"+".descuento","Field","Updatable",.T.)

DBSetProp("curliq"+".liquida","Field","DataType","N(1)")
DBSetProp("curliq"+".liquida","Field","UpdateName","52021.liquida")
DBSetProp("curliq"+".liquida","Field","KeyField",.T.)
DBSetProp("curliq"+".liquida","Field","Updatable",.T.)

DBSetProp("curliq"+".recibo","Field","DataType","N(5)")
DBSetProp("curliq"+".recibo","Field","UpdateName","52021.recibo")
DBSetProp("curliq"+".recibo","Field","KeyField",.F.)
DBSetProp("curliq"+".recibo","Field","Updatable",.T.)

DBSetProp("curliq"+".descrip","Field","DataType","C(20)")
DBSetProp("curliq"+".descrip","Field","UpdateName","52021.descrip")
DBSetProp("curliq"+".descrip","Field","KeyField",.F.)
DBSetProp("curliq"+".descrip","Field","Updatable",.T.)

DBSetProp("curliq"+".orden","Field","DataType","C(15)")
DBSetProp("curliq"+".orden","Field","UpdateName","52021.orden")
DBSetProp("curliq"+".orden","Field","KeyField",.F.)
DBSetProp("curliq"+".orden","Field","Updatable",.T.)
*SELECT A 
*USE
USE curliq
BROWSE
CLOSE TABLES
SELECT A
USE

