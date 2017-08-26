@echo off
title SLATE MUSIC HANDLER
set "susername==0"
set color=0f

color %colorcode%

:login
cls
	set /p "susername= Username "
IF EXIST C:\SLATE\MusicHandler\Users\%susername%.title  (
    Echo Login Successful
	rem set this users logins higher
	::wtf does that comment even mean? when did i fricken program this bit?
	::it means a successful logins counter. Now that's just stupid.
	goto main
 ) ELSE ( 
cls
    echo Login failed, would you like to create a new account?
	set /p "loginFail= (y/n)  "
	if "%loginFail%"=="y" goto createAccount
	if "%loginFail%"=="n" goto login
	if "%loginFail%"=="Y" goto createAccount
	if "%loginFail%"=="N" goto login
	echo Got it
	goto createAccount
 )
:createAccount
cls
echo What is your new username?
echo just hit enter it set it as "%susername%"
  set /p "susername= Username? "
  echo.
  set /p "password= Password? "
  echo.
  set /p "colorCode= Default Color? "
  echo Creating user files...
  echo.>"C:\SLATE\MusicHandler\Users\%susername%.title"
  mkdir "C:\SLATE\MusicHandler\Music\%susername%"
  
  call :TEXTMAN I 1 C:\SLATE\MusicHandler\Users\%susername%.title %susername%
  
  call :TEXTMAN I 2 C:\SLATE\MusicHandler\Users\%susername%.title "%date%"
  
  call :TEXTMAN I 3 C:\SLATE\MusicHandler\Users\%susername%.title %colorCode%
  
  call :TEXTMAN I 4 C:\SLATE\MusicHandler\Users\%susername%.title %password%
  set "password=0"
  echo Done!

goto login
:main
for /f "skip=1" %%G IN (C:\SLATE\MusicHandler\Users\%susername%.title) DO if not defined colorcode set "colorcode=%%G"
PING 1.1.1.1 -n 1 -w 1000 >NUL
cls
echo Hello %susername%.
set /p "mainInput= : "
if "%mainInput%"=="addmusic" explorer "C:\SLATE\MusicHandler\Music\%susername%"
if "%mainInput%"=="" goto
if "%mainInput%"=="" goto
if "%mainInput%"=="" goto
if "%mainInput%"=="" goto
pause



:TEXTMAN
(SET /A "A=0", "LINE=0", "TOTAL_LINES=0")  &  (CALL :%~1 %* || (ECHO Invalid parameter & Exit /B 1)) & (GOTO:EOF)
:I
(For /F "tokens=1* delims=]" %%A in ('type "%~3" ^| find /n /v ""') DO (Call Set /A "LINE+=1" && (CMD /C "IF     "%%LINE%%" EQU "%~2" (IF NOT "%~4" EQU "" ((Echo %~4) >> "%~3.NEW") ELSE (Echo+>> "%~3.NEW"))" & (if "%%B" EQU "" (Echo+>> "%~3.NEW") ELSE ((Echo %%B)>> "%~3.NEW"))))) && (CALL :RENAMER "%~3") & (GOTO:EOF)
:RENAMER
(REN "%~1" "%~nx1.BAK") & (MOVE /Y "%~1.BAK" "%TEMP%\" >NUL) & (REN "%~1.NEW" "%~nx1") & (GOTO:EOF)
	

