SET EXCLUSIVE OFF
USE f:\sueldos\empre1\12014
CREATE SQL VIEW CURLIQ AS;
SELECT 12014.legajo, 12014.concepto, 12014.tipoconcep, 12014.valoruni,;
12014.cantidad, 12014.aporte, 12014.sinaporte, 12014.descuento, 12014.liquida,;
12014.recibo, 12014.descrip, 12014.orden FROM  12014 WHERE  12014.legajo =  ?vlegajo AND  12014.liquida =  ?vliquida  ORDER BY 12014.concepto

DBSetProp(ThisView,"View","SendUpdates",.T.)
DBSetProp(ThisView,"View","BatchUpdateCount",1)
DBSetProp(ThisView,"View","CompareMemo",.T.)
DBSetProp(ThisView,"View","FetchAsNeeded",.F.)
DBSetProp(ThisView,"View","FetchMemo",.T.)
DBSetProp(ThisView,"View","FetchSize",100)
DBSetProp(ThisView,"View","MaxRecords",-1)
DBSetProp(ThisView,"View","Prepared",.F.)
DBSetProp(ThisView,"View","UpdateType",2)
DBSetProp(ThisView,"View","UseMemoSize",255)
DBSetProp(ThisView,"View","Tables","12014")
DBSetProp(ThisView,"View","WhereType",3)

DBSetProp(ThisView+".legajo","Field","DataType","N(4)")
DBSetProp(ThisView+".legajo","Field","UpdateName","12014.legajo")
DBSetProp(ThisView+".legajo","Field","KeyField",.T.)
DBSetProp(ThisView+".legajo","Field","Updatable",.T.)

DBSetProp(ThisView+".concepto","Field","DataType","N(4)")
DBSetProp(ThisView+".concepto","Field","UpdateName","12014.concepto")
DBSetProp(ThisView+".concepto","Field","KeyField",.T.)
DBSetProp(ThisView+".concepto","Field","Updatable",.T.)

DBSetProp(ThisView+".tipoconcep","Field","DataType","C(11)")
DBSetProp(ThisView+".tipoconcep","Field","UpdateName","12014.tipoconcep")
DBSetProp(ThisView+".tipoconcep","Field","KeyField",.F.)
DBSetProp(ThisView+".tipoconcep","Field","Updatable",.T.)

DBSetProp(ThisView+".valoruni","Field","DataType","N(10,2)")
DBSetProp(ThisView+".valoruni","Field","UpdateName","12014.valoruni")
DBSetProp(ThisView+".valoruni","Field","KeyField",.F.)
DBSetProp(ThisView+".valoruni","Field","Updatable",.T.)

DBSetProp(ThisView+".cantidad","Field","DataType","N(10,4)")
DBSetProp(ThisView+".cantidad","Field","UpdateName","12014.cantidad")
DBSetProp(ThisView+".cantidad","Field","KeyField",.F.)
DBSetProp(ThisView+".cantidad","Field","Updatable",.T.)

DBSetProp(ThisView+".aporte","Field","DataType","N(10,2)")
DBSetProp(ThisView+".aporte","Field","UpdateName","12014.aporte")
DBSetProp(ThisView+".aporte","Field","KeyField",.F.)
DBSetProp(ThisView+".aporte","Field","Updatable",.T.)

DBSetProp(ThisView+".sinaporte","Field","DataType","N(10,2)")
DBSetProp(ThisView+".sinaporte","Field","UpdateName","12014.sinaporte")
DBSetProp(ThisView+".sinaporte","Field","KeyField",.F.)
DBSetProp(ThisView+".sinaporte","Field","Updatable",.T.)

DBSetProp(ThisView+".descuento","Field","DataType","N(10,2)")
DBSetProp(ThisView+".descuento","Field","UpdateName","12014.descuento")
DBSetProp(ThisView+".descuento","Field","KeyField",.F.)
DBSetProp(ThisView+".descuento","Field","Updatable",.T.)

DBSetProp(ThisView+".liquida","Field","DataType","N(1)")
DBSetProp(ThisView+".liquida","Field","UpdateName","12014.liquida")
DBSetProp(ThisView+".liquida","Field","KeyField",.F.)
DBSetProp(ThisView+".liquida","Field","Updatable",.T.)

DBSetProp(ThisView+".recibo","Field","DataType","N(5)")
DBSetProp(ThisView+".recibo","Field","DefaultValue","950")
DBSetProp(ThisView+".recibo","Field","UpdateName","12014.recibo")
DBSetProp(ThisView+".recibo","Field","KeyField",.F.)
DBSetProp(ThisView+".recibo","Field","Updatable",.T.)

DBSetProp(ThisView+".descrip","Field","DataType","C(20)")
DBSetProp(ThisView+".descrip","Field","UpdateName","12014.descrip")
DBSetProp(ThisView+".descrip","Field","KeyField",.F.)
DBSetProp(ThisView+".descrip","Field","Updatable",.T.)

DBSetProp(ThisView+".orden","Field","DataType","C(15)")
DBSetProp(ThisView+".orden","Field","UpdateName","12014.orden")
DBSetProp(ThisView+".orden","Field","KeyField",.F.)
DBSetProp(ThisView+".orden","Field","Updatable",.T.)

