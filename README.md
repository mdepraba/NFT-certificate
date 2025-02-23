# Foundry NFT Certificate Project

## Overview

This repository utilizes **Foundry**, a powerful Ethereum development toolkit written in Rust, to develop and deploy an **NFT Certificate** smart contract. The NFT serves as a certificate of completion for a course, demonstrating a student's achievement.

## Features

-   **ERC-721 NFT Certificate**: Implements a non-transferable NFT certificate using OpenZeppelin.
-   **Dynamic Metadata**: NFT metadata is dynamically generated and stored in IPFS.
-   **Secure and Controlled Minting**: Only the contract owner can mint certificates.
-   **Testing with Foundry**: Comprehensive unit tests ensure smart contract reliability.

## Technologies Used

-   [Foundry](https://book.getfoundry.sh/)
-   Solidity (v0.8.13)
-   OpenZeppelin Contracts
-   IPFS for NFT metadata storage

## Project Structure

```
├── broadcast/                     # Broadcast transactions
├── lib/                           # External dependencies
├── src/
│   ├── NFTCertificate.sol         # NFT Smart Contract
├── script/
│   ├── DeployNFTCertificate.sol   # Deployment script
├── test/
│   ├── NFTCertificateTest.sol     # Unit tests
├── .github/workflows/
│   ├── test.yml                   # GitHub Actions for CI/CD
├── foundry.toml                   # Foundry configuration
├── remappings.txt                 # Solidity remappings
├── metadata.json                  # Sample metadata for NFT
├── README.md                      # Project documentation
```

## Installation & Setup

### Prerequisites

Ensure you have Foundry installed:

```shell
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

### Install Dependencies

```shell
git submodule update --init --recursive
```

## Usage

### Build the Smart Contract

```shell
forge build
```

### Run Tests

```shell
forge test -vvv
```

### Direct Contract Deployment

```shell
forge create --rpc-url $RPC_URL --private-key $PRIVATE_KEY src/NFTCertificate.sol:NFTCertificate \
  --gas-limit 10000000 --gas-price 1000000000 --broadcast --verify \
  --verifier blockscout --verifier-url https://niskala.mandalachain.io/api \
  --optimize --optimizer-runs=200
```

### Deploy NFT Certificate

```shell
forge script script/DeployNFTCertificate.sol:DeployNFTCertificate \
  --rpc-url $RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast \
  --verifier blockscout \
  --verifier-url https://niskala.mandalachain.io/api
```

### Run Local Ethereum Node

```shell
anvil
```

## Continuous Integration

This repository uses **GitHub Actions** to automatically run tests on every push and pull request. The CI workflow is defined in `.github/workflows/test.yml`.

## License

This project is licensed under the MIT License.
