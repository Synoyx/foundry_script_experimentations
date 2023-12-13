![Solidity](https://img.shields.io/badge/Solidity-%23363636.svg?style=for-the-badge&logo=solidity&logoColor=white) ![Ethereum](https://img.shields.io/badge/Ethereum-3C3C3D?style=for-the-badge&logo=Ethereum&logoColor=white)

# foundry_script_experimentations

In this project, I try different things with foundry scripts.
The goal is to create a database of use cases, to use it as a cheatsheet for next projects

## InteractWithDeployedContracts

Path : scripts/InteractWithDeployedContracts.s.sol
How to use :

- Deploy a mainnet's fork with 'anvil --fork-url https://eth-mainnet.g.alchemy.com/v2/ALCHEMY_API_KEY'
- On the root of this project, call 'forge script scripts/InteractWithDeployedContracts.s.sol --rpc-url localhost'
