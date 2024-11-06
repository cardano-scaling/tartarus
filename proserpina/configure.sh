#!/usr/bin/env bash

set -eo pipefail

ROOT="$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")"
CONFIG="${ROOT}/config"

podman network create --ignore --disable-dns --subnet "$(cat "${ROOT}"/CIDR-hon)" proserpina-hon
podman network create --ignore --disable-dns --subnet "$(cat "${ROOT}"/CIDR-adv)" proserpina-adv

START_TIME="$(date -v -1S +%s)"
sed -i -e 's/"startTime": [0-9]*/"startTime": '"${START_TIME}/" "${CONFIG}/byron/genesis.json"
sed -i -e 's/"systemStart":"[^"]*"/"systemStart":"'"$(date -j -f "%s" "${START_TIME}" -u +%FT%T)"'Z"/' "${CONFIG}/shelley-genesis.json"

sed -i -e '/4726/s/"addr" : "[^"]*"/"addr" : "'"$(cat "${ROOT}"/HOST)"'"/' nodes/?/topology.json

rm -rf nodes/?/{db,socket}
