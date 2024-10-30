#!/usr/bin/env bash

set -eo pipefail

ROOT="$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")"
CONFIG="${ROOT}/config"

podman network create --ignore --disable-dns --subnet "$(cat "${ROOT}"/CIDR-a)" proserpina-a
podman network create --ignore --disable-dns --subnet "$(cat "${ROOT}"/CIDR-b)" proserpina-b

START_TIME="$(date -v -1S +%s)"
sed -i -e 's/"startTime": [0-9]*/"startTime": '"${START_TIME}/" "${CONFIG}/byron/genesis.json"
sed -i -e 's/"systemStart":"[^"]*"/"systemStart":"'"$(date -j -f "%s" "${START_TIME}" -u +%FT%T)"'Z"/' "${CONFIG}/shelley-genesis.json"

mkdir -p nodes/{1,2,3,4,5,6,7,8,9}
rm -rf nodes/?/{db,socket}
