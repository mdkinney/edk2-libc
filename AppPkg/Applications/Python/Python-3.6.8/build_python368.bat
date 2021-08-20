@echo off

set TOOL_CHAIN_TAG=%1
set TARGET=%2
if "%TOOL_CHAIN_TAG%"=="" goto usage
if "%TARGET%"=="" goto usage
goto continue

:usage
echo.
echo.
echo.
echo Build Python from EDK2. 
echo.
echo Usage: %0 "<ToolChain> <Target>"
echo.
echo    ToolChain  = one of VS2013x86, VS2015x86, VS2017
echo    Target     = one of RELEASE, DEBUG
echo.
echo.
echo.

goto :eof

:continue
cd ..\..\..\..\
@call edksetup.bat

build -m AppPkg\Applications\Python\Python-3.6.8\Python368.inf -p AppPkg\AppPkg.dsc -a X64 -t %TOOL_CHAIN_TAG% -b %TARGET%
set ec=%errorlevel%
if "%ec%"=="0" goto build_ok
goto all_done


:build_ok
@echo %WORKSPACE%\Build\AppPkg\%TARGET%_%TOOL_CHAIN_TAG%\X64\Python368.efi


:all_done
exit /b %ec%




