#!/bin/sh

if [ -z "$ETH_GENESIS_PATH" ]; then
  export ETH_GENESIS_PATH=~/ethereum-genesis.json
fi

if [ -n "$ETH_GENESIS_CONTENT" ] && [ ! -f "$ETH_GENESIS_PATH" ]; then
  echo "--> Writing Genesis to $ETH_GENESIS_PATH"
  echo $ETH_GENESIS_CONTENT > $ETH_GENESIS_PATH
fi

mkdir -p ~/.ethereum/tendermint

if [ -n "$TENDERMINT_CONFIG_PATH" ]; then
  cp -f $TENDERMINT_CONFIG_PATH ~/.ethereum/tendermint/config.toml
fi
if [ -n "$TENDERMINT_GENESIS_PATH" ]; then
  cp -f $TENDERMINT_GENESIS_PATH ~/.ethereum/tendermint/genesis.json
fi
if [ -n "$TENDERMINT_PRIV_VALIDATOR_PATH" ]; then
  cp -f $TENDERMINT_PRIV_VALIDATOR_PATH ~/.ethereum/tendermint/priv_validator.json
fi

if [ ! -d ~/.ethereum/ethermint/chaindata ]; then
  echo "--> Initialising Blockchain using: $ETH_GENESIS_PATH"
  if [ ! -f $ETH_GENESIS_PATH ]; then
    echo "Missing Ethereum genesis file at $ETH_GENESIS_PATH"
    exit 1
  fi
  ethermint --with-tendermint init $ETH_GENESIS_PATH
fi

sed -i "s|ZZ_HOSTNAME|$HOSTNAME|g" ~/.ethermint/tendermint/config.toml

echo "--> Starting Ethermint"
ethermint --with-tendermint "$@"
