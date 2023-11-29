ARG BASE

FROM --platform=$BUILDPLATFORM $BASE AS build

WORKDIR /usr/src/hue-scheduler

COPY . .

RUN cargo build --release --locked

FROM debian:12.2-slim

LABEL org.opencontainers.image.authors "Simon Reinisch <simon@reinisch.io>"
LABEL org.opencontainers.image.description "Better scheduling for your Philips Hue lights"
LABEL org.opencontainers.image.source https://github.com/simondump/hue-scheduler

ARG TARGET

COPY --from=build \
    "/usr/src/hue-scheduler/target/$TARGET/release/hue-scheduler" \
    "/bin/hue-scheduler"

CMD ["hue-scheduler"]
