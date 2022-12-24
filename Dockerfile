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
    echo "collection-basic ${TEXLIVE_COLLECTION_BASIC}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-bibtexextra ${TEXLIVE_COLLECTION_BIBTEXEXTRA}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-binextra ${TEXLIVE_COLLECTION_BINEXTRA}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-context ${TEXLIVE_COLLECTION_CONTEXT}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-fontsextra ${TEXLIVE_COLLECTION_FONTSEXTRA}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-fontsrecommended ${TEXLIVE_COLLECTION_FONTSRECOMMENDED}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-fontutils ${TEXLIVE_COLLECTION_FONTUTILS}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-formatsextra ${TEXLIVE_COLLECTION_FORMATSEXTRA}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-games ${TEXLIVE_COLLECTION_GAMES}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-humanities ${TEXLIVE_COLLECTION_HUMANITIES}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-langarabic ${TEXLIVE_COLLECTION_LANGARABIC}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-langchinese ${TEXLIVE_COLLECTION_LANGCHINESE}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-langcjk ${TEXLIVE_COLLECTION_LANGCJK}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-langcyrillic ${TEXLIVE_COLLECTION_LANGCYRILLIC}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-langczechslovak ${TEXLIVE_COLLECTION_LANGCZECHSLOVAK}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-langenglish ${TEXLIVE_COLLECTION_LANGENGLISH}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-langeuropean ${TEXLIVE_COLLECTION_LANGEUROPEAN}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-langfrench ${TEXLIVE_COLLECTION_LANGFRENCH}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-langgerman ${TEXLIVE_COLLECTION_LANGGERMAN}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-langgreek ${TEXLIVE_COLLECTION_LANGGREEK}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-langitalian ${TEXLIVE_COLLECTION_LANGITALIAN}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-langjapanese ${TEXLIVE_COLLECTION_LANGJAPANESE}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-langkorean ${TEXLIVE_COLLECTION_LANGKOREAN}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-langother ${TEXLIVE_COLLECTION_LANGOTHER}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-langpolish ${TEXLIVE_COLLECTION_LANGPOLISH}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-langportuguese ${TEXLIVE_COLLECTION_LANGPORTUGUESE}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-langspanish ${TEXLIVE_COLLECTION_LANGSPANISH}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-latex ${TEXLIVE_COLLECTION_LATEX}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-latexextra ${TEXLIVE_COLLECTION_LATEXEXTRA}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-latexrecommended ${TEXLIVE_COLLECTION_LATEXRECOMMENDED}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-luatex ${TEXLIVE_COLLECTION_LUATEX}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-mathscience ${TEXLIVE_COLLECTION_MATHSCIENCE}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-metapost ${TEXLIVE_COLLECTION_METAPOST}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-music ${TEXLIVE_COLLECTION_MUSIC}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-pictures ${TEXLIVE_COLLECTION_PICTURES}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-plaingeneric ${TEXLIVE_COLLECTION_PLAINGENERIC}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-pstricks ${TEXLIVE_COLLECTION_PSTRICKS}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-publishers ${TEXLIVE_COLLECTION_PUBLISHERS}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-texworks ${TEXLIVE_COLLECTION_TEXWORKS}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-wintools ${TEXLIVE_COLLECTION_WINTOOLS}" >> /tmp/install-tl-unx/texlive.profile && \
    echo "collection-xetex ${TEXLIVE_COLLECTION_XETEX}" >> /tmp/install-tl-unx/texlive.profile && \
    sudo /tmp/install-tl-unx/install-tl -profile /tmp/install-tl-unx/texlive.profile && \
    [ -n ${TEXLIVE_EXTRA_PACKAGES} ] && sudo $(find /usr/local/texlive -name tlmgr) install ${TEXLIVE_EXTRA_PACKAGES} && \
    sudo $(find /usr/local/texlive -name tlmgr) path add && \

    # Clean up
    sudo apt-get -y clean && \
    rm -f ./${LILYPOND_INSTALLER} ./install-tl-unx.tar.gz