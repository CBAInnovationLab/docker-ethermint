#!/bin/sh

if [ -z "$ETH_GENESIS_PATH" ]; then
  export ETH_GENESIS_PATH=~/ethereum-genesis.json
fi

if [ -n "$ETH_GENESIS_CONTENT" ] && [ ! -f "$ETH_GENESIS_PATH" ]; then
  echo "--> Writing Genesis to $ETH_GENESIS_PATH"
  echo $ETH_GENESIS_CONTENT > $ETH_GENESIS_PATH
fi

if [ ! -d ~/.ethereum/ethermint/chaindata ]; then
  echo "--> Initialising Blockchain using: $ETH_GENESIS_PATH"
  if [ ! -f $ETH_GENESIS_PATH ]; then
    echo "Missing Ethereum genesis file at $ETH_GENESIS_PATH"
    exit 1
  fi

  echo "$@"

  if [ -z "$TENDERMINT_ADDR" ]; then
    echo "  --> With Tendermint"
    ethermint --with-tendermint init $ETH_GENESIS_PATH
  else
    echo "  --> Tendermint: $TENDERMINT_ADDR"
    ethermint --tendermint_addr $TENDERMINT_ADDR init $ETH_GENESIS_PATH
  fi
fi

echo "--> Starting Ethermint"
if [ -z "$TENDERMINT_ADDR" ]; then
  echo "  --> With Tendermint"
  ethermint --with-tendermint "$@"
else
  echo "  --> Tendermint: $TENDERMINT_ADDR"
  ethermint --tendermint_addr $TENDERMINT_ADDR "$@"
fi
