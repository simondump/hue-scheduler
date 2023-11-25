ARG TARGET_PLATFORM
ARG BASE_IMAGE

FROM --platform=$BUILDPLATFORM $BASE_IMAGE AS build

WORKDIR /usr/src/hue-scheduler

RUN if [ "${TARGET_PLATFORM}" = "linux/arm64" ]; then \
      apt update -y && apt install -y gcc-aarch64-linux-gnu; \
    elif [ "${TARGET_PLATFORM}" = "linux/amd64" ]; then \
      apt update -y && apt install -y gcc-multilib; \
    fi

COPY . .

RUN cargo build --release --locked
RUN ls -la target
RUN ls -la target/release

FROM debian:12.2-slim

COPY --from=build /usr/src/hue-scheduler/target/release/hue-scheduler /bin/hue-scheduler

CMD ["hue-scheduler"]
