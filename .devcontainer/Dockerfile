FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl git build-essential pkg-config cmake \
    python3 python3-pip xz-utils ca-certificates \
    libxcb1-dev libx11-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ARG ZIG_VERSION=0.14.0
RUN curl -LO https://ziglang.org/download/${ZIG_VERSION}/zig-linux-x86_64-${ZIG_VERSION}.tar.xz && \
    tar -xf zig-linux-x86_64-${ZIG_VERSION}.tar.xz && \
    mv zig-linux-x86_64-${ZIG_VERSION} /opt/zig && \
    ln -s /opt/zig/zig /usr/local/bin/zig && \
    rm zig-linux-x86_64-${ZIG_VERSION}.tar.xz

RUN git clone https://github.com/zigtools/zls.git --branch "0.14.0" /opt/zls && \
    cd /opt/zls && \
    /opt/zig/zig build -Doptimize=ReleaseSsafe && \
    ln -s /opt/zls/zig-out/bin/zls /usr/local/bin/zls

RUN useradd -m devuser
USER devuser
WORKDIR /home/devuser

SHELL ["/bin/bash", "-c"]
