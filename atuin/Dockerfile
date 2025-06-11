ARG BUILD_FROM
FROM $BUILD_FROM

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    pkg-config \
    libssl-dev \
    ca-certificates \
    libpq-dev

# Install Rust (via rustup)
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain 1.86.0
ENV PATH="/root/.cargo/bin:$PATH"

# Clone and build Atuin
RUN git clone --branch v18.6.1 https://github.com/atuinsh/atuin.git /atuin \
    && cd /atuin/server \
    && cargo build --release

# Copy built binary
RUN mkdir -p /opt/atuin \
    && cp /atuin/target/release/atuin-server /opt/atuin/atuin-server

WORKDIR /opt/atuin

# Copy startup script
COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD [ "/run.sh" ]
