FROM --platform=$BUILDPLATFORM rust:1.74-alpine3.17 AS build

ARG TARGETOS
ARG TARGETARCH

WORKDIR /app

COPY . .
RUN cargo build release

FROM alpine:3.18

COPY --from=builder /app/target/release/hue-scheduler /usr/local/bin/hue-scheduler

CMD ["hue-scheduler"]
