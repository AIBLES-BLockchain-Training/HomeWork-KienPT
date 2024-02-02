// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.3;

contract greeter{
    
    string greeting = "Hello ";
    uint256 price = 1 gwei;
    address public owner;
    
    constructor(){
        owner = msg.sender;
    }
    
    
    function greetMe(string memory _name) public payable returns(string memory _greeting){
        if(msg.value >= price){
            return string(abi.encodePacked(greeting, _name));
        }else{
            return "";
        }
    }     
}