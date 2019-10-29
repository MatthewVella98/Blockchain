/*  We cannot use the require node function since the Inbox.sol
 is not javascript ! Therefore we have to read to file from 
 the hard drive */

const path = require('path'); //path module makes sure it's compatible on each os
const fs = require('fs'); 
const solc = require('solc'); //solidity compiler 

const lotteryPath = path.resolve(__dirname, 'contracts', 'Lottery.sol'); // dirname 
const source = fs.readFileSync(lotteryPath, 'utf8'); 

// console.log(solc.compile(source, 1)); //returns the byte code (bunch of hex) and the abi in json. 

module.exports = solc.compile(source,1).contracts[':Lottery']; //to just get the bytecode and the abi from the json data. 




