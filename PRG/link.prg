Local lnResultado
 
#DEFINE SE_NORMAL     1
#DEFINE SE_MINIMIZADO 2
#DEFINE SE_MAXIMIZADO 3
 

 dire ="https://linti.seguridadvial.gob.ar/lintidigital/27927574"
 poExplorer = CreateObject("internetexplorer.Application") 
 poExplorer.Navigate(dire) 
 poExplorer.Visible=.T.



 
Return
*