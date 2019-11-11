pragma solidity ^0.4.22;



contract Callee {
    uint[] public values;    // Holds an array of integers

    function getValue(uint initial) public returns(uint) { // Retivee amount of stored values
        return initial + 150;
    }
    function storeValue(uint value) public {  // A way to add a value
        values.push(value);
    }
    function getValues() public view returns(uint) {  //  // Takes an input and returns a changed output
        return values.length;
    }
}  


