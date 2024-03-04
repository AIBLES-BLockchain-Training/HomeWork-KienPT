// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract UserManager{
    address private Adminstrator;
    address private Manager;
    constructor(address admin) {
        Adminstrator = admin;
        UserRoles[admin] = 1;
    }
    mapping (address => uint) UserRoles;
    modifier checkAdmin{
        require(msg.sender==Adminstrator, "You can not solve!");
        _;
    }
    //Thêm roles chỉ dành cho admin
    function adding_roles(address _user, uint roles) internal {
        /*
            1: Admin
            2: Manager
            3: User
        */
        if(roles==1) {
            Adminstrator = _user;
            UserRoles[_user] = 1;
        } else if(roles==2) {
            Manager = _user;
            UserRoles[_user] = 2;
        } else {
            UserRoles[_user] = 3;
        }
    }
    // kiểm tra roles của người dùng
    function checking_roles(address _user) public view returns(string memory) {
        if(UserRoles[_user]==1) {
            return "Admin";
        } else if(UserRoles[_user]==2) {
            return "Manager";
        } else if(UserRoles[_user]==3) {
            return "User";
        } else {
            return "Can not find data";
        }
    }
}

contract Bank {
    mapping (address => uint) Balance_Bank;
    mapping (address => uint) Balances;
    // lưu trữ số tiền phải tra sau khi vay
    mapping (address => uint) loans;
    // Kiểm tra số tiền muốn rút có nhỏ hơn số tiền đã gửi tiết kiệm ko
    modifier checkValue(uint value) {
        require(value <= Balance_Bank[msg.sender], "You not enough money!");
        _;
    }
    // Điều kiện khi vay
    modifier requestLoan(uint value) {
        require(Balances[msg.sender] < 10, "You can not solve!");
        require(value >= 10, "Value < 10! Can not solve");
        _;
    }
    // Kiểm tra có vay hay không 
    modifier checkLoans {
        require(loans[msg.sender] == 0, "You have loan");
        _;
    }
    // Hàm vay tiền và tính tiền phải trả sau khi vay
    function loan(uint value, uint month) internal requestLoan(value){
        loans[msg.sender] = value*month/10 + value;
        Balances[msg.sender] += value;
    }
}

 
contract Financial_Operations is UserManager(msg.sender), Bank {
    // kiểm tra số dư tài khoản của người dùng
    function Balance() public view returns(uint){
        return Balances[msg.sender];
    }
    // Thêm roles (chỉ admin mới thực hiện được)
    function addRoles(address user, uint roles) public checkAdmin {
        UserManager.adding_roles(user, roles);
    } 
    // Gửi tiền tiết kiệm chỉ thực hiện khi không có khoản vay
    function deposit(uint value) public checkLoans {
        Balance_Bank[msg.sender] += value; 
        Balances[msg.sender] -= value;       
    }
    // Rút tiền gửi tiết kiệm
    function withDraw(uint value) public checkValue(value) {
        Balance_Bank[msg.sender] -= value;
        Balances[msg.sender] += value;
    }
    // Vay với số tiền là value với số tháng là month chỉ thực hiện được khi không có khoản vay
    function systemLoan(uint value, uint month) public checkLoans {
        Bank.loan(value, month);
    }
    // Kiểm tra khoản vay
    function checkLoan() public view returns(uint){
        return loans[msg.sender];
    }  
    // Thực hiện trả khoản vay
    function repayments(uint x) public {
        loans[msg.sender] -= x;
        Balances[msg.sender] -= x;
    }
}