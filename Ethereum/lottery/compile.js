/*  We cannot use the require node function since the kickstart.sol
 is not javascript ! Therefore we have to read to file from 
 the hard drive */

const path = require('path'); //path module makes sure it's compatible on each os
const fs = require('fs'); 
const solc = require('solc'); //solidity compiler 

const kickstarterPath = path.resolve(__dirname, 'contracts', 'Kickstarter.sol'); // dirname 
const source = fs.readFileSync(kickstarterPath, 'utf8'); 

console.log(solc.compile(source, 1)); //returns the byte code (bunch of hex) and the abi in json. 

// Exports: to make it avaiable to other files in this program. 
module.exports = solc.compile(source,1).contracts[':Kickstarter']; //to just get the bytecode and the abi from the json data  