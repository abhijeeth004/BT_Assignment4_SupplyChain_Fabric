#!/usr/bin/env bash
set -e

export FABRIC_CFG_PATH=$PWD

echo "Generating crypto material..."
cryptogen generate --config=./crypto-config.yaml

echo "Generating genesis block and channel tx..."
mkdir -p channel-artifacts
configtxgen -profile SupplyOrdererGenesis -channelID system-channel -outputBlock ./channel-artifacts/genesis.block
configtxgen -profile SupplyChainChannel -outputCreateChannelTx ./channel-artifacts/supplychannel.tx -channelID supplychannel

echo "Starting network..."
docker-compose -f docker-compose.yaml up -d

echo "Network started. Next steps:"
echo "1. Create channel and join peers."
echo "2. Deploy chaincode."
