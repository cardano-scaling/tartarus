# Podman Scripts for Creating Rollbacks on a Cardano Test Network


## Prerequisites

The scripts require the following tools:

- `bash`
- `cardano-cli`
- `dasel`
- `jq`
- `podman`
- `sed`

The scripts have been tested under NixOS 24.05.


## Configuration

The following genesis files and node configuration are used:

- [config/byron/genesis.json](config/byron/genesis.json)
- [config/shelley-genesis.json](config/shelley-genesis.json)
- [config/alonzo-genesis.json](config/alonzo-genesis.json)
- [config/conway-genesis.json](config/conway-genesis.json)
- [config/configuration.yaml](config/configuration.yaml)

These may be lighly customized before launching the clusters. In particular, it may be useful to edit the `epochLength`, `activeSlotsCoeff`, `protocolParams`, `securityParam`, or `slotLength` of [config/shelley-genesis.json](config/shelley-genesis.json).


## Network

By default, the subnet `10.100.1.0/29` is used for honest nodes and `10.100.2.0/29` is used for adversarial nodes. Edit the files [CIRD-hon](CIRD-hon) and [CIDR-adv](CIDR-adv), respectively, to change these.

By default, the honest nodes have IP address `10.100.1.2` and the adversarial ones have `10.100.2.2`. These must be within the subnets specified by [CIRD-hon](CIRD-hon) and [CIDR-adv](CIDR-adv), respectively.

The IP address of the host must be specified in [HOST](HOST). Host ports `47261` through `47269` must be available on the host.


## Topology

The topology files reside in [nodes/?/topology.json](nodes/1/topology.json).


## Configuration

First configure the nodes and create their local networks.

```bash
./configure.sh
```

## Running the test network


### Startup

Create the clusters and start them running.

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

The following command will collect relevant log information in files `blocks-?.jsonarray` and all log information in `proserina-?.log.gz`.

```bash
./collect-logs.sh
```

A network diagram `graph.dot` can be generated as follows:

```bash
./diagram.sh
dot -T svg -o graph.svg graph.dot
dot -T png -o graph.png graph.dot
```


### Breaking consensus

While running `./watch-cluster-hon.sh` and `./watch-cluster-adv.sh` in separate terminal windows, fragment the node topology into two clusters using the following command:

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

Because cluster "hon" contains five nodes and cluster 'adv" contains four nodes, there is a higher probability that transactions on cluster "hon" will survive if there are conflicting transactions on the two clusters, but this is not guaranteed.


## Running the private adversarial fork experiment

See [absorber.ipynb](absorber.ipynb) for details of the private adversarial fork experiment. The following command runs the experiment:

```bash
./absorber.sh
```


## Shutdown

```bash
./stop-clusters.sh
```


## Diagnostics

See [diagnostics.ipynb](diagnostics.ipynb) for analysis of block production, comparing it against theory.


## How the configuration were generated.

1. Apply [cardano-node.patch](cardano-node.patch).
2. Set `CARDANO-CLI`.
3. Execute `cabal run cardano-testnet -- cardano --conway-era --testnet-magic 2933875683 --num-pool-nodes 9`
