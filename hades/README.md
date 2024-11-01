## Generate 3 pools cluster with cardano-testnet


```
git clone https://github.com/cardano-scaling/tartarus
cd tartarus
git switch network-config
cd hades
curl -L -o cardano.tgz https://github.com/IntersectMBO/cardano-node/releases/download/10.1.1/cardano-node-10.1.1-linux.tar.gz
tar xvzf cardano.tgz ./bin
chmod 0600 pools-keys/pool3/*
```

Run node 1:

```
cardano-node run --config configuration.yaml --shelley-kes-key pools-keys/pool1/kes.skey --shelley-vrf-key pools-keys/pool1/vrf.skey --byron-delegation-certificate     pools-keys/pool1/byron-delegation.cert --byron-signing-key                pools-keys/pool1/byron-delegate.key --shelley-operational-certificate  pools-keys/pool1/opcert.cert --database-path  node-data/node1/db --socket-path    node1.socket --topology       node-data/node1/topology.json --host-addr 10.10.0.1 --port 6666
```

Run node 2:

```
cardano-node run --config configuration.yaml --shelley-kes-key pools-keys/pool2/kes.skey --shelley-vrf-key pools-keys/pool2/vrf.skey --byron-delegation-certificate     pools-keys/pool2/byron-delegation.cert --byron-signing-key                pools-keys/pool2/byron-delegate.key --shelley-operational-certificate  pools-keys/pool2/opcert.cert --database-path  node-data/node2/db --socket-path    node2.socket --topology       node-data/node2/topology.json --host-addr 10.10.0.2 --port 6666
```


Run node 3:

```
cardano-node run --config configuration.yaml --shelley-kes-key pools-keys/pool3/kes.skey --shelley-vrf-key pools-keys/pool3/vrf.skey --byron-delegation-certificate     pools-keys/pool3/byron-delegation.cert --byron-signing-key                pools-keys/pool3/byron-delegate.key --shelley-operational-certificate  pools-keys/pool3/opcert.cert --database-path  node-data/node3/db --socket-path    node3.socket --topology       node-data/node3/topology.json --host-addr 10.10.0.3 --port 6666
```

```
cardano-node run --config configuration.yaml --shelley-kes-key keys/pool1/kes.skey --shelley-vrf-key keys/pool1/vrf.skey --byron-delegation-certificate     keys/pool1/byron-delegation.cert --byron-signing-key                keys/pool1/byron-delegate.key --shelley-operational-certificate  keys/pool1/opcert.cert --database-path  data/nodes/1/db --socket-path    data/nodes/1/socket --topology   data/node1/topology.json --host-addr 10.10.0.2 --port 37261
```
