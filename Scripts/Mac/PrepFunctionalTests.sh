#!/bin/bash

. "$(dirname ${BASH_SOURCE[0]})/InitializeEnvironment.sh"

# Ensure the kext isn't loaded before installing Git
$VFS_SRCDIR/ProjFS.Mac/Scripts/UnloadPrjFSKext.sh

# Install GVFS-aware Git (that was published by the build script)
GITPUBLISH=$VFS_OUTPUTDIR/Git
if [[ ! -d $GITPUBLISH ]]; then
    echo "GVFS-aware Git package not found. Run BuildGVFSForMac.sh and try again"
    exit 1
fi
hdiutil attach $GITPUBLISH/*.dmg || exit 1
GITPKG="$(find /Volumes/Git* -type f -name *.pkg)" || exit 1
sudo installer -pkg "$GITPKG" -target / || exit 1
hdiutil detach /Volumes/Git*

# Install Homebrew if not installed
which -s brew
if [[ $? != 0 ]] ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install Java if not installed
which -s java
if [[ $? != 0 ]] ; then
    brew cask install java || exit 1
fi
brew cask info java
