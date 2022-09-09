//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract Exceptions {

    event LogError(string reason);

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

    function withdrawMoney(address payable _to, uint _amount) public {

        // 'require' is preferred for input validation
        // if tx is reverted, remaining gas is returned to the sender
        require(_amount <= mapAddrBalance[msg.sender], "Not Enough Funds, aborting");

        // assert should be used for checking invariants (illegal variable values)
        // for example, a uint that gets to a value less than zero, will wrap around
        // setting it's value to more than it should've
        // assert consumes all tx gas
        assert(mapAddrBalance[msg.sender] >= mapAddrBalance[msg.sender] - _amount);

        mapAddrBalance[msg.sender] -= _amount;
        _to.transfer(_amount);
    }

    function tryCatcTest () public {
        
        WillFail will = new WillFail();

        try will.fail() {
            // do something (?)
        }  catch Error(string memory reason) {
            emit LogError(reason);
        }
    }

}

// inline external contract to test exception catching and events
contract WillFail {

    // pure functions do not read or modify the state
    function fail() public pure {
        require(false, "Error message.");
    }
}