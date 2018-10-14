@ECHO OFF
CALL %~dp0\EnsureVfsDevShell.bat || EXIT /b 10

IF "%1"=="" ( SET "Configuration=Debug" ) ELSE ( SET "Configuration=%1")
IF "%2"=="" ( SET "VFS_STAGEDIR=%BUILD_ARTIFACTSTAGINGDIRECTORY%\Tests" ) ELSE ( SET "VFS_STAGEDIR=%2" )

SETLOCAL enableextensions

REM Prepare the staging directories for functional tests.
IF EXIST %VFS_STAGEDIR% (
  rmdir /s /q %VFS_STAGEDIR%
)
mkdir %VFS_STAGEDIR%\src\Scripts
mkdir %VFS_STAGEDIR%\BuildOutput\GVFS.Build
mkdir %VFS_STAGEDIR%\BuildOutput\GVFS.FunctionalTests\bin\x64\%Configuration%\netcoreapp2.1
mkdir %VFS_STAGEDIR%\BuildOutput\GVFS.FunctionalTests.Windows\bin\x64\%Configuration%\

REM Make a minimal 'test' enlistment to pass along our pipeline.
copy %VFS_SRCDIR%\init.cmd %VFS_STAGEDIR%\src\
copy %VFS_SCRIPTSDIR%\*.* %VFS_STAGEDIR%\src\Scripts\
copy %VFS_OUTPUTDIR%\GVFS.Build\*.* %VFS_STAGEDIR%\BuildOutput\GVFS.Build
copy %VFS_OUTPUTDIR%\GVFS.FunctionalTests\bin\x64\%Configuration%\netcoreapp2.1\*.* %VFS_STAGEDIR%\BuildOutput\GVFS.FunctionalTests\bin\x64\%Configuration%\netcoreapp2.1\
copy %VFS_OUTPUTDIR%\GVFS.FunctionalTests.Windows\bin\x64\%Configuration%\*.* %VFS_STAGEDIR%\BuildOutput\GVFS.FunctionalTests.Windows\bin\x64\%Configuration%\