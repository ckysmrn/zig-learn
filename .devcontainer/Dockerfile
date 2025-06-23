
# Zig + ZLS DevContainer
FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
#RUN apt-get update && apt-get install -y \
#    curl git build-essential pkg-config \
#    ca-certificates libstdc++-dev \
#    cmake python3 python3-pip \
#    libxcb1-dev libx11-dev xz-utils \
#    && apt-get clean

# Install Zig (latest stable)
#ARG ZIG_VERSION=0.14.1
#RUN curl -LO https://ziglang.org/download/${ZIG_VERSION}/zig-x86_64-linux-${ZIG_VERSION}.tar.xz && \
#    tar -xf zig-x86_64-linux-${ZIG_VERSION}.tar.xz && \
#    mv zig-x86_64-linux-${ZIG_VERSION} /opt/zig && \
#    ln -s /opt/zig/zig /usr/local/bin/zig && \
#    rm zig-x86_64-linux-${ZIG_VERSION}.tar.xz
#
## Install ZLS (Zig Language Server)
#RUN git clone https://github.com/zigtools/zls /opt/zls && \
#    cd /opt/zls && \
#    /opt/zig/zig build -Drelease-safe && \
#    ln -s /opt/zls/zig-out/bin/zls /usr/local/bin/zls

# Setup user (for Codespaces)
RUN useradd -m vscode
USER vscode
WORKDIR /home/vscode
