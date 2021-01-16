DECLARE INTEGER ShellExecute IN shell32.dll ; 
  INTEGER hndWin, ; 
  STRING cAction, ; 
  STRING cFileName, ; 
  STRING cParams, ;  
  STRING cDir, ; 
  INTEGER nShowWin
  lcAction   = "open"
lcFileName = "www.gmail.com"
=ShellExecute(0, lcAction, lcFileName, "", "", 1)
