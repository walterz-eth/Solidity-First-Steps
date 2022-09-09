//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract Owned {

    address owner;

    constructor () {
        owner = address(msg.sender);
    }
}