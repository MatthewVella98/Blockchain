
var metaMaskMnemonic = 'mammal waste glare genius praise unaware will fiction add corn hobby lens'; 

var HDWalletProvider = require('truffle-hdwallet-provider'); 

module.exports = { 
  networks: {
    development : {
      host: "localhost",
      port: 8545,
      network_id: "*"
    }
    , 
   rinkeby: {
      network_id: 4, 
      provider: new HDWalletProvider(metaMaskMnemonic,'https://rinkeby.infura.io/v3/ccf57dddf77c40cdac915939d73fc21c')
   }
  }
}; 



