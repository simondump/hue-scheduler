ARG TARGETPLATFORM
ARG TARGET
ARG BASE

FROM --platform=$BUILDPLATFORM $BASE AS build

WORKDIR /usr/src/hue-scheduler

RUN if [ "${TARGETPLATFORM}" = "linux/arm64" ]; then \
      apt update -y && apt install -y gcc-aarch64-linux-gnu; \
    elif [ "${TARGETPLATFORM}" = "linux/amd64" ]; then \
      apt update -y && apt install -y gcc-multilib; \
    fi

COPY . .

RUN cargo build --release --locked

FROM debian:12.2-slim

LABEL org.opencontainers.image.authors "Simon Reinisch <simon@reinisch.io>"
LABEL org.opencontainers.image.source https://github.com/simondump/hue-scheduler

ARG TARGET

COPY --from=build \
    "/usr/src/hue-scheduler/target/$TARGET/release/hue-scheduler" \
    "/bin/hue-scheduler"

CMD ["hue-scheduler"]
