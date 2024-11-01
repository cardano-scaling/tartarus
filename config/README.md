# Genesis files

The [shelley-genesis.json](shelley-genesis.json) file needs some minimal information to start producing blocks, after which normal operation with SPOs registering, transactions staking, etc. can proceed.

## Faucet

There's a _faucet_ which contains some initial funds, whose public key is [faucet.vk](faucet.vk).
The `initialFunds` field of the genesis file contains the pubkeyhash of this key, obtained through

```
cardano-cli address key-hash --payment-verification-key-file faucet.vk
```

## Single staker

There's a single staker with funds that delegate to a single initial pool.

```
cardano-cli stake-address key-gen --verification-key-file stake.vkey --signing-key-file stake.skey
cardano-cli address key-gen --verification-key-file staker.vkey --signing-key-file staker.skey
cardano-cli stake-address build --stake-verification-key-file stake.vkey  --out-file stake.addr --testnet-magic 666
cardano-address address inspect < stake.addr
cardano-cli address build  --payment-verification-key-file staker.vkey --stake-verification-key-file stake.vkey --out-file payment.addr --testnet-magic 666
```

The address to put in `initialFunds` comes from:

```
bech32 < payment.addr
```

The stake key hash to put in `staking.stake` comes from:

```
cardano-address address inspect < stake.addr
```

## Stake Pool


Generate keys:

```
cardano-cli node key-gen --cold-verification-key-file cold.vkey --cold-signing-key-file cold.skey --operational-certificate-issue-counter-file opcert.counter
cardano-cli node key-gen-KES --verification-key-file kes.vkey --signing-key-file kes.skey
cardano-cli node key-gen-VRF --verification-key-file vrf.vkey --signing-key-file vrf.skey
cardano-cli stake-address key-gen --verification-key-file spo.vkey --signing-key-file spo.skey
```

Issue operational certificate:

```
cardano-cli node issue-op-cert --kes-verification-key-file kes.vkey --cold-signing-key-file cold.skey --operational-certificate-issue-counter opcert.counter --kes-period 0 --out-file opcert.cert
```

Fill in data for `staking` section in Shelley genesis file. To get the hash of the VRF key:

`vrf` field:

```
cardano-cli node key-hash-VRF --verification-key-file vrf.vkey
```

Stake pool id:

```
cardano-cli stake-pool id --cold-verification-key-file cold.vkey --output-format "hex"
```

Reward account id:

```
cardano-cli stake-address build --stake-verification-key-file spo.vkey  --testnet-magic 666 | cardano-address address inspect
```

## Genesis hash

To generate the `XXXGenesisHash` values in `config.json`:

```
cardano-cli genesis hash  --genesis shelley-genesis.json
cardano-cli genesis hash  --genesis byron-genesis.json
cardano-cli genesis hash  --genesis alonzo-genesis.json
cardano-cli genesis hash  --genesis conway-genesis.json
```

Note the node will check those values if they are set and refuse to start, dumping the actual/expected values so one can fill in this data through trial and error.

## Start node

```
cardano-node run --database-path db --socket-path node.socket --port 3003 --byron-signing-key config/byron-delegate.key --byron-delegation-certificate config/byron-delegation.cert --shelley-operational-certificate config/opcert.cert --shelley-kes-key config/kes.skey --shelley-vrf-key config/vrf.skey --config config/config.json --topology config/topology.json --host-addr 127.0.0.1
```
