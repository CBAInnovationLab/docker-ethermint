#!/bin/sh

if [ -z "$ETH_GENESIS_FILE" ]; then
  export ETH_GENESIS_FILE=~/ethereum-genesis.json
fi

if [ -n "$ETH_GENESIS_CONTENT" ] && [ ! -f "$ETH_GENESIS_FILE" ]; then
    echo "--> Writing Genesis to $ETH_GENESIS_FILE"
    echo $ETH_GENESIS_CONTENT > $ETH_GENESIS_FILE
fi

if [ ! -d ~/.ethereum/ethermint/chaindata ]; then
    echo "--> Initialising Blockchain using: $ETH_GENESIS_FILE"
    if [ ! -f $ETH_GENESIS_FILE ]; then
      echo "Missing Ethereum genesis file at $ETH_GENESIS_FILE"
      exit 1
    fi
    ethermint --with-tendermint init $ETH_GENESIS_FILE
fi

echo "--> Starting Ethermint"
ethermint --with-tendermint "$@"
