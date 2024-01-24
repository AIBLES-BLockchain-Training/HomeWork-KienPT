// SPDX-License-Identifier: MIT
// Code by KienPT :))
pragma solidity ^0.8.3;

contract HomeWork {
    constructor() {}

    //Ex1:
    bool public b = true;
    
    function get_b() public view returns(bool) {
        return b;
    }

    //Ex2:
    uint public x = 0;
    function addToX2(uint y) public {
        x+=y;
    }

    //Ex3:
    modifier solve1(uint _x) {
        require(_x>0, "x khong tang");
        x+=_x;
        _;
    }

    function increaseX(uint _x) public solve1(_x){}

    //Ex4:
    function returnTwo() public pure returns(int value, bool _value) {
        value = -2;
        _value = true;
    }
}
