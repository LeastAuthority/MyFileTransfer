#!/usr/bin/env ash

set -e
release_ref="$1"
bucket_name="$2"
cloudfront_dist_id="$3"

dc() {
  docker-compose -p myfiletransfer "$@"
}

cold_restart() {
  dc down && dc up
}

# TODO: can save time if we know the docker composition and services haven't changed.
#restart() {
#  dc restart
#}

if [[ $release_ref != "" ]]; then
  git fetch origin
#  git clean -df
  git checkout -f "$release_ref"
  git submodule update

  # Deploy frontend (should already be built)
  # yarn deploy:s3:test
  aws s3 sync ./dist "$bucket_name"

  # Invalidate cache
  aws cloudfront create-invalidation \
    --distribution-id "$cloudfront_dist_id" \
    --paths /index.html /worker/index.umd.js /assets/wormhole.wasm

  # Restart backend
  cold_restart
fi