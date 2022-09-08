//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract StructsBasics {

    mapping (address => Balance) internal mapAddrBalance;

    struct Payment {
        uint value;
        uint timestamp;
    }
    
    struct Balance {
        uint totalBalance;
        
        // Saving this counter to insert new values in 'payments' at last position
        // (mappings have no .length)
        uint totalPayments; 

        mapping(uint => Payment) payments;
    }

    constructor () {

    }

    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }

    function sendMoney() public payable {
        /*
        Using memory because this variable should only live inside this scope and
        and no data will be stored on chain:
        - storage: modifiable data that will be stored on chain
        - memory: data that will only be readen (although modifiable too)
        - calldata doesn't save it's contents to memory (lowering gas consuption)
        */
        Payment memory newPayment = Payment (msg.value, block.timestamp);

        mapAddrBalance[msg.sender].totalBalance += msg.value;
        mapAddrBalance[msg.sender].payments[mapAddrBalance[msg.sender].totalPayments] = newPayment;
        mapAddrBalance[msg.sender].totalPayments++;
    }

    function getAccountBalance(address _from) public view returns(uint) {
        return payable(_from).balance;
    }
    function getAccountContractBalance(address _from) public view returns(uint) {
        return mapAddrBalance[_from].totalBalance;
    }
    function getAccountPaymentAtIndex(address _from, uint paymentIndex) public view returns(uint, uint) {
        return (mapAddrBalance[_from].payments[paymentIndex].value, mapAddrBalance[_from].payments[paymentIndex].timestamp);
    }

}
