// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract A{
    function get() public pure virtual returns(string memory) {
        return "A";
    }
    function x() external view  virtual returns (uint) {
        return 5;
    }
}

contract B is A{
    uint public override x;
    function get() public pure virtual override returns(string memory) {
        // return A.get();
        // return super.get();
        return "B";
    }
}
contract C is A{
    function get() public pure override returns(string memory) {
        // return A.get();
        // return super.get(); goi dem super gan nhat
        return "C";
    }
}

contract D{
    function get() public pure virtual returns(string memory) {
        return "D";
    }
}

contract E is A, D {
    function get() public pure virtual override(A, D) returns(string memory) {
        // return "D";
        // return D.get();
        return super.get();
    }
}
 

