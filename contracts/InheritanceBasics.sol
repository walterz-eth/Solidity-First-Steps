//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract Owned {

    address owner;

    constructor () {
        owner = address(msg.sender);
    }
}

contract InheritanceBasics is Owned {

    mapping(address => bool) public myMap;
    mapping(uint => mapping (uint => bool)) mapmap;


    constructor () {
        // Owned.constructor is automatically called
    }

    function getOwner () public view returns (address) {
        return owner;
    }

    function setTrueForAddress () public {
        myMap[msg.sender] = true;
    }

    function getMapping (uint _index, uint _index2) public view returns (bool _value) {
        return mapmap[_index][_index2];
    }
    function setMapping (uint _index, uint _index2, bool _value) public {
        mapmap[_index][_index2] = _value;
    }

}
