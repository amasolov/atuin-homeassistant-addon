ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

# Install build dependencies
RUN apk add --no-cache git curl openssl cargo openssl-dev musl-dev

# Clone and build Atuin server
RUN git clone https://github.com/atuinsh/atuin.git /atuin \
    && cd /atuin/server \
    && cargo build --release

# Create application directory
RUN mkdir -p /opt/atuin \
    && cp /atuin/target/release/atuin-server /opt/atuin/atuin-server

WORKDIR /opt/atuin

# Copy startup script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]

