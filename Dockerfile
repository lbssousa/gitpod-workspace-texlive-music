FROM gitpod/workspace-base:2022-12-15-12-38-23

RUN ./lilypond-install.sh && ./texlive-install.sh