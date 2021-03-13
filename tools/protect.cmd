@echo off

pushd "%~dp0"

set /p password=<".gitkey"
set zip=%cd%\7-Zip\7za.exe

set files=(^
	BareGrepPro\BareGrepPro.exe^
	BareTailPro\BareTailPro.exe^
)

if "%1"=="kill" goto do_delete
if "%1"=="off" goto do_decrypt
if "%1"=="on" goto do_encrypt

echo.
echo. Usage
echo. -----
echo. protect kill  Delete decrypted files
echo. protect off   Encrypt files
echo. protect on    Decrypt files

:::::::::
goto quit

:do_decrypt
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
setlocal enabledelayedexpansion
for %%i in %files% do (
	set src=%cd%\%%i.aes256
	if exist "!src!" (
		%zip% e -o"%%~dpi" -p"%password%" -y "!src!"
	)
)

:::::::::
goto quit

:do_delete
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
setlocal enabledelayedexpansion
for %%i in %files% do (
	set src=%cd%\%%i
	if exist "!src!" (
		del "!src!"
	)
)

:::::::::
goto quit

:do_encrypt
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
setlocal enabledelayedexpansion
for %%i in %files% do (
	set dst=%cd%\%%i.aes256
	set src=%cd%\%%i
	if exist "!src!" (
		%zip% a -p"%password%" -mhe=on -sdel "!dst!" "!src!"
	)
)

:::::::::
goto quit

:quit
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
popd

:::::::::
exit /b 0
