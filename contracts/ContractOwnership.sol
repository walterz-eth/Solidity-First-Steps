// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract ContractOwnership {

    // made public only for testing purposes
    address payable public owner;

    constructor () {
        // Owner of smart contract will be the address that deploys it
        owner = payable(msg.sender);
    }

    function sendMoney () public payable {
        // no more needed for the contract to receive money
    }

    function dameTodo (address payable _to) public {
        require(msg.sender == owner, "eh, vo no so el ouner!");
        _to.transfer (address(this).balance); // sending all to _to
    }

}