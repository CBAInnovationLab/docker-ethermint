#!/bin/sh

if [ -n "$ETH_GENESIS_CONTENT" ] && [ ! -f ~/ethereum-genesis.json ]; then
    echo "--> Writing Genesis to ~/ethereum-genesis.json"
    echo $ETH_GENESIS_CONTENT > ~/ethereum-genesis.json
fi

if [ ! -d ~/.ethereum/ethermint/chaindata ]; then
    echo "--> Initialising Blockchain"
    if [ ! -f ~/ethereum-genesis.json ]; then
      echo "Missing Ethereum genesis file at ~/ethereum-genesis.json"
      exit 1
    fi
    ethermint --with-tendermint init ~/ethereum-genesis.json
fi

echo "--> Starting Ethermint"
ethermint --with-tendermint "$@"
