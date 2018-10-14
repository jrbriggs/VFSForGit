@ECHO OFF
IF NOT "%VFS_DEVSHELL%"=="true" (
  ECHO ERROR: This shell is not a VFS for Git developer shell
  ECHO Run init.cmd or init.ps1 at the root of the repository.
  EXIT /b 10
)

SETLOCAL

SET nuget="%VFS_TOOLSDIR%\nuget.exe"
IF NOT EXIST %nuget% (
  mkdir %nuget%\..
  powershell -ExecutionPolicy Bypass -Command "Invoke-WebRequest 'https://dist.nuget.org/win-x86-commandline/latest/nuget.exe' -OutFile %nuget%"
)

%nuget% restore %VFS_SRCDIR%\GVFS.sln || exit /b 1

dotnet restore %VFS_SRCDIR%\GVFS\GVFS.Common\GVFS.Common.csproj || exit /b 1
dotnet restore %VFS_SRCDIR%\GVFS\GVFS.Virtualization\GVFS.Virtualization.csproj || exit /b 1

ENDLOCAL