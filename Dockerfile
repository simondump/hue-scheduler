ARG TARGET_PLATFORM
ARG TARGET_CARGO
ARG BASE_IMAGE

FROM --platform=$BUILDPLATFORM $BASE_IMAGE

WORKDIR /usr/src/hue-scheduler

RUN if [ "${TARGET_PLATFORM}" = "linux/arm64" ]; then \
      apt update -y && apt install -y gcc-aarch64-linux-gnu; \
    elif [ "${TARGET_PLATFORM}" = "linux/amd64" ]; then \
      apt update -y && apt install -y gcc-multilib; \
    fi

COPY . .

RUN cargo build --target "$TARGET_CARGO" --release --locked

FROM debian:12.2-slim

COPY --from=build /usr/src/hue-scheduler/target/release/hue-scheduler /bin/hue-scheduler

CMD ["hue-scheduler"]
