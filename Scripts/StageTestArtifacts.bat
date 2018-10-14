@ECHO OFF
CALL %~dp0\EnsureVfsDevShell.bat || EXIT /b 10

IF "%1"=="" ( SET "Configuration=Debug" ) ELSE ( SET "Configuration=%1")
IF "%2"=="" ( SET "VFS_STAGEDIR=%BUILD_ARTIFACTSTAGINGDIRECTORY%" ) ELSE ( SET "VFS_STAGEDIR=%2" )

SETLOCAL enableextensions

REM Prepare the staging directories for functional tests.
SET VFS_TESTSTAGE="%VFS_STAGEDIR%\Tests"
IF EXIST %VFS_TESTSTAGE% (
  rmdir /s /q %VFS_TESTSTAGE%
)
mkdir %VFS_TESTSTAGE%\src\Scripts
mkdir %VFS_TESTSTAGE%\BuildOutput\GVFS.FunctionalTests\bin\x64\%Configuration%\netcoreapp2.1
mkdir %VFS_TESTSTAGE%\BuildOutput\GVFS.FunctionalTests.Windows\bin\x64\%Configuration%\

REM Make a minimal 'test' enlistment to pass along our pipeline.
copy %VFS_SRCDIR%\init.cmd %VFS_TESTSTAGE%\src\
copy %VFS_SCRIPTSDIR%\*.* %VFS_TESTSTAGE%\src\Scripts\
copy %VFS_OUTPUTDIR%\GVFS.FunctionalTests\bin\x64\%Configuration%\netcoreapp2.1\*.* %VFS_TESTSTAGE%\BuildOutput\GVFS.FunctionalTests\bin\x64\%Configuration%\netcoreapp2.1\
copy %VFS_OUTPUTDIR%\GVFS.FunctionalTests.Windows\bin\x64\%Configuration%\*.* %VFS_TESTSTAGE%\BuildOutput\GVFS.FunctionalTests.Windows\bin\x64\%Configuration%\