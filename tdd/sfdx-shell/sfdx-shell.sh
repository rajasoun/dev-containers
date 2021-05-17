#!/usr/bin/env sh

ROOT_DIR="$(git rev-parse --show-toplevel)/tdd/bats"
WORKSPACE=$ROOT_DIR/workspace

docker run --rm -it \
    -v "${WORKSPACE}:/workspace" \
    --name sfdx-dev-shell  \
    --entrypoint="/usr/bin/zsh"  \
    rajasoun/sfdx-dev-shell:latest