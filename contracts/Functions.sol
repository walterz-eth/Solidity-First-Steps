//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract Functions {

    mapping (address => uint) internal mapAddrBalance;

    address payable owner;

    constructor () {
        owner = payable(msg.sender);
    }

    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }

    /*
        see https://docs.soliditylang.org/en/v0.6.7/060-breaking-changes.html#semantic-and-syntactic-changes

        "If present, the receive ether function is called whenever the call data 
        is empty (whether or not ether is received). This function is implicitly payable."
    */
    //function sendMoney() public payable {
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

    /*
        see https://docs.soliditylang.org/en/v0.6.7/060-breaking-changes.html#semantic-and-syntactic-changes
        
        "The new fallback function is called when no other function matches 
        (if the receive ether function does not exist then 
        it is called also for calls with empty call data). 
        You can make this function payable or not. 
        If it is not payable then transactions not matching any other function 
        which send value will revert."
    */
    fallback () external payable {
    }
}