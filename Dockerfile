FROM --platform=$BUILDPLATFORM rust:1.74 AS build

WORKDIR /app

COPY . .
RUN cargo build --release

FROM alpine:3.18

COPY --from=build /app/target/release/hue-scheduler /usr/local/bin/hue-scheduler

CMD ["hue-scheduler"]
