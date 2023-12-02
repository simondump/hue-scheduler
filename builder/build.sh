#!/bin/bash
set -e

BASE_IMAGES=("x86_64-unknown-linux-musl" "aarch64-unknown-linux-musl")
IMAGE_PLATFORMS=("linux/amd64" "linux/arm64")

for I in "${!BASE_IMAGES[@]}"; do
  IMAGE_PLATFORM="${IMAGE_PLATFORMS[$I]}"
  BASE_IMAGE="${BASE_IMAGES[$I]}"

  docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --tag "$IMAGE_PATH:latest" \
    --tag "$IMAGE_PATH:$IMAGE_VERSION" \
    --tag "$IMAGE_PATH:$IMAGE_VERSION_SHORT" \
    --build-arg BASE="ghcr.io/rust-cross/rust-musl-cross:$BASE_IMAGE" \
    --build-arg TARGET="$BASE_IMAGE" \
    . --push
done
