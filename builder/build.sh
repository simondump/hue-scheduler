#!/bin/bash

declare -A map

map["x86_64-unknown-linux-musl"]="ghcr.io/gngpp/rust-musl-cross:x86_64-musl"
map["aarch64-unknown-linux-musl"]="ghcr.io/gngpp/rust-musl-cross:aarch64-musl"

for key in "${!map[@]}"; do
  docker buildx build --platform linux/amd64 \
    --tag ghcr.io/simondump/hue-scheduler:"$key" \
    --build-arg BASE_IMAGE="${map[$key]}" \
    --build-arg TARGET_CARGO="$key" \. --push

  docker rmi ghcr.io/gngpp/ninja-builder:"$key"
  docker rmi "${map[$key]}"
done
