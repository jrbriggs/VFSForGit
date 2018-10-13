@ECHO OFF
IF NOT "%VFS_DEVSHELL%"=="true" (
  ECHO ERROR: This shell is not a VFS for Git developer shell
  ECHO Run init.cmd or init.ps1 at the root of the repository.
  EXIT /b 10
)

IF "%1"=="" (SET "Configuration=Debug") ELSE (SET "Configuration=%1")

set RESULT=0

%VFS_OUTPUTDIR%\GVFS.UnitTests.Windows\bin\x64\%Configuration%\GVFS.UnitTests.Windows.exe  || set RESULT=1
dotnet %VFS_OUTPUTDIR%\GVFS.UnitTests\bin\x64\%Configuration%\netcoreapp2.1\GVFS.UnitTests.dll  || set RESULT=1

exit /b %RESULT%