pragma solidity ^0.4.22;

/* The address which is requested as parameter, is the addres sof the callee function.
It woul laos be possible to initialise a contract with a vertain address and to chnage this 
address after some time, example to use a newer version of the target contract. */

import "./Callee.sol"; 

contract Caller {
    function someAction(address addr) public returns(uint) {
        Callee c = Callee(addr); 
        return c.getValue(100);
    }
    
    function storeAction(address addr) public returns(uint) {
        Callee c = Callee(addr);
        c.storeValue(100);
        return c.getValues(); 
    } 
    
    function someUnsafeAction(address addr) public {
        addr.call(bytes4(keccak256("storeValue(uint256)")), 100);
    }
}











