*MODIFY COMMAND c:\suerut\prg-tecsan\cgtaller.prg
*exit
DO "c:\suerut\prg-tecsan\cgtaller.prg"
SELECT tabhoras
GO top
*REPLACE ALL horcta    WITH 0
*REPLACE ALL horcien   WITH 0

*REPLACE ALL parfer    WITH 1
*REPLACE ALL ENF       WITH 0
*REPLACE ALL DIASNOTRA WITH 0
*REPLACE ALL AUS       WITH 0
*REPLACE ALL COMIDA    WITH 24
DO "c:\fwsu\prg\lqautom-taller.prg"
*
SELECT tabhoras
*SELECT basehoras
*browse