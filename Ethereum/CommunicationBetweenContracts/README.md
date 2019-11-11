# Communication between Soldity Smart contrats

### Callee.sol
A Callee contract (Callee.sol), is a simple contract, which holds an array of integers, a function getValue to retrieve the emount of stored values and a function storeValue, as a away to add value. A method getValues returns the length of the array values. 

### Caller.sol
A caller contract (Caller.sol), imports the Callee.sol contract, and has 3 functions, SomeAction which calls the the callee contract, adds 100 with 150 in the Callee contract and returns the value to the Caller contract.  Another function, storeAction, should add a value to the integer array in Callee, and then returns the updated array length to the Caller contract. 



