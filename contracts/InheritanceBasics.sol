//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract Owned {

    address owner;

    constructor () {
        owner = address(msg.sender);
    }
}

contract InheritanceBasics is Owned {

    constructor () {
        // Owned.constructor is called first
    }

    function getOwner () public view returns (address) {
        return owner;
    }

}
