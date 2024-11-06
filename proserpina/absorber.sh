#!/usr/bin/env bash

# Advantage of honest nodes that cause the attempt to fail.
M=2

# Advantage of adversarial nodes that cause the attempt to succeed.
N=10

export CARDANO_NODE_NETWORK_ID=$(echo -n proserpina | cksum | sed -e 's/ .*//')

SPLIT=0

for c in proserpina-{hon,adv}-control
do
  if [[ "$(podman inspect $c | jq '.[0].State.Paused')" == "true" ]]
  then
    podman unpause $c
  fi
done

while true
do
  if (( $SPLIT == 0 ))
  then
    sleep 5s
    BLOCK_1=$(cardano-cli query tip --socket-path nodes/1/socket | jq -r '.hash')
    BLOCK_9=$(cardano-cli query tip --socket-path nodes/9/socket | jq -r '.hash')
    if [[ "$BLOCK_1" == "$BLOCK_9" ]]
    then
      BLOCK_9=$(cardano-cli query tip --socket-path nodes/9/socket | jq -r '.block')
      echo "SPLIT $BLOCK_9 $BLOCK_1"
      podman pause proserpina-hon-control proserpina-adv-control
      SPLIT=1
    else
      podman restart proserpina-hon-control proserpina-adv-control
    fi
  else
    BLOCK_1=$(cardano-cli query tip --socket-path nodes/1/socket | jq -r '.block')
    BLOCK_9=$(cardano-cli query tip --socket-path nodes/9/socket | jq -r '.block')
    ADVANTAGE=$((BLOCK_9 - BLOCK_1))
    if (( $ADVANTAGE <= -$M ))
    then
      echo "FAIL $BLOCK_1 $BLOCK_9"
      podman unpause proserpina-hon-control proserpina-adv-control
      SPLIT=0
    elif (( $ADVANTAGE >= $N ))
    then
      echo "SUCCEED $BLOCK_1 $BLOCK_9"
      podman unpause proserpina-hon-control proserpina-adv-control
      SPLIT=0
    fi
  fi
  sleep 0.1s
done
