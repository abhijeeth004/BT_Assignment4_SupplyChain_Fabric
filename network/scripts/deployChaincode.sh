#!/usr/bin/env bash
set -e

CHANNEL_NAME="supplychannel"
CC_NAME="productcc"
CC_VERSION="1.0"
CC_SRC_PATH="../chaincode/product-chaincode"
CC_LANG="node"

echo "=== Packaging chaincode ==="
peer lifecycle chaincode package ${CC_NAME}.tar.gz \
  --path ${CC_SRC_PATH} \
  --lang ${CC_LANG} \
  --label ${CC_NAME}_${CC_VERSION}

echo "=== Installing chaincode on Manufacturer peer ==="
peer lifecycle chaincode install ${CC_NAME}.tar.gz

echo "=== Query installed chaincodes ==="
peer lifecycle chaincode queryinstalled
echo "Take note of the package ID and replace <packageID> below."

echo "=== Approving chaincode for Manufacturer org ==="
read -p "Enter the package ID: " PACKAGE_ID
peer lifecycle chaincode approveformyorg \
  -o orderer.example.com:7050 \
  --channelID ${CHANNEL_NAME} \
  --name ${CC_NAME} \
  --version ${CC_VERSION} \
  --package-id ${PACKAGE_ID} \
  --sequence 1

echo "=== Committing chaincode definition ==="
peer lifecycle chaincode commit \
  -o orderer.example.com:7050 \
  --channelID ${CHANNEL_NAME} \
  --name ${CC_NAME} \
  --version ${CC_VERSION} \
  --sequence 1 \
  --peerAddresses peer0.manufacturer.example.com:7051

echo "=== Chaincode committed successfully! ==="
