#!/usr/bin/env bash
set -e

export FABRIC_CFG_PATH=$PWD
CHANNEL_NAME="supplychannel"

echo "=== Creating channel: $CHANNEL_NAME ==="

# 1. Create the channel transaction (already generated in startNetwork)
peer channel create \
  -o orderer.example.com:7050 \
  -c $CHANNEL_NAME \
  -f ./channel-artifacts/supplychannel.tx \
  --outputBlock ./channel-artifacts/$CHANNEL_NAME.block

echo "Channel '$CHANNEL_NAME' created."

# 2. Join peers (you would switch env vars per org)
echo "Joining peer0.manufacturer.example.com to channel..."
export CORE_PEER_LOCALMSPID=ManufacturerMSP
export CORE_PEER_ADDRESS=peer0.manufacturer.example.com:7051
peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block

echo "Channel join complete for Manufacturer peer."
