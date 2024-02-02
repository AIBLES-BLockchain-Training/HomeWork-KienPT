// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.3;

contract Test {
    address public owner;
    mapping(address => uint) balances;
    constructor(uint x) {
        owner = msg.sender;
        balances[owner] = x;
    }

    modifier checking(uint x) {
        require(balances[owner] >= x,  "Khong du so du");
        _;
    }

    function send(address revecies, uint x) public checking(x) {
       balances[revecies] += x; 
    }

}