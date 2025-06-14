ARG BUILD_FROM
FROM $BUILD_FROM AS builder

# Install dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  curl \
  git \
  libssl-dev \
  pkg-config \
  libpq-dev \
  ca-certificates \
  netcat-traditional

# Install Rust (via rustup)
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:$PATH"

# Clone and build Atuin
RUN git clone --branch v18.6.1 https://github.com/atuinsh/atuin.git /atuin

WORKDIR /atuin
RUN cargo build --release --package atuin-server

# Target image to run it
FROM $BUILD_FROM

# Install runtime deps
RUN apt-get update && apt-get install -y \
  libssl-dev \
  libpq-dev \
  netcat-traditional && \
  rm -rf /var/lib/apt/lists/*

COPY --from=builder /atuin/target/release/atuin-server /usr/bin/atuin-server

WORKDIR /opt/atuin

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
