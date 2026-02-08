@echo off
setlocal EnableDelayedExpansion

REM Valores por defecto
set VERSION=1
set SUBVERSION=0
set ERRVERSION=0
set CODENAME=Noname

REM Sobrescribir si vienen informados
if not "%~1"=="" set VERSION=%~1
if not "%~2"=="" set SUBVERSION=%~2
if not "%~3"=="" set ERRVERSION=%~3
if not "%~4"=="" set CODENAME=%~4


REM Directorio base (donde est� el .bat)
set BASEDIR=%~dp0

REM Fichero con la lista de archivos
set LISTA=%BASEDIR%repositorios.txt

REM Nombre del zip de salida
set ZIP=%BASEDIR%..\..\..\GENFrameWork_Ver_%VERSION%_%SUBVERSION%_%ERRVERSION%_%CODENAME%.zip

if not exist "%LISTA%" (
    echo ERROR: No se encuentra %LISTA%
    exit /b 1
)

REM Borrar zip previo si existe
if exist "%ZIP%" del "%ZIP%"

echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo ----------------------------------------------------------------------------------------------------
echo Creando ZIP: %ZIP%
echo.

for /f "usebackq delims=" %%F in ("%LISTA%") do (
    set FILE=%BASEDIR%..\..\..\%%F

    if exist "!FILE!" (
        echo Agregando %%F
        powershell -NoLogo -NoProfile -Command ^
          "Compress-Archive -Path '!FILE!' -DestinationPath '%ZIP%' -Update"
    ) else (
        echo WARNING: No existe el archivo %%F
    )
)

echo.
echo ZIP generado correctamente.
echo ----------------------------------------------------------------------------------------------------

REM === Calcular SHA256 del ZIP y generar versions.json ===
if not exist "%ZIP%" (
    echo ERROR: No se ha encontrado el ZIP para calcular el SHA256: %ZIP%
    exit /b 4
)

for %%Z in ("%ZIP%") do (
    set "ZIPNAME=%%~nxZ"
    set "ZIPDIR=%%~dpZ"
)

for /f "usebackq delims=" %%H in (`powershell -NoLogo -NoProfile -Command "(Get-FileHash -Algorithm SHA256 -LiteralPath '%ZIP%').Hash"`) do set "SHA256=%%H"
for /f "usebackq delims=" %%D in (`powershell -NoLogo -NoProfile -Command "Get-Date -Format yyyy-MM-dd"`) do set "BUILDDATE=%%D"

set "JSONFILE=%ZIPDIR%versions.json"

REM Sobrescribe versions.json
(
echo {
echo   "files": [
echo     {
echo       "file": "!ZIPNAME!",
echo       "sha256": "!SHA256!",
echo       "buildDate": "!BUILDDATE!"
echo     }
echo   ]
echo }
) > "!JSONFILE!"

echo versions.json generado: !JSONFILE!

pause
