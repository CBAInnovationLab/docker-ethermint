# Ethermint

This is the Git repo of the CBA Innovation Lab's [Ethermint](https://github.com/tendermint/ethermint) docker image.

## Initialisation

When the container starts it will first check if Ethermint has been initialised with an [Ethereum genesis](https://github.com/ethereum/go-ethereum/wiki/Private-network) file.  If it has not, it will first run `ethermint init` using the genesis file specified by either of the following environment variables.

`ETH_GENESIS_PATH`: The path to a genesis file that's been mounted in to the container

`ETH_GENESIS_CONTENT`: the JSON encoded contents of the genesis that you would like to use

## Usage

Use the following to run an Ethermint node with some options specified

```
export ETH_GENESIS_CONTENT="{\"config\":{\"chainId\":15,\"homesteadBlock\":0,\"eip155Block\":0,\"eip158Block\":0},\"nonce\":\"0xdeadbeefdeadbeef\",\"timestamp\":\"0x00\",\"parentHash\":\"0x0000000000000000000000000000000000000000000000000000000000000000\",\"mixhash\":\"0x0000000000000000000000000000000000000000000000000000000000000000\",\"difficulty\":\"0x40\",\"gasLimit\":\"0x800000000\",\"alloc\":{\"0x7df9a875a174b3bc565e6424a0050ebc1b2d1d82\":{\"balance\":\"10000000000000000000000000000000000\"}}}"

docker run -it -e ETH_GENESIS_CONTENT=$ETH_GENESIS_CONTENT -p 8545:8545 cbainnovationlab/ethermint --rpc --rpcapi "admin,db,eth,debug,miner,net,shh,txpool,personal,web3" --rpcaddr "0.0.0.0" --rpccorsdomain "*" --gasprice "0" --targetgaslimit "34359738368"

```
