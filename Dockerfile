FROM gitpod/workspace-base:2022-12-15-12-38-23

ARG LILYPOND_VERSION=2.24.0
ARG LILYPOND_PACKAGE=lilypond-${LILYPOND_VERSION}-linux-x86_64.tar.gz
ARG LILYPOND_SHA256=5ed6ced6ade894b6dc1db35474b5e82a175a1149d34f16e75aaa9d885d9d3f6a
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
    curl -LO https://gitlab.com/lilypond/lilypond/-/releases/v${LILYPOND_VERSION}/downloads/${LILYPOND_PACKAGE} && \
    [ $(sha256sum ${LILYPOND_PACKAGE} | cut -d' ' -f1) = ${LILYPOND_SHA256} ] && \
    tar xzvf ${LILYPOND_PACKAGE} -C /opt && \
    for bin in /opt/lilypond-${LILYPOND_VERSION}/bin/*; do \
        sudo ln -s ${bin} /usr/local/bin; \
    done && \
    rm -f ./${LILYPOND_PACKAGE} && \
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
    if ${TEXLIVE_COLLECTION_BASIC}; then echo "collection-basic 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_BIBTEXEXTRA}; then echo "collection-bibtexextra 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_BINEXTRA}; then echo "collection-binextra 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_CONTEXT}; then echo "collection-context 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_FONTSEXTRA}; then echo "collection-fontsextra 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_FONTSRECOMMENDED}; then echo "collection-fontsrecommended 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_FONTUTILS}; then echo "collection-fontutils 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_FORMATSEXTRA}; then echo "collection-formatsextra 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_GAMES}; then echo "collection-games 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_HUMANITIES}; then echo "collection-humanities 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_LANGARABIC}; then echo "collection-langarabic 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_LANGCHINESE}; then echo "collection-langchinese 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_LANGCJK}; then echo "collection-langcjk 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_LANGCYRILLIC}; then echo "collection-langcyrillic 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_LANGCZECHSLOVAK}; then echo "collection-langczechslovak 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_LANGENGLISH}; then echo "collection-langenglish 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_LANGEUROPEAN}; then echo "collection-langeuropean 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_LANGFRENCH}; then echo "collection-langfrench 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_LANGGERMAN}; then echo "collection-langgerman 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_LANGGREEK}; then echo "collection-langgreek 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_LANGITALIAN}; then echo "collection-langitalian 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_LANGJAPANESE}; then echo "collection-langjapanese 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_LANGKOREAN}; then echo "collection-langkorean 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_LANGOTHER}; then echo "collection-langother 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_LANGPOLISH}; then echo "collection-langpolish 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_LANGPORTUGUESE}; then echo "collection-langportuguese 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_LANGSPANISH}; then echo "collection-langspanish 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_LATEX}; then echo "collection-latex 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_LATEXEXTRA}; then echo "collection-latexextra 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_LATEXRECOMMENDED}; then echo "collection-latexrecommended 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_LUATEX}; then echo "collection-luatex 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_MATHSCIENCE}; then echo "collection-mathscience 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_METAPOST}; then echo "collection-metapost 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_MUSIC}; then echo "collection-music 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_PICTURES}; then echo "collection-pictures 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_PLAINGENERIC}; then echo "collection-plaingeneric 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_PSTRICKS}; then echo "collection-pstricks 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_PUBLISHERS}; then echo "collection-publishers 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_TEXWORKS}; then echo "collection-texworks 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_WINTOOLS}; then echo "collection-wintools 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    if ${TEXLIVE_COLLECTION_XETEX}; then echo "collection-xetex 1" >> /tmp/install-tl-unx/texlive.profile; fi && \
    sudo /tmp/install-tl-unx/install-tl -profile /tmp/install-tl-unx/texlive.profile && \
    if [ -n "${TEXLIVE_EXTRA_PACKAGES}" ]; then sudo $(find /usr/local/texlive -name tlmgr) install ${TEXLIVE_EXTRA_PACKAGES}; fi && \
    sudo $(find /usr/local/texlive -name tlmgr) path add && \
    rm -f ./install-tl-unx.tar.gz && \
    sudo apt-get -y clean
