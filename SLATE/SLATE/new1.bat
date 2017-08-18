@echo off
 >"%temp%\geturl.vbs" echo Set objArgs = WScript.Arguments
>>"%temp%\geturl.vbs" echo url = objArgs(0)
>>"%temp%\geturl.vbs" echo pix = objArgs(1)
>>"%temp%\geturl.vbs" echo With CreateObject("MSXML2.XMLHTTP")
>>"%temp%\geturl.vbs" echo .open "GET", url, False
>>"%temp%\geturl.vbs" echo .send
>>"%temp%\geturl.vbs" echo a = .ResponseBody
>>"%temp%\geturl.vbs" echo End With
>>"%temp%\geturl.vbs" echo With CreateObject("ADODB.Stream")
>>"%temp%\geturl.vbs" echo .Type = 1 'adTypeBinary
>>"%temp%\geturl.vbs" echo .Mode = 3 'adModeReadWrite
>>"%temp%\geturl.vbs" echo .Open
>>"%temp%\geturl.vbs" echo .Write a
>>"%temp%\geturl.vbs" echo .SaveToFile pix, 2 'adSaveCreateOverwrite
>>"%temp%\geturl.vbs" echo .Close
>>"%temp%\geturl.vbs" echo End With

cscript /nologo "%temp%\geturl.vbs" https://raw.githubusercontent.com/SirEatsALotOff/slate/master/SLATE/versioninfo.txt versioninfod.txt 2>nul 
del "%temp%\geturl.vbs"
::https://github.com/SirEatsALotOff/slate/releases/download/V.2/slateInstaller.EXE
 pause
for /f "skip=1" %%G IN (versioninfod.txt) DO if not defined versioninof set "versioninof=%%G"
echo %versioninof%
for /f "skip=30" %%G IN (slate.config) DO if not defined oldvnum set "oldvnum=%%G"
echo oldvnum
IF %versioninof%==%oldvnum% (
	echo No new version detected.
	goto end
 ) ELSE ( 
	set "x=https://github.com/SirEatsALotOff/slate/releases/download/%versioninof%/slateInstaller.EXE"
	start "" %x%
 )
 :end
 echo Finished.
 pause
 cls