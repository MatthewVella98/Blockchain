// Deploy code is for truffle wallet privder 0.03. For 0.04, the code has to be updated. 
// Deployed code can be scanned on Etherscan. 

const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const compiled = require('./compile');

// Connect to Infura Node through the provider (Infura API) 
const provider = new HDWalletProvider( 
    'mammal waste glare genius praise unaware will fiction add corn hobby lens',
    'https://rinkeby.infura.io/v3/ccf57dddf77c40cdac915939d73fc21c'        
);

// Providing the provider to the Web3 to understand how to talk to the blockchain (To the Infura node on the chain in this case). 
const web3 = new Web3(provider);          

const deploy = async () => {

  // Get list of all accounts. 
  const accounts = await web3.eth.getAccounts(); 
  console.log(accounts[0]);
  console.log('Attempting to deploy from account', accounts[0]);
 
  // Deploy the bytecode with 1 million gas, from account[0]. 
  const result = await new web3.eth.Contract(JSON.parse(compiled.interface))
    .deploy({ data: compiled.bytecode })     
    .send({ gas: '1000000', from: accounts[0] });       

  // When finished. 
  console.log('Contract deployed to', result.options.address);
};
deploy();


