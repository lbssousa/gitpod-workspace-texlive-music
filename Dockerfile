FROM gitpod/workspace-base:2022-12-15-12-38-23

ARG LILYPOND_VERSION=2.22.2
ARG LILYPOND_INSTALLER=lilypond-${LILYPOND_VERSION}-1.linux-64.sh
ARG TEXLIVE_VERSION=2022
ARG TEXLIVE_SCHEME=minimal
ARG TEXLIVE_COLLECTION_BASIC=0
ARG TEXLIVE_COLLECTION_BIBTEXEXTRA=0
ARG TEXLIVE_COLLECTION_BINEXTRA=0
ARG TEXLIVE_COLLECTION_CONTEXT=0
ARG TEXLIVE_COLLECTION_FONTSEXTRA=0
ARG TEXLIVE_COLLECTION_FONTSRECOMMENDED=0
ARG TEXLIVE_COLLECTION_FONTUTILS=0
ARG TEXLIVE_COLLECTION_FORMATSEXTRA=0
ARG TEXLIVE_COLLECTION_GAMES=0
ARG TEXLIVE_COLLECTION_HUMANITIES=0
ARG TEXLIVE_COLLECTION_LANGARABIC=0
ARG TEXLIVE_COLLECTION_LANGCHINESE=0
ARG TEXLIVE_COLLECTION_LANGCJK=0
ARG TEXLIVE_COLLECTION_LANGCYRILLIC=0
ARG TEXLIVE_COLLECTION_LANGCZECHSLOVAK=0
ARG TEXLIVE_COLLECTION_LANGENGLISH=0
ARG TEXLIVE_COLLECTION_LANGEUROPEAN=0
ARG TEXLIVE_COLLECTION_LANGFRENCH=0
ARG TEXLIVE_COLLECTION_LANGGERMAN=0
ARG TEXLIVE_COLLECTION_LANGGREEK=0
ARG TEXLIVE_COLLECTION_LANGITALIAN=0
ARG TEXLIVE_COLLECTION_LANGJAPANESE=0
ARG TEXLIVE_COLLECTION_LANGKOREAN=0
ARG TEXLIVE_COLLECTION_LANGOTHER=0
ARG TEXLIVE_COLLECTION_LANGPOLISH=0
ARG TEXLIVE_COLLECTION_LANGPORTUGUESE=0
ARG TEXLIVE_COLLECTION_LANGSPANISH=0
ARG TEXLIVE_COLLECTION_LATEX=0
ARG TEXLIVE_COLLECTION_LATEXEXTRA=0
ARG TEXLIVE_COLLECTION_LATEXRECOMMENDED=0
ARG TEXLIVE_COLLECTION_LUATEX=0
ARG TEXLIVE_COLLECTION_MATHSCIENCE=0
ARG TEXLIVE_COLLECTION_METAPOST=0
ARG TEXLIVE_COLLECTION_MUSIC=0
ARG TEXLIVE_COLLECTION_PICTURES=0
ARG TEXLIVE_COLLECTION_PLAINGENERIC=0
ARG TEXLIVE_COLLECTION_PSTRICKS=0
ARG TEXLIVE_COLLECTION_PUBLISHERS=0
ARG TEXLIVE_COLLECTION_TEXWORKS=0
ARG TEXLIVE_COLLECTION_WINTOOLS=0
ARG TEXLIVE_COLLECTION_XETEX=0
ARG TEXLIVE_EXTRA_PACKAGES="babel-latin babel-portuges chktex ebgaramond enumitem epstopdf-pkg etoolbox fancyhdr fontspec geometry gregoriotex grfext hyperref hyphen-english hyphen-latin hyphen-portuguese infwarerr kvoptions latex-bin latexindent latexmk luacolor luamplib luatexbase lyluatex memoir metapost microtype musixtex musixtex-fonts m-tx paracol pdftexcmds pmx texcount titlesec tools xcolor xkeyval xstring"

RUN sudo apt-get update -y && \
    sudo apt-get -y install --no-install-recommends bzip2 ca-certificates curl libfile-homedir-perl libunicode-linebreak-perl libyaml-tiny-perl perl-doc && \

    # Install LilyPond
    curl -O https://lilypond.org/download/binaries/linux-64/${LILYPOND_INSTALLER} && \
    sudo sh ./${LILYPOND_INSTALLER} --batch && \

    # Install TeX Live
    if [ "${TEXLIVE_VERSION}" = "latest" ]; then \
        URL="http://mirror.ctan.org/systems/texlive/tlnet"; \
    else \
        URL="http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/${TEXLIVE_VERSION}"; \
    fi && \
    curl -O ${URL}/install-tl-unx.tar.gz && \
    mkdir /tmp/install-tl-unx && \
    tar -xzvf install-tl-unx.tar.gz -C /tmp/install-tl-unx --strip-components=1 && \
    echo "selected_scheme scheme-${TEXLIVE_SCHEME}" > /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_BASIC} = 1 ] && echo "collection-basic 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_BIBTEXEXTRA} = 1 ] && echo "collection-bibtexextra 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_BINEXTRA} = 1 ] && echo "collection-binextra 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_CONTEXT} = 1 ] && echo "collection-context 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_FONTSEXTRA} = 1 ] && echo "collection-fontsextra 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_FONTSRECOMMENDED} = 1 ] && echo "collection-fontsrecommended 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_FONTUTILS} = 1 ] && echo "collection-fontutils 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_FORMATSEXTRA} = 1 ] && echo "collection-formatsextra 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_GAMES} = 1 ] && echo "collection-games 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_HUMANITIES} = 1 ] && echo "collection-humanities 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_LANGARABIC} = 1 ] && echo "collection-langarabic 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_LANGCHINESE} = 1 ] && echo "collection-langchinese 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_LANGCJK} = 1 ] && echo "collection-langcjk 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_LANGCYRILLIC} = 1 ] && echo "collection-langcyrillic 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_LANGCZECHSLOVAK} = 1 ] && echo "collection-langczechslovak 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_LANGENGLISH} = 1 ] && echo "collection-langenglish 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_LANGEUROPEAN} = 1 ] && echo "collection-langeuropean 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_LANGFRENCH} = 1 ] && echo "collection-langfrench 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_LANGGERMAN} = 1 ] && echo "collection-langgerman 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_LANGGREEK} = 1 ] && echo "collection-langgreek 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_LANGITALIAN} = 1 ] && echo "collection-langitalian 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_LANGJAPANESE} = 1 ] && echo "collection-langjapanese 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_LANGKOREAN} = 1 ] && echo "collection-langkorean 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_LANGOTHER} = 1 ] && echo "collection-langother 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_LANGPOLISH} = 1 ] && echo "collection-langpolish 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_LANGPORTUGUESE} = 1 ] && echo "collection-langportuguese 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_LANGSPANISH} = 1 ] && echo "collection-langspanish 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_LATEX} = 1 ] && echo "collection-latex 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_LATEXEXTRA} = 1 ] && echo "collection-latexextra 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_LATEXRECOMMENDED} = 1 ] && echo "collection-latexrecommended 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_LUATEX} = 1 ] && echo "collection-luatex 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_MATHSCIENCE} = 1 ] && echo "collection-mathscience 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_METAPOST} = 1 ] && echo "collection-metapost 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_MUSIC} = 1 ] && echo "collection-music 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_PICTURES} = 1 ] && echo "collection-pictures 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_PLAINGENERIC} = 1 ] && echo "collection-plaingeneric 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_PSTRICKS} = 1 ] && echo "collection-pstricks 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_PUBLISHERS} = 1 ] && echo "collection-publishers 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_TEXWORKS} = 1 ] && echo "collection-texworks 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_WINTOOLS} = 1 ] && echo "collection-wintools 1" >> /tmp/install-tl-unx/texlive.profile && \
    [ ${TEXLIVE_COLLECTION_XETEX} = 1 ] && echo "collection-xetex 1" >> /tmp/install-tl-unx/texlive.profile && \
    sudo /tmp/install-tl-unx/install-tl -profile /tmp/install-tl-unx/texlive.profile && \
    [ -n ${TEXLIVE_EXTRA_PACKAGES} ] && sudo $(find /usr/local/texlive -name tlmgr) install ${TEXLIVE_EXTRA_PACKAGES} && \
    sudo $(find /usr/local/texlive -name tlmgr) path add && \

    # Clean up
    sudo apt-get -y clean && \
    rm -f ./${LILYPOND_INSTALLER} ./install-tl-unx.tar.gz