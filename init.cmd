@ECHO OFF

REM Don't run inside of devenv shells
IF NOT "%VSCMD_VER%"=="" (
  ECHO ERROR: Do not run from a Developer Command prompt.
  ECHO Use a plain shell and try again.
  EXIT /b 10
)

REM Don't run twice
IF NOT "%VFS_DEVSHELL%"=="" (
    ECHO ERROR: This shell is already a VFS for Git developer shell.
    REM EXIT /b 10
)

REM Set source root to current directory
PUSHD %~dp0
SET VFS_SRCDIR=%CD%

REM Set output directory
CALL :RESOLVEPATH "%VFS_SRCDIR%\..\BuildOutput"
SET VFS_OUTPUTDIR=%_PARSED_PATH_%

REM Set packages directory
CALL :RESOLVEPATH "%VFS_SRCDIR%\..\packages"
SET VFS_PACKAGEDIR=%_PARSED_PATH_%

REM Set scripts directory
CALL :RESOLVEPATH "%VFS_SRCDIR%\Scripts"
SET VFS_SCRIPTSDIR=%_PARSED_PATH_%

REM Clean up
SET _PARSED_PATH_=

REM Mark this as a dev shell and load the macros
SET VFS_DEVSHELL=true
doskey /MACROFILE=.\Scripts\Macros.cmd.txt

ECHO ===============================================
ECHO * Welcome to the VFS for Git developer shell  *
ECHO *                                             *
ECHO * Build: b                                    *
ECHO * Build release: br                           *
ECHO * Run unit tests: ut                          *
ECHO * Run functional tests: ft                    *
ECHO ===============================================

GOTO :EOF

:RESOLVEPATH
SET "_PARSED_PATH_=%~f1"
GOTO :EOF