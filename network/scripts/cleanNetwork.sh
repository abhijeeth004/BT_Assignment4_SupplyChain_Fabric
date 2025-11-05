#!/usr/bin/env bash
echo "Stopping and removing all Fabric containers..."
docker rm -f $(docker ps -aq) 2>/dev/null || true
echo "Removing chaincode packages and generated crypto material..."
rm -rf crypto-config channel-artifacts *.tar.gz
echo "Cleanup complete."
