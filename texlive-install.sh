#!/bin/sh
set -e

install_debian_packages() {
    if ! dpkg -s "${@}" > /dev/null 2>&1
    then
        # Taken from https://github.com/devcontainers/features/blob/main/src/go/install.sh
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]
        then
            echo "Running apt-get update..."
            apt-get update -y
        fi

        apt-get -y install --no-install-recommends "${@}"
    fi
}

install_alpine_packages() {
    apk update
    apk add --no-cache "${@}"
}

# Back up selected TeX Live version before loading /etc/os-release
TL_VERSION="${VERSION:-latest}"

if [ "${VERSION}" = "latest" ]
then
    URL="http://mirror.ctan.org/systems/texlive/tlnet"
else
    URL="http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/${TL_VERSION}"
fi

# Bring in ID, ID_LIKE, VERSION_ID, VERSION_CODENAME
. /etc/os-release
# Get an adjusted ID independant of distro variants
if [ "${ID}" = "debian" ] || [ "${ID_LIKE}" = "debian" ]
then
    ADJUSTED_ID="debian"
elif [[ "${ID}" = "rhel" || "${ID}" = "fedora" || "${ID}" = "mariner" || "${ID_LIKE}" = *"rhel"* || "${ID_LIKE}" = *"fedora"* || "${ID_LIKE}" = *"mariner"* ]]
then
    ADJUSTED_ID="rhel"
elif [ "${ID}" = "alpine" ]
then
    ADJUSTED_ID="alpine"
else
    echo "Linux distro ${ID} not supported."
    exit 1
fi

case "${ADJUSTED_ID}" in
debian)
    install_debian_packages ca-certificates libfile-homedir-perl libunicode-linebreak-perl libyaml-tiny-perl perl-doc wget
    ;;
alpine)
    install_alpine_packages ca-certificates curl make perl perl-dev wget
    # perl-doc perl-file-homedir perl-unicode-linebreak perl-yaml-tiny
    cpan App:cpanminus
    cpanm --no-wget YAML::Tiny
    cpanm --no-wget File::HomeDir
    ;;
rhel)
    echo "RPM-based Linux distros not yet supported."
    exit 1
esac

echo "Downloading TeX Live installer (${TL_VERSION})..."
wget ${URL}/install-tl-unx.tar.gz
mkdir /tmp/install-tl-unx
tar -xzvf install-tl-unx.tar.gz -C /tmp/install-tl-unx --strip-components=1

echo "selected_scheme scheme-${SCHEME}" > /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_BASIC}) && echo "collection-basic 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_BIBTEXEXTRA}) && echo "collection-bibtexextra 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_BINEXTRA}) && echo "collection-binextra 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_CONTEXT}) && echo "collection-context 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_FONTSEXTRA}) && echo "collection-fontsextra 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_FONTSRECOMMENDED}) && echo "collection-fontsrecommended 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_FONTUTILS}) && echo "collection-fontutils 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_FORMATSEXTRA}) && echo "collection-formatsextra 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_GAMES}) && echo "collection-games 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_HUMANITIES}) && echo "collection-humanities 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_LANGARABIC}) && echo "collection-langarabic 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_LANGCHINESE}) && echo "collection-langchinese 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_LANGCJK}) && echo "collection-langcjk 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_LANGCYRILLIC}) && echo "collection-langcyrillic 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_LANGCZECHSLOVAK}) && echo "collection-langczechslovak 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_LANGENGLISH}) && echo "collection-langenglish 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_LANGEUROPEAN}) && echo "collection-langeuropean 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_LANGFRENCH}) && echo "collection-langfrench 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_LANGGERMAN}) && echo "collection-langgerman 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_LANGGREEK}) && echo "collection-langgreek 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_LANGITALIAN}) && echo "collection-langitalian 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_LANGJAPANESE}) && echo "collection-langjapanese 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_LANGKOREAN}) && echo "collection-langkorean 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_LANGOTHER}) && echo "collection-langother 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_LANGPOLISH}) && echo "collection-langpolish 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_LANGPORTUGUESE}) && echo "collection-langportuguese 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_LANGSPANISH}) && echo "collection-langspanish 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_LATEX}) && echo "collection-latex 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_LATEXEXTRA}) && echo "collection-latexextra 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_LATEXRECOMMENDED}) && echo "collection-latexrecommended 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_LUATEX}) && echo "collection-luatex 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_MATHSCIENCE}) && echo "collection-mathscience 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_METAPOST}) && echo "collection-metapost 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_MUSIC}) && echo "collection-music 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_PICTURES}) && echo "collection-pictures 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_PLAINGENERIC}) && echo "collection-plaingeneric 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_PSTRICKS}) && echo "collection-pstricks 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_PUBLISHERS}) && echo "collection-publishers 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_TEXWORKS}) && echo "collection-texworks 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_WINTOOLS}) && echo "collection-wintools 1" >> /tmp/install-tl-unx/texlive.profile
$(${COLLECTION_XETEX}) && echo "collection-xetex 1" >> /tmp/install-tl-unx/texlive.profile

echo "Reviewing texlive.profile..."
cat /tmp/install-tl-unx/texlive.profile

echo "Installing TeX Live..."
/tmp/install-tl-unx/install-tl -profile /tmp/install-tl-unx/texlive.profile
TLMGR=$(find /usr/local/texlive -name tlmgr)
echo "tlmgr path: ${TLMGR}"

if [ "x${EXTRA_PACKAGES}x" != "xx" ]
then
    echo "Installing extra packages..."
    ${TLMGR} install ${EXTRA_PACKAGES}
fi

echo "Creating symlinks to TeX Live binaries under system PATH..."
${TLMGR} path add || true

echo "Done!"