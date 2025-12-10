@echo off

set "DIR=%~1/Platforms/%SO_PATH%/%PLATFORM_PATH%"
set "OLDPATH=%CD%"

if not exist "%~1/Platforms/%SO_PATH%" (
  mkdir "%~1/Platforms/%SO_PATH%"
)
 
if exist "%DIR%" (
  del /s /q "%DIR%\*.*"
  rmdir /s /q "%%i"
)

if not exist "%DIR%" (
  mkdir "%DIR%"
)

cd "%DIR%" 

%PRINTF% "\n\n[%%s]\n\n" "%~2" >> %OUTFILE% 

 
%PRINTF% "[#CMake#]\n"  >> %OUTFILE% 
%PRINTF% "Generate CMake      %%-16s ... " "%~2" 
cmake -G "Ninja" -DTARGET=%TARGET% -DDEBUG_EXTCFG=%DEBUG_EXTCFG% -DMEMORY_EXTCFG=%MEMORY_EXTCFG% -DTRACE_EXTCFG=%TRACE_EXTCFG% -DFEEDBACK_EXTCFG=%FEEDBACK_EXTCFG% ../..  >> %OUTFILE% 
if %ERRORLEVEL% equ 0 (
    %PRINTF% "[Ok]\n"
) else (
    %PRINTF% "[Error!]\n"
)


%PRINTF% "[#Compile#]\n"  >> %OUTFILE% 
%PRINTF% "Compilate project   %%-16s ... " "%~2" 
ninja  >> %OUTFILE%
if %ERRORLEVEL% equ 0 (
    %PRINTF% "[Ok]\n"
) else (
    %PRINTF% "[Error!]\n"
)


if exist "%~2tests.exe" (
  %PRINTF% "[#Tests#]\n"  >> %OUTFILE% 
  %PRINTF% "Test project        %%-16s ... " "%~2" 
  %~2tests.exe >> %OUTFILE%
    
  if %ERRORLEVEL% equ 5 (
    %PRINTF% "[Ok]\n" 
  ) else (
    %PRINTF% "[Error!]\n"
  )
)

%PRINTF% " \n" 

cd "%OLDPATH%"



