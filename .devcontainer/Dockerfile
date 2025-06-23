FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl git build-essential pkg-config cmake \
    python3 python3-pip xz-utils ca-certificates \
    libxcb1-dev libx11-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ARG ZIG_VERSION=0.14.1
RUN curl -LO https://ziglang.org/download/${ZIG_VERSION}/zig-x86_64-linux-${ZIG_VERSION}.tar.xz && \
    tar -xf zig-x86_64-linux-${ZIG_VERSION}.tar.xz && \
    mv zig-x86_64-linux-${ZIG_VERSION} /opt/zig && \
    ln -s /opt/zig/zig /usr/local/bin/zig && \
    rm zig-x86_64-linux-${ZIG_VERSION}.tar.xz

RUN git clone https://github.com/zigtools/zls.git /opt/zls && \
    cd /opt/zls && \
    /opt/zig/zig build -Drelease-safe && \
    ln -s /opt/zls/zig-out/bin/zls /usr/local/bin/zls

RUN useradd -m devuser
USER devuser
WORKDIR /home/devuser

SHELL ["/bin/bash", "-c"]
