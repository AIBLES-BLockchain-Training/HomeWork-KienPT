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
    modifier onlyAdmin{
        require(msg.sender==Adminstrator, "You can not solve!");
        _;
    }
    modifier onlyUser {
        require(UserRoles[msg.sender]!=0, "You can not solve!");
        _;
    }
    //Thêm roles chỉ dành cho admin
    function adding_roles(address _user, uint roles) public onlyAdmin {
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

contract LoanSystem is UserManager(msg.sender){
    mapping(address => uint) balanceDP;
    mapping(address => uint) loans;
    event Loan(address indexed to, uint val);
    event Repayments(address indexed name, string mesager, uint val);
    // Hàm cho vay
    function loan(uint _amount) external payable onlyUser {
        require(_amount <= address(this).balance, "Balance Bank not enough!");
        require(_amount >= 5, "You can not because amount < 5");
        payable(msg.sender).transfer(_amount);
        balanceDP[msg.sender] += _amount;
        loans[msg.sender] += _amount;
        emit Loan(msg.sender, _amount);
    }
    // Hàm trả tiền vay 0 lãi suất :)))))
    function repayments() public payable {
        require(msg.value >= 0, "Amount < 0");
        require(msg.value <= balanceDP[msg.sender], "Your balance not enough");
        require(msg.value <= loans[msg.sender], "Your balance not enough");
        balanceDP[msg.sender] -= msg.value;
        loans[msg.sender] -= msg.value;
        emit Repayments(msg.sender, "You have paid the amount!", msg.value);
    }
}

contract Financial_Operations is LoanSystem{
    event Deposit(address indexed sender, uint val);
    event Withdraw(uint _amount, address indexed recieve);
    // Hàm gửi tiền
    function deposit() external payable onlyUser {
        balanceDP[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }
    // Hàm nhận tiền
    function withdraw(uint _amount) external onlyUser {
        require(_amount <= balanceDP[msg.sender], "Amount than deposit!");
        payable(msg.sender).transfer(_amount);
        balanceDP[msg.sender] -= _amount;
        emit Withdraw(_amount, msg.sender);
    }
    // Kiểm tra số tiền đã gửi
    function get_Balances_Address() external view returns (uint) {
        return balanceDP[msg.sender];
    }
    // Số tiền của contract
    function getBalances() external view returns (uint) {
        return address(this).balance;
    }
}