// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract Lesson1 {
    // if else 
    function testIfElse(uint a, uint b) public pure returns(string memory x) {
        if(a > b) {
            return "a > b";
        } else {
            return "a < b";
        }
    }

    // ternary operator
    function testTernaryOperator(uint x, uint y) public pure returns(uint){
        uint z = (x > y) ? x : y;
        return z;
    }

    // for loop
    address public receivingAddress;
    function testLoop(uint x) public pure returns(uint z) {
        for(uint i = 0; i <= x; i++) {
            z += i;
        }
    }    

    /// transfer
    // send
    // call
}