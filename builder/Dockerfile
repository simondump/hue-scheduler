ARG TARGETPLATFORM
ARG TARGETCARGO
ARG BASEIMAGE

FROM --platform=$BUILDPLATFORM $BASEIMAGE AS build

WORKDIR /usr/src/hue-scheduler

RUN if [ "${TARGETPLATFORM}" = "linux/arm64" ]; then \
      apt update -y && apt install -y gcc-aarch64-linux-gnu; \
    elif [ "${TARGETPLATFORM}" = "linux/amd64" ]; then \
      apt update -y && apt install -y gcc-multilib; \
    fi

COPY . .

RUN cargo build --release --locked

FROM debian:12.2-slim

ARG TARGETCARGO

COPY --from=build \
    "/usr/src/hue-scheduler/target/$TARGETCARGO/release/hue-scheduler" \
    "/bin/hue-scheduler"

CMD ["hue-scheduler"]
