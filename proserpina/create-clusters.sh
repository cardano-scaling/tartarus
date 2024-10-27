#!/usr/bin/env bash
set -eo pipefail

ROOT="$(dirname -- "$(readlink -f -- "${BASH_SOURCE[0]}")")"

podman play kube --replace=true --start=true --network=proserpina-a --ip 10.100.1.2 "${ROOT}/proserpina-a.yaml"
podman play kube --replace=true --start=true --network=proserpina-b --ip 10.100.2.2 "${ROOT}/proserpina-b.yaml"
