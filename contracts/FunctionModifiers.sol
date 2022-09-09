//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract FunctionModifiers {

    mapping (address => uint) internal mapAddrBalance;

    address payable owner;

    constructor () {
        owner = payable(msg.sender);
    }

    // view functions can only read the state
    function getOwner () public view returns (address) {
        return owner;
    }

    /*
        pure functions cannot even read the state 
        or call other non-pure functions
    */
    function sumUint (uint a, uint b) public pure returns (uint) {
        return a+b;
    }

    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }

    receive () external payable {
        // Sends ammount to the SC, AND stores which address will be the owner of that ammount
        mapAddrBalance[msg.sender] += msg.value;
    }

    function getAccountBalance(address _from) public view returns(uint) {
        return payable(_from).balance;
    }
    function getAccountContractBalance(address _from) public view returns(uint) {
        return mapAddrBalance[_from];
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        require(_amount <= mapAddrBalance[msg.sender], "Not Enough Funds, aborting");
        assert(mapAddrBalance[msg.sender] >= mapAddrBalance[msg.sender] - _amount);

        mapAddrBalance[msg.sender] -= _amount;
        _to.transfer(_amount);
    }
}