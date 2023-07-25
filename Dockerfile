
FROM ghcr.io/homebrew/ubuntu18.04:latest

ENV \
    LANG="C.UTF-8" \
    LC_ALL="C.UTF-8"

RUN brew install bash curl gzip bzip2 xz zstd p7zip node git make nasm cmake ninja mingw-w64 && \
    brew cleanup -s
RUN curl -LO https://github.com/mstorsjo/llvm-mingw/releases/download/20220906/llvm-mingw-20220906-msvcrt-ubuntu-18.04-x86_64.tar.xz && \
    tar xf llvm-mingw-20220906-msvcrt-ubuntu-18.04-x86_64.tar.xz && \
    sudo mv llvm-mingw-20220906-msvcrt-ubuntu-18.04-x86_64 /opt/llvm-mingw && \
    rm llvm-mingw-20220906-msvcrt-ubuntu-18.04-x86_64.tar.xz

LABEL \
    org.opencontainers.image.source="https://github.com/uyjulian/tvp_win32_build_container" \
    maintainer="Julian Uy <https://uyjulian.github.io/>" \
    vendor="uyjulian" \
    cmd="docker container run --interactive --rm --tty ghcr.io/uyjulian/tvp_win32_build_container:latest" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.name="ghcr.io/uyjulian/tvp_win32_build_container" \
    org.label-schema.description="TVP Build Win32 Container" \
    org.label-schema.url="https://uyjulian.github.io/" \
    org.label-schema.vcs-url="https://github.com/uyjulian/tvp_win32_build_container" \
    org.label-schema.vendor="uyjulian" \
    org.label-schema.version="0.0.1" \
    org.label-schema.docker.cmd="docker container run --interactive --rm --tty ghcr.io/uyjulian/tvp_win32_build_container:latest" \
    org.label-schema.docker.cmd.test="docker container run --interactive --rm --tty ghcr.io/uyjulian/tvp_win32_build_container:latest /bin/true"

CMD ["/home/linuxbrew/.linuxbrew/bin/bash"]
