
FROM ghcr.io/homebrew/ubuntu20.04:latest

ENV \
    LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8"

RUN mkdir -p /usr/local
COPY "./util_scripts" "/usr/local/util_scripts"

RUN brew update && \
    brew upgrade && \
    brew install bzip2 xz lz4 zlib zstd && \
    brew install python@3.11 python@3.12 gzip p7zip lhasa bash curl gnu-tar openssl unzip gpatch dos2unix perl bc autoconf automake libtool pkg-config bison node git make nasm cmake ninja mingw-w64 meson && \
    brew cleanup -s && \
    rm -rf $(brew --cache)
RUN curl -LO https://github.com/mstorsjo/llvm-mingw/releases/download/20250319/llvm-mingw-20250319-msvcrt-ubuntu-20.04-x86_64.tar.xz && \
    tar xf llvm-mingw-20250319-msvcrt-ubuntu-20.04-x86_64.tar.xz && \
    sudo mv llvm-mingw-20250319-msvcrt-ubuntu-20.04-x86_64 /opt/llvm-mingw && \
    rm llvm-mingw-20250319-msvcrt-ubuntu-20.04-x86_64.tar.xz
RUN sudo dpkg --add-architecture i386 && \
    sudo apt-get update && \
    sudo apt-get upgrade -y && \
    sudo apt-get -o apt::install-recommends=true install wine wine32 wine64 wine64-tools fonts-wine -y && \
    sudo apt-get install xvfb libgl1-mesa-glx libgl1-mesa-glx:i386 libgl1:i386 libglx-mesa0:i386 libgl1-mesa-dri:i386 unzip fonts-liberation openbox x11-utils -y

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
    org.label-schema.version="0.0.3" \
    org.label-schema.docker.cmd="docker container run --interactive --rm --tty ghcr.io/uyjulian/tvp_win32_build_container:latest" \
    org.label-schema.docker.cmd.test="docker container run --interactive --rm --tty ghcr.io/uyjulian/tvp_win32_build_container:latest /bin/true"

CMD ["/home/linuxbrew/.linuxbrew/bin/bash"]
