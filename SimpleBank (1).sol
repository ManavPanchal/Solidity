// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleBank{
    mapping(address => uint) internal balance;
    event transaction(address accountHolder, uint amount, string statement);

    modifier balanceAvailabilty(uint amount){
        uint accountHolderBalance = balance[msg.sender];
        require(accountHolderBalance >= amount, "insufficient balance");
        _;
    }

    function Deposit() payable public{
        balance[msg.sender] += msg.value;
        emit transaction(msg.sender, msg.value * 1 ether, "deposited");
    }

    function Balance() external view returns(uint){
        return balance[msg.sender];
    }

    function Withdraw(uint amount) public balanceAvailabilty(amount){

        address payable sender = payable(msg.sender);
        balance[msg.sender] -= amount * 1 ether;
        sender.transfer(amount * 1 ether);
        
        emit transaction(msg.sender, amount * 1 ether, "credited");
    }
}
