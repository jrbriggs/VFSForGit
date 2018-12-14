. "$(dirname ${BASH_SOURCE[0]})/InitializeEnvironment.sh"

pkill -9 -l GVFS.FunctionalTests
pkill -9 -l git
pkill -9 -l gvfs
pkill -9 -l prjfs-log

$VFS_SRCDIR/ProjFS.Mac/Scripts/UnloadPrjFSKext.sh

sudo rm -r /GVFS.FT
