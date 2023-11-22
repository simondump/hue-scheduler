FROM rust:1.74 AS build

WORKDIR /usr/src/hue-scheduler

COPY . .

RUN cargo build --release --locked

FROM debian:12.2-slim

COPY --from=build /usr/src/hue-scheduler/target/release/hue-scheduler /bin/hue-scheduler

CMD ["hue-scheduler"]
