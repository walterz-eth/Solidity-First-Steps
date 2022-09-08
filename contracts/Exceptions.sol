//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract Exceptions {

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
        // 'require' is preferred for input validation
        require (mapAddrBalance[_to] > ammount, "You don't have that much balance in this SC.");

        // assert should be used for checking invariants (illegal variable values)
        // for example, a uint that gets to a value less than zero, will wrap around
        // setting it's value to more than it should've
        assert (mapAddrBalance[_to] > mapAddrBalance[_to] - ammount);

        mapAddrBalance[_to] -= ammount;
        _to.transfer(ammount);
    }

}
