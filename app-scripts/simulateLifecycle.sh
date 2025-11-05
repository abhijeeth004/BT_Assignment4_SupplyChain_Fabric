#!/usr/bin/env bash
set -e

CHANNEL_NAME="supplychannel"
CC_NAME="productcc"

echo "=== 1. Create Product ==="
peer chaincode invoke -o orderer.example.com:7050 \
  -C ${CHANNEL_NAME} -n ${CC_NAME} \
  -c '{"Args":["CreateProduct","P1001","ManufacturerMSP","{\"name\":\"Phone\",\"batch\":\"B1\"}"]}'
sleep 3

echo "=== 2. Transfer Shipment ==="
peer chaincode invoke -o orderer.example.com:7050 \
  -C ${CHANNEL_NAME} -n ${CC_NAME} \
  -c '{"Args":["TransferShipment","P1001","DistributorMSP","{\"shipment\":\"#234\"}"]}'
sleep 3

echo "=== 3. Receive Product ==="
peer chaincode invoke -o orderer.example.com:7050 \
  -C ${CHANNEL_NAME} -n ${CC_NAME} \
  -c '{"Args":["ReceiveProduct","P1001","RetailerMSP"]}'
sleep 3

echo "=== 4. Query Product ==="
peer chaincode query -C ${CHANNEL_NAME} -n ${CC_NAME} \
  -c '{"Args":["QueryProduct","P1001"]}'
