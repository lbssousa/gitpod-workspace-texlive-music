FROM gitpod/workspace-base:2022-12-15-12-38-23

ARG LILYPOND_VERSION=2.22.2
ARG LILYPOND_INSTALLER=lilypond-${LILYPOND_VERSION}-1.linux-64.sh
ARG TEXLIVE_VERSION=2022
ARG TEXLIVE_SCHEME=minimal
ARG TEXLIVE_COLLECTION_BASIC=false
ARG TEXLIVE_COLLECTION_BIBTEXEXTRA=false
ARG TEXLIVE_COLLECTION_BINEXTRA=false
ARG TEXLIVE_COLLECTION_CONTEXT=false
ARG TEXLIVE_COLLECTION_FONTSEXTRA=false
ARG TEXLIVE_COLLECTION_FONTSRECOMMENDED=false
ARG TEXLIVE_COLLECTION_FONTUTILS=false
ARG TEXLIVE_COLLECTION_FORMATSEXTRA=false
ARG TEXLIVE_COLLECTION_GAMES=false
ARG TEXLIVE_COLLECTION_HUMANITIES=false
ARG TEXLIVE_COLLECTION_LANGARABIC=false
ARG TEXLIVE_COLLECTION_LANGCHINESE=false
ARG TEXLIVE_COLLECTION_LANGCJK=false
ARG TEXLIVE_COLLECTION_LANGCYRILLIC=false
ARG TEXLIVE_COLLECTION_LANGCZECHSLOVAK=false
ARG TEXLIVE_COLLECTION_LANGENGLISH=false
ARG TEXLIVE_COLLECTION_LANGEUROPEAN=false
ARG TEXLIVE_COLLECTION_LANGFRENCH=false
ARG TEXLIVE_COLLECTION_LANGGERMAN=false
ARG TEXLIVE_COLLECTION_LANGGREEK=false
ARG TEXLIVE_COLLECTION_LANGITALIAN=false
ARG TEXLIVE_COLLECTION_LANGJAPANESE=false
ARG TEXLIVE_COLLECTION_LANGKOREAN=false
ARG TEXLIVE_COLLECTION_LANGOTHER=false
ARG TEXLIVE_COLLECTION_LANGPOLISH=false
ARG TEXLIVE_COLLECTION_LANGPORTUGUESE=false
ARG TEXLIVE_COLLECTION_LANGSPANISH=false
ARG TEXLIVE_COLLECTION_LATEX=false
ARG TEXLIVE_COLLECTION_LATEXEXTRA=false
ARG TEXLIVE_COLLECTION_LATEXRECOMMENDED=false
ARG TEXLIVE_COLLECTION_LUATEX=false
ARG TEXLIVE_COLLECTION_MATHSCIENCE=false
ARG TEXLIVE_COLLECTION_METAPOST=false
ARG TEXLIVE_COLLECTION_MUSIC=false
ARG TEXLIVE_COLLECTION_PICTURES=false
ARG TEXLIVE_COLLECTION_PLAINGENERIC=false
ARG TEXLIVE_COLLECTION_PSTRICKS=false
ARG TEXLIVE_COLLECTION_PUBLISHERS=false
ARG TEXLIVE_COLLECTION_TEXWORKS=false
ARG TEXLIVE_COLLECTION_WINTOOLS=false
ARG TEXLIVE_COLLECTION_XETEX=false
ARG TEXLIVE_EXTRA_PACKAGES="babel-latin babel-portuges chktex ebgaramond enumitem epstopdf-pkg etoolbox fancyhdr fontspec geometry gregoriotex grfext hyperref hyphen-english hyphen-latin hyphen-portuguese infwarerr kvoptions latex-bin latexindent latexmk luacolor luamplib luatexbase lyluatex memoir metapost microtype musixtex musixtex-fonts m-tx paracol pdftexcmds pmx texcount titlesec tools xcolor xkeyval xstring"

# Install LilyPond
RUN sudo apt-get update -y && \
    sudo apt-get -y install --no-install-recommends bzip2 ca-certificates curl && \
    curl -O https://lilypond.org/download/binaries/linux-64/${LILYPOND_INSTALLER} && \
    sudo sh ./${LILYPOND_INSTALLER} --batch && \
    rm -f ./${LILYPOND_INSTALLER} && \
    sudo apt-get -y clean

# Install TeX Live
RUN sudo apt-get update -y && \
    sudo apt-get -y install --no-install-recommends bzip2 ca-certificates curl libfile-homedir-perl libunicode-linebreak-perl libyaml-tiny-perl perl-doc && \
    if [ "${TEXLIVE_VERSION}" = "latest" ]; then \
        URL="http://mirror.ctan.org/systems/texlive/tlnet"; \
    else \
        URL="http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/${TEXLIVE_VERSION}"; \
    fi && \
    curl -O ${URL}/install-tl-unx.tar.gz && \
    mkdir /tmp/install-tl-unx && \
    tar -xzvf install-tl-unx.tar.gz -C /tmp/install-tl-unx --strip-components=1 && \
    echo "selected_scheme scheme-${TEXLIVE_SCHEME}" > /tmp/install-tl-unx/texlive.profile && \
    ( ${TEXLIVE_COLLECTION_BASIC} && echo "collection-basic 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_BIBTEXEXTRA} && echo "collection-bibtexextra 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_BINEXTRA} && echo "collection-binextra 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_CONTEXT} && echo "collection-context 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_FONTSEXTRA} && echo "collection-fontsextra 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_FONTSRECOMMENDED} && echo "collection-fontsrecommended 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_FONTUTILS} && echo "collection-fontutils 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_FORMATSEXTRA} && echo "collection-formatsextra 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_GAMES} && echo "collection-games 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_HUMANITIES} && echo "collection-humanities 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_LANGARABIC} && echo "collection-langarabic 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_LANGCHINESE} && echo "collection-langchinese 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_LANGCJK} && echo "collection-langcjk 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_LANGCYRILLIC} && echo "collection-langcyrillic 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_LANGCZECHSLOVAK} && echo "collection-langczechslovak 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_LANGENGLISH} && echo "collection-langenglish 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_LANGEUROPEAN} && echo "collection-langeuropean 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_LANGFRENCH} && echo "collection-langfrench 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_LANGGERMAN} && echo "collection-langgerman 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_LANGGREEK} && echo "collection-langgreek 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_LANGITALIAN} && echo "collection-langitalian 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_LANGJAPANESE} && echo "collection-langjapanese 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_LANGKOREAN} && echo "collection-langkorean 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_LANGOTHER} && echo "collection-langother 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_LANGPOLISH} && echo "collection-langpolish 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_LANGPORTUGUESE} && echo "collection-langportuguese 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_LANGSPANISH} && echo "collection-langspanish 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_LATEX} && echo "collection-latex 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_LATEXEXTRA} && echo "collection-latexextra 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_LATEXRECOMMENDED} && echo "collection-latexrecommended 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_LUATEX} && echo "collection-luatex 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_MATHSCIENCE} && echo "collection-mathscience 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_METAPOST} && echo "collection-metapost 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_MUSIC} && echo "collection-music 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_PICTURES} && echo "collection-pictures 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_PLAINGENERIC} && echo "collection-plaingeneric 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_PSTRICKS} && echo "collection-pstricks 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_PUBLISHERS} && echo "collection-publishers 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_TEXWORKS} && echo "collection-texworks 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_WINTOOLS} && echo "collection-wintools 1" >> /tmp/install-tl-unx/texlive.profile; \
    ${TEXLIVE_COLLECTION_XETEX} && echo "collection-xetex 1" >> /tmp/install-tl-unx/texlive.profile ) && \
    sudo /tmp/install-tl-unx/install-tl -profile /tmp/install-tl-unx/texlive.profile && \
    ( [ -n ${TEXLIVE_EXTRA_PACKAGES} ] && sudo $(find /usr/local/texlive -name tlmgr) install ${TEXLIVE_EXTRA_PACKAGES} ) && \
    sudo $(find /usr/local/texlive -name tlmgr) path add && \
    rm -f ./install-tl-unx.tar.gz && \
    sudo apt-get -y clean
