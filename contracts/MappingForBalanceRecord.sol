//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract MappingForBalanceRecord {

    mapping (address => uint) internal mapAddrBalance;

    constructor () {

    }

    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }

    function sendMoney() public payable {
        // Sends ammount to the SC, AND stores which address will be the owner of that ammount
        mapAddrBalance[msg.sender] += msg.value;
    }

    function getAccountBalance(address _from) public view returns(uint) {
        return payable(_from).balance;
    }
    function getAccountContractBalance(address _from) public view returns(uint) {
        return mapAddrBalance[_from];
    }

    function withdrawMoney(address payable _to, uint ammount) public payable {
        // 1. Checks:
        // _to has to have x ammount of ETH in this SC
        require (mapAddrBalance[_to] > ammount, "You don't have that much balance in this SC.");

        // 2. Effects:
        // _to will now have less ETH in this SC
        mapAddrBalance[_to] -= ammount;

        // 3. Interaction:
        // _to will have withdrawn x ammount of ETH
        _to.transfer(ammount);
    }

}
