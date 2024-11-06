#!/usr/bin/env bash

for c in proserpina-{hon,adv}-control
do
  if [[ "$(podman inspect $c | jq '.[0].State.Paused')" == "true" ]]
  then
    podman unpause $c
  fi
done

podman pod stop proserpina-hon proserpina-adv
