@echo off
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)
REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------    
REM thanks to https://stackoverflow.com/questions/1894967/how-to-request-administrator-access-inside-a-batch-file

rem  Note for Windows users on 64-bit systems
rem  Progra~1 = 'Program Files' 
rem  Progra~2 = 'Program Files(x86)'

set /a toolnix_found=0

IF EXIST "C:\Program Files\MKVToolNix\mkvmerge.exe" (
	echo "C:\Program Files\MKVToolNix\mkvmerge.exe" found, installing here
	rem aggiungo "C:\Program Files\MKVToolNix" alla variabile PATH dell'utente
	SETX PATH "%PATH%;C:\Progra~1\MKVToolNix"
	
	echo.
	echo 	"copying files into C:\Program Files\MKVToolNix"
	xcopy /e /v scripts "C:\Program Files\MKVToolNix" /y
	echo.
	echo 	"done, files copied into mkvtoolnix folder and path added"
	echo.
	set /a toolnix_found+=1
)

IF EXIST "C:\Program Files (x86)\MKVToolNix\mkvmerge.exe" (
	echo "C:\Program Files (x86)\MKVToolNix\mkvmerge.exe" found, installing here
	rem aggiungo "C:\Program Files\MKVToolNix" alla variabile PATH dell'utente
	SETX PATH "%PATH%;C:\Progra~2\MKVToolNix"
	
	echo 	"copying files into mkvtoolnix (x86) folder.."
	xcopy /e /v scripts "C:\Program Files (x86)\MKVToolNix" /y
	echo.
	echo 	"done, files copied into mkvtoolnix (x86) folder and path added"
	echo.
	set /a toolnix_found+=1
)

if "%toolnix_found%" EQU "0" (
	echo "toolnix not found, please install MKVToolNix in its default folder before installing these scripts 
	echo you can find it here: https://mkvtoolnix.download/downloads.html#windows
)

if "%toolnix_found%" EQU "2" (
	echo something looks wrong here.. you have 2 installation of mkvtoolnix??
)

	
pause
