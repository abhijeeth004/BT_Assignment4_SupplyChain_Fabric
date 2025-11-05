#  Blockchain-Based Supply Chain Network – ICT 4415 Assignment 4

This project implements a **three-organization supply chain network** on **Hyperledger Fabric v2.5**, demonstrating secure product traceability and transaction auditability.  
It also includes a **Layer-2 Blockchain Threat Analysis Report** for security evaluation.

---

##  Project Structure
BT_Assignment4/
├─ network/ # Fabric network configs & scripts
│ ├─ crypto-config.yaml
│ ├─ configtx.yaml
│ ├─ docker-compose.yaml
│ └─ scripts/
│ ├─ startNetwork.sh
│ ├─ createChannel.sh
│ ├─ deployChaincode.sh
│ └─ cleanNetwork.sh
├─ chaincode/
│ └─ product-chaincode/ # Node.js chaincode
├─ app-scripts/ # CLI scripts to invoke/query chaincode
│ └─ simulateLifecycle.sh
├─ docs/
│ └─ ThreatReport.docx
├─ screenshots/ # Execution proof screenshots
└─ README.md


---

## 🚀 Getting Started

### Prerequisites
- **Docker Desktop**
- **Git Bash or WSL 2**
- **Hyperledger Fabric Binaries v2.5.0**
  ```bash
  curl -sSL https://bit.ly/2ysbOFE | bash -s -- 2.5.0 1.5.0
  export PATH=$PATH:$PWD/fabric-samples/bin

  Step 1 – Start Network

  cd network
bash scripts/startNetwork.sh

Step 2 – Create Channel

bash scripts/createChannel.sh

Step 3 - Deploy Chaincode

bash scripts/deployChaincode.sh

Step 4 – Simulate Lifecycle

cd ../../app-scripts
bash simulateLifecycle.sh

What It Does ?
Manufacturer creates products.
Distributor transfers shipments.
Retailer receives goods.
All events are recorded on-chain with full audit trail.

Security Features:-
Role-based MSP identities (three orgs)
Endorsement policy: prevents unauthorized updates
Tamper-proof ledger with ordering consensus
Optional private data collections for sensitive fields

Cleanup Network
bash network/scripts/cleanNetwork.sh
