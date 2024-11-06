#!/usr/bin/env bash

set -eo pipefail

ROOT="$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")"

export CARDANO_NODE_SOCKET_PATH="${ROOT}/nodes/9/socket"
export CARDANO_NODE_NETWORK_ID=$(cat "${ROOT}"/MAGIC)

watch "cardano-cli conway query tip | json2yaml"
