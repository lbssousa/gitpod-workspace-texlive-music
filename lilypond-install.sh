#!/bin/sh
set -e

LILYPOND_VERSION=${VERSION:-2.22.2}-1
LILYPOND_INSTALLER=lilypond-${LILYPOND_VERSION}.linux-64.sh

# Taken from https://github.com/devcontainers/features/blob/main/src/go/install.sh
apt_get_update()
{
    if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]
    then
        echo "Running apt-get update..."
        apt-get update -y
    fi
}

# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "${@}" > /dev/null 2>&1
    then
        apt_get_update
        apt-get -y install --no-install-recommends "${@}"
    fi
}

check_packages curl ca-certificates bzip2

echo "Downloading LilyPond installer, version ${LILYPOND_VERSION}..."
curl -O https://lilypond.org/download/binaries/linux-64/${LILYPOND_INSTALLER}

echo "Running LilyPond installer..."
sh ./${LILYPOND_INSTALLER} --batch

# Clean up
rm -f ./${LILYPOND_INSTALLER}
rm -rf /var/lib/apt/lists/*

echo "Done!"