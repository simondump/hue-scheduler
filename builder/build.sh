#!/bin/bash

targets=("x86_64-unknown-linux-musl" "aarch64-unknown-linux-musl")

for target in "${targets[@]}"; do
  tag="ghcr.io/simondump/hue-scheduler:$target"
  base="ghcr.io/rust-cross/rust-musl-cross:$target"

  docker buildx build --platform linux/amd64 \
    --tag "$tag" \
    --build-arg BASE="$base" \
    --build-arg TARGET="$target" \. --push

  docker rmi "$base"
  docker rmi "$tag"
done
