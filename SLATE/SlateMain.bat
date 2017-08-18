@echo off
for /f "skip=29" %%G IN (slate.config) DO if not defined prg set "prg=%%G"
set versionNumber=1
IF "%prg%"=="1" (
call C:\SLATE\autoinstaller.bat
 )
::Writes to config a successful log on
	for /f "skip=24" %%G IN (slate.config) DO if not defined line set "line=%%G"
	Set /A ress=%line%+1
	call :TEXTMAN RL 25 "slate.config" "%ress%"
	for /f "skip=25" %%G IN (slate.config) DO if not defined linee set "linee=%%G"
	for /f "skip=26" %%G IN (slate.config) DO if not defined lineee set "lineee=%%G"
	for /f "skip=27" %%G IN (slate.config) DO if not defined colorN set "colorN=%%G"
	for /f "skip=28" %%G IN (slate.config) DO if not defined colorC set "colorC=%%G"

IF %colorN%==1 (
    Echo Custom Color Detected
    color %colorC%
	goto neext
 ) ELSE ( 
 
    color 07
	goto neext
 )
:neext
IF %linee%==1 (
    Echo Custom Name Detected
    title %lineee%
	goto next
 ) ELSE ( 

    title SLATE VERSION %versionNumber%
	goto next
 )

:next
goto head
exit
((I USE THIS TO WRITE TO FILES))

	 by Elektro H@cker
	 SYNTAX:
	
	 TEXTMAN [ACTION] [LINE(S)] [FILE] [TEXT]
	
	 * [LINE(S)] parameter is Optional for some actions
	 * [TEXT] parameter is Optional for some actions


	  ACTIONS:
	
	  AB  = ADD_BEGINNING      * Add text to the beginning of a line.
	  AE  = ADD_ENDING         * Add text to the end of a line.
	  E   = ERASE              * Delete a line.
	  I   = INSERT             * Add a empty line (Or a line with text).
	  RL  = REPLACE_LINE       * Replace a entire line.
	  RS  = REPLACE_STRING     * Replace word from line.
	  RSA = REPLACE_STRING_ALL * Replace word from all lines.
	  C+  = CHARACTER_PLUS     * Delete the first "X" characters from all lines.
	  C-  = CHARACTER_LESS     * Delete the last  "X" characters from all lines.
	  L+  = LINE_PLUS          * Cut the first "X" amount of lines.
	  L-  = LINE_LESS          * Cut the last  "X" amount of lines.
	  GL  = GET_LINE           * Delete all except "X" line.
	  GR  = GET_RANGE          * Delete all except "X" range of lines.
	  
	  
	 Welcome to the documentation of slate
	
	
	
	
:head
set headerCommand=0
cls
echo Type "help" to see the available commands.
echo.
echo.
echo [91mWelcome to slate.[0m
	set /p "headerCommand= Enter a command here: "
		if "%headerCommand%"=="setTitle" goto setTitle
		if "%headerCommand%"=="setColor" goto setColor
		if "%headerCommand%"=="help" goto help
		if "%headerCommand%"=="enableupdate" goto autoupdate
goto head
:autoupdate
cls
	set /p "updateChoice= Are you sure you would like to enable auto update? (y/n) "
		if "%updateChoice%"=="y" goto setautoupdate
		if "%updateChoice%"=="n" goto head
		if "%updateChoice%"=="Y" goto setautoupdate
		if "%updateChoice%"=="N" goto head
:setautoupdate
call :TEXTMAN RL 30 "slate.config" "1"
echo Config updated: Will check for updates on startup.
:setTitle
cls
echo [91mIf you would like to just reset the title, type in 0.
echo Titles must only be valid characters! (probably)[0m
	set /p "customTitle= Title ~ "
		IF "%customTitle%"=="0" (
	call :TEXTMAN RL 26 "slate.config" 0
	goto head
	) ELSE ( 
		 call :TEXTMAN RL 27 "slate.config" "%customTitle%"
		 title %customTitle%
		 call :TEXTMAN RL 26 "slate.config" 1
		 goto head
	)
:setColor
cls
echo [91mIf you would like to just reset the color, type in 0.[0m
	set /p "customColor= Color ~ "
		IF %customColor%==0 (
	call :TEXTMAN RL 28 "slate.config" 0
	goto head
	) ELSE ( 
		 call :TEXTMAN RL 29 "slate.config" "%customColor%"
		 color %customColor%
		 call :TEXTMAN RL 28 "slate.config" 1
		 goto head
	)
:help
cls
echo SEAL HELP
echo.
echo [91mThis color means feature hasn't been added yet.[0m
echo.
echo	setTitle	 ~ Allows you to set a custom title.
echo	setColor	 ~ Allows you to set a custom color.
echo	help		 ~ Opens the help menu.
echo	enableupdate ~ Enables automatic updates on each start of the program. Also on computer start up if enabled.
echo	[91monstart		 ~ Enables SLATE and associated files to open on startup.
echo	configHelp	 ~ Opens config documentation[0m
pause
goto head
:TEXTMAN
(SET /A "A=0", "LINE=0", "TOTAL_LINES=0")  &  (CALL :%~1 %* || (ECHO Invalid parameter & Exit /B 1)) & (GOTO:EOF)
:AB
(For /F "tokens=1* delims=]" %%A in ('type "%~3" ^| find /n /v ""') DO (Call Set /A "LINE+=1" && (CMD /C "IF NOT "%%LINE%%" EQU "%~2" (if "%%B" EQU "" (Echo+>> "%~3.NEW") ELSE ((Echo %%B)>> "%~3.NEW")) ELSE (if "%%B" EQU "" ((Echo %~4)>> "%~3.NEW") ELSE ((Echo %~4%%B)>> "%~3.NEW"))"))) && (CALL :RENAMER "%~3") & (GOTO:EOF)
:AE
(For /F "tokens=1* delims=]" %%A in ('type "%~3" ^| find /n /v ""') DO (Call Set /A "LINE+=1" && (CMD /C "IF NOT "%%LINE%%" EQU "%~2" (if "%%B" EQU "" (Echo+>> "%~3.NEW") ELSE ((Echo %%B)>> "%~3.NEW")) ELSE ((Echo %%B%~4)>> "%~3.NEW")"))) && (CALL :RENAMER "%~3") & (GOTO:EOF)
:E
(For /F "tokens=1* delims=]" %%A in ('type "%~3" ^| find /n /v ""') DO (Call Set /A "LINE+=1" && (CMD /C "IF NOT "%%LINE%%" EQU "%~2" (if "%%B" EQU "" (Echo+>> "%~3.NEW") ELSE ((Echo %%B) >> "%~3.NEW"))"))) && (CALL :RENAMER "%~3") & (GOTO:EOF)
:I
(For /F "tokens=1* delims=]" %%A in ('type "%~3" ^| find /n /v ""') DO (Call Set /A "LINE+=1" && (CMD /C "IF     "%%LINE%%" EQU "%~2" (IF NOT "%~4" EQU "" ((Echo %~4) >> "%~3.NEW") ELSE (Echo+>> "%~3.NEW"))" & (if "%%B" EQU "" (Echo+>> "%~3.NEW") ELSE ((Echo %%B)>> "%~3.NEW"))))) && (CALL :RENAMER "%~3") & (GOTO:EOF)
:RL
(For /F "tokens=1* delims=]" %%A in ('type "%~3" ^| find /n /v ""') DO (Call Set /A "LINE+=1" && (CMD /C "IF NOT "%%LINE%%" EQU "%~2" (if "%%B" EQU "" (Echo+>> "%~3.NEW") ELSE ((Echo %%B)>> "%~3.NEW")) ELSE ((Echo %~4)>> "%~3.NEW")"))) && (CALL :RENAMER "%~3") & (GOTO:EOF)
:RS
(For /F "tokens=1* delims=]" %%A in ('type "%~3" ^| find /n /v ""') DO (Call Set /A "LINE+=1" && (CMD /C "IF NOT "%%LINE%%" EQU "%~2" (if "%%B" EQU "" (Echo+>> "%~3.NEW") ELSE ((Echo %%B)>> "%~3.NEW")) ELSE (CALL SET "STRING=%%B" &&     (if "%%B" EQU "" (Echo+>> "%~3.NEW") ELSE ((CALL ECHO %%STRING:%~4=%~5%%)>> "%~3.NEW")))"))) && (CALL :RENAMER "%~3") & (GOTO:EOF)
:RSA
(For /F "tokens=1* delims=]" %%A in ('type "%~2" ^| find /n /v ""') DO (CALL SET "STRING=%%B" && (if "%%B" EQU "" (Echo+>> "%~2.NEW") ELSE ((CALL ECHO %%STRING:%~3=%~4%%)>>"%~2.NEW")))) && (CALL :RENAMER "%~2") & (GOTO:EOF)
:C+
(For /F "usebackq tokens=*" %%@ in ("%~3") DO (Call Set   "LINE=%%@" && (CALL ECHO %%LINE:~%~2%% >>      "%~3.NEW"))) && (CALL :RENAMER "%~3") & (GOTO:EOF)
:C-
(For /F "usebackq tokens=*" %%@ in ("%~3") DO (Call Set   "LINE=%%@" && (CALL ECHO %%LINE:~0,-%~2%% >>   "%~3.NEW"))) && (CALL :RENAMER "%~3") & (GOTO:EOF)
:L+
(Call SET /A "A=%~2") && (Call TYPE "%~3" |@MORE +%%A%% > "%~3.NEW") && (CALL :RENAMER "%~3") & (GOTO:EOF)
:L-
(For /F "tokens=1* delims=]" %%A in ('type "%~3" ^| find /n /v ""') DO (CALL SET /A "TOTAL_LINES+=1")) & (CALL SET /A "TOTAL_LINES-=%~2-1") & (For /F "tokens=1* delims=]" %%A in ('type "%~3" ^| find /n /v ""') DO (Call Set /A "LINE+=1" & Call echo "%%LINE%%"|@FIND "%%TOTAL_LINES%%" >NUL) && (CALL :RENAMER "%~3" && GOTO:EOF) || (Echo %%B >> "%~3.NEW"))
:GL
(Call SET /A "A=%~2" && Call SET /A "A-=1") && (Call TYPE "%~3" |@MORE +%%A%% > "%temp%\getline.tmp") && (For /F "tokens=1* delims=]" %%A in ('type "%temp%\getline.tmp" ^| find /n /v ""') DO ((if "%%B" EQU "" (Echo+>> "%~3.NEW") ELSE ((Echo %%B)> "%~3.NEW"))) && ((CALL :RENAMER "%~3") & (GOTO:EOF))) 
:GR
(For /F "tokens=1* delims=]" %%A in ('type "%~4" ^| find /n /v ""') DO (Call Set /A "LINE+=1" && (CMD /C "(IF "%%LINE%%" GEQ "%~2" IF "%%LINE%%" LEQ "%~3" (if "%%B" EQU "" (Echo+>> "%~4.NEW") ELSE ((Echo %%B)>> "%~4.NEW"))) && (IF "%%LINE%%" EQU "%~3" Exit /B 1)" || ((CALL :RENAMER "%~4") & (GOTO:EOF)))))
:RENAMER
(REN "%~1" "%~nx1.BAK") & (MOVE /Y "%~1.BAK" "%TEMP%\" >NUL) & (REN "%~1.NEW" "%~nx1") & (GOTO:EOF)