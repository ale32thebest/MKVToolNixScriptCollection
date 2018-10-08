@echo off

::we check if tee is available
@WHERE tee> nul 2>&1
if %ERRORLEVEL% NEQ 0 (
	echo.
	echo 	tee not found, please download tee and insert it in path or in this folder
	echo 	without tee i will use the old version of the script
	echo 	without warnings / error checks and autodelete of files
	echo 	you can find a good port online here http://unxutils.sourceforge.net/ 
	goto OLD_SCRIPT_WITH_NO_CHECKS_OR_DELETE
)

::we check if mkvmerge is available
@WHERE mkvmerge> nul 2>&1
if %ERRORLEVEL% NEQ 0 (
	echo.
	echo 	mkvmerge not found, please download mkvmerge and insert it in path or in this folder
	echo 	without mkvmerge we cannot go on
	pause
	exit /b 1
)

set /a processedFiles=0
set /a inconteredErrors=0

FOR %%A IN (*.avi *.mp4 *.flv *.mpg *.mpeg *.rmvb *.ts *.mov ) DO (
	echo.
	set /a processedFiles+=1
	mkvmerge -o "%%~nA.mkv" "%%~A" --ui-language en | tee "%%~A.log"
	set /a somethingWrong=0
	
	find /i "Error" "%%~A.log" >NUL
		if errorlevel 1 (
			@rem no Errors 
		) else (
			if "%inconteredErrors%" EQU "0" (
				@rem first error here
				if exist "_ReadMeMkvErrorsAndWarnings.log" (
					::should not do this with a clean session anyway
					call:printDateToErrorLogs
				)
			)
			call :checkIfErrorLogsNoExistAndPrintDate
			echo Error found on %%~A , check Log >> _ReadMeMkvErrorsAndWarnings.log
			set /a somethingWrong=1
			set /a inconteredErrors+=1
		)
		
	find /i "Warning" "%%~A.log" >NUL
		if errorlevel 1 (
			@rem no Warnings 
		) else (
		if "%inconteredErrors%" EQU "0" (
				@rem first error here
				if exist "_ReadMeMkvErrorsAndWarnings.log" (
					::should not do this with a clean session anyway
					call:printDateToErrorLogs
				)
			)
			call :checkIfErrorLogsNoExistAndPrintDate
			echo Warning found on %%~A , check Log >> _ReadMeMkvErrorsAndWarnings.log
			set /a somethingWrong=1
			set /a inconteredErrors+=1
		)
	call:deleteIfNoErrors "%%~A"
)

if "%processedFiles%" EQU "0" (
	echo 	Nothing to do here
) else (
	echo 	Done, %processedFiles% processed file(s^)
)

::check if there were errors and open file
if %inconteredErrors% GTR 0 (
	if exist "_ReadMeMkvErrorsAndWarnings.log" (
		echo.
		echo 	There was a problem with one or more file in this folder,
		echo 	now i will open it for you so you can see what happened
		echo 	please note that this script does not delete the old errorLog,
		echo 	check the date on the file
		echo 	press Enter to open it and terminate the process
		set /P INPUT= 
		start _ReadMeMkvErrorsAndWarnings.log
	)
)
exit /B 0

:OLD_SCRIPT_WITH_NO_CHECKS_OR_DELETE
FOR %%A IN (*.avi *.mp4 *.flv *.mpg *.mpeg *.rmvb *.ts *.mov ) DO (mkvmerge -o "%%~nA.mkv" "%%~A" --ui-language en)
EXIT /B 0


:printDateToErrorLogs
echo. >> _ReadMeMkvErrorsAndWarnings.log
echo %date% - %time% >> _ReadMeMkvErrorsAndWarnings.log
EXIT /B 0

:checkIfErrorLogsNoExistAndPrintDate
if not exist "_ReadMeMkvErrorsAndWarnings.log" (
	echo %date% - %time% >> _ReadMeMkvErrorsAndWarnings.log
)
EXIT /B 0

:deleteIfNoErrors
if "%somethingWrong%" EQU "0" ( 
	del "%~1.log" 
	del "%~1"
)
EXIT /B 0

::"--language" "0:jpn" "--language" "1:ita"
:: if added before "%%~A" you can set tracks language

:: --atracks 1
:: keep only the selcted track (in this case "a" stand for audio track) with the choosen number (1 is the f)
:: using "--atracks 1,2" you ca keep track 1 and 2

:: "%%~nA.srt" before "%%~A" ifd you want to add a subtitle track with the same name as the file
:: --attach-file "cover.jpg" if you want to add a cover as an attachment 
::(remeber to use the name "cover.jpg" as stated in the mkv guideline)