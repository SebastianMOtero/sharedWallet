// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import "./Allowance.sol";

contract SimpleWallet is Allowance {

    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);

    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {   
        require(_amount <= address(this).balance, "There are not enough funds stored in the wallet");
        if(!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }

    function renounceOwnership() public override view onlyOwner {
        revert("Can't renounce ownership here");
    }

    function transferOwnership(address newOwner) public override view onlyOwner {
        revert("Can't transfer ownership here");
    }

    function getBalance() public view onlyOwner returns(uint) {
        return address(this).balance;
    }

    receive() external payable {
        emit MoneyReceived(msg.sender, msg.value);
    }
}