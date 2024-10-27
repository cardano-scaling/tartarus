# Podman Scripts for Creating Rollbacks on a Cardano Test Network


**WORK IN PROGRESS / INCOMPLETE README**


## Prerequisites

The scripts require the following tools:

- `podman`
- `jq`
- `sed`
- `bash`
- `cardano-cli`

The scripts have been tested under NixOS 22.11.


## Configuration

The following genesis files and node configuration are used:

- [config/byron/genesis.json](config/byron/genesis.json)
- [config/shelley-genesis.json](config/shelley-genesis.json)
- [config/alonzo-genesis.json](config/alonzo-genesis.json)
- [config/conway-genesis.json](config/conway-genesis.json)
- [config/configuration.yaml](config/configuration.yaml)

These may be lighly customized before launching the clusters. In particular, it may be useful to edit the `epochLength`, `activeSlotsCoeff`, `protocolParams`, `securityParam`, or `slotLength` of [config/shelley-genesis.json](config/shelley-genesis.json).

DESCRIBE CIDR-{a,b} and MAGIC

DESCRIBE node/?/topology.json

## Configuration

First create the network `propserpina`:

```bash
./configure.sh
```

## Running the test network


### Startup

```bash
./create-clusters.sh
```

### Measuring consensus

```bash
for n in a-1 a-2 a-3 a-4 a-5 b-6 b-7 b-8 b-9
do
  podman logs proserpina-$n | grep ForgedBlock
done
```

### Breaking consensus

While running `./watch-cluster-a.sh` and `./watch-cluster-b.sh` in separate terminal windows, fragment the node topology into two clusters using the following command:

```bash
./split-network.sh
```

After a few moments, you should see that the clusters are evolving separately and their block hashes and counts no longer match.


### Restoring consensus

So long as neither cluster has produced no more than `securityParam` number of blocks while the topology was fragmented, running the following command will bring the clusters back into global consensus:

```bash
./unsplit-network.sh
```

Once again, this may take a few moments.

Because cluster "a" contains five nodes and cluster 'b" contains four nodes, there is a higher probability that transactions on cluster "a" will survive if there are conflicting transactions on the two clusters, but this is not guaranteed.


## Shutdown

```bash
./stop-clusters.sh
```


## Generating configuratio files

1. Apply [cardano-node.patch](cardano-node.patch).
2. Set `CARDANO-CLI`.
3. Execute `cabal run cardano-testnet -- cardano --conway-era --testnet-magic 2933875683 --num-pool-nodes 9`
