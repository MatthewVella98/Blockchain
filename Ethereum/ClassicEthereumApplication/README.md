# The Compile and Deploy Scripts. 

### Compile.js: 
Compiles the solidity smart contract using the solc.js (solidity's jaavscript compiler) which can be downloaded as an npm package. The compiled contract (ABI + Bytecode) is then exported, so that the compiled contract will be avaiable from other scripts and can be deployed using the deploy.js script. 

### Deploy.js 
Using the truffle-hdwallet-provider as a provider to the web3, where the provider is given my wallet (which only contains test ether so don't get too excited), and a link to my infura account, which connects to an infura node on the Ethereum's Rinkeby test blockchain. 
The deploy method, gets a list of all the accounts from my Metamask wallet, an deploys the bytecode with 1 million gas, from the first account. 
When the contract is deployed, the contract's address is logged to console, and the contract can be scanned on etherscan-rinkeby. 

