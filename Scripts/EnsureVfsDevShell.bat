@ECHO OFF
IF NOT "%VFS_DEVSHELL%"=="true" (
  ECHO ERROR: This shell is not a VFS for Git developer shell.
  ECHO Run init.cmd or init.ps1 at the root of the repository.
  EXIT /b 10
)
