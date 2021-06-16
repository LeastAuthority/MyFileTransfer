#!/usr/bin/env bash
set -e

release_ref="$1"
bucket_name="$2"
cloudfront_dist_id="$3"
repo_url="https://github.com/leastauthority/myfiletransfer"

if [[ $release_ref != "" ]]; then
  git_output_dir=$(mktemp -d)
  echo "if: git_output_dir: $1"

  trap 'cleanup $git_output_dir $?' EXIT
  cleanup() {
    rm -rf $1
  }

  git clone --recurse-submodules \
            --shallow-submodules \
            --single-branch \
            --branch "$release_ref" \
            --depth 1 \
            "$repo_url" "$git_output_dir"
  rm -rf /repo/*
  cp -r $git_output_dir/* /repo/
  cp /run/wormhole/docker-compose.override.yml /repo/docker/docker-compose.override.yml

  # TODO: do this somewhere else.
  if [[ $bucket_name != "" ]]; then
    (cd /repo && yarn install && yarn build && \
      aws s3 sync --region eu-central-1 /repo/dist "$bucket_name")
  fi

  # TODO: do this somewhere else.
  # Invalidate cache
  if [[ $cloudfront_dist_id != "" ]]; then
    aws cloudfront create-invalidation \
      --distribution-id "$cloudfront_dist_id" \
      --paths /index.html /worker/index.umd.js /assets/wormhole.wasm
  fi

  # Restart backend
  date > /run/wormhole/restart
fi