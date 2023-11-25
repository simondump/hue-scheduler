#!/bin/bash
set -e

targets=("x86_64-unknown-linux-musl" "aarch64-unknown-linux-musl")

for target in "${targets[@]}"; do
  docker buildx build \
    --file builder/Dockerfile \
    --platform linux/amd64,linux/arm64 \
    --tag "$IMAGE_PATH:latest" \
    --tag "$IMAGE_PATH:$IMAGE_VERSION" \
    --tag "$IMAGE_PATH:$IMAGE_VERSION_SHORT" \
    --build-arg BASE="ghcr.io/rust-cross/rust-musl-cross:$target" \
    --build-arg TARGET="$target" \
    . --push
done
