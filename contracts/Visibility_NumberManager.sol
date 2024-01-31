// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract NumberManager{
    uint private totalSum;
    uint public lastAddedNumber;

    constructor(uint _totalSum, uint _lastAddedNumber) {
        totalSum = _totalSum;
        lastAddedNumber = _lastAddedNumber;
    }

    function addNumber(uint number) public {
        totalSum  += number;
        lastAddedNumber = number;
    }

    function getTotalSum() external view returns(uint) {
        return totalSum;
    }

    function incrementTotalSum(uint number) private {
        totalSum += number;
    }

    // 
    uint x;
    function setX(uint _x) internal {
        x = _x;
    }
    function testInternal(uint number) internal {
        x -= number;
    }
    function getValueX() internal view returns(uint) {
        return x;
    } 
}