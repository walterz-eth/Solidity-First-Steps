//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "./Owned.sol";

contract InheritanceWithFiles is Owned {

    constructor () {
        // Owned.constructor is automatically called
    }

    function getOwner () public view returns (address) {
        return owner;
    }

}
