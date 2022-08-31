// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract ContractOwnershipModifiers {

    // made public only for testing purposes
    address payable public owner;

    // modifier to check for ownership
    // '_' tells at which point the modified function's code will be run.
    modifier isOwner {
        require(msg.sender == owner, "hey, you are not the contract owner!");
        _; // this will be 'replaced' by the modified funtion's code
        
        /* *** If _ is found before modifier´s code, and the modified function returns,
        modifier´s code WON'T EXECUTE
        */
    }

    constructor () {
        // Owner of smart contract will be the address that deploys it
        owner = payable(msg.sender);
    }

    function sendMoney () public payable {
        // no more needed for the contract to receive money
    }

    // custom modifier 'isOwner' is defined above, and will execute always
    function giveMeAll (address payable _to) public isOwner {
        //require(msg.sender == owner, "hey, you are not the contract owner!");
        _to.transfer (address(this).balance); // sending all to _to
    }

}
