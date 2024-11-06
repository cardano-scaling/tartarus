#!/usr/bin/env bash
set -eo pipefail

ROOT="$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")"

podman play kube --replace=true --start=true --network=proserpina-hon --ip "$(cat "${ROOT}"/IP-hon)" "${ROOT}/proserpina-hon.yaml"
podman play kube --replace=true --start=true --network=proserpina-adv --ip "$(cat "${ROOT}"/IP-adv)" "${ROOT}/proserpina-adv.yaml"
