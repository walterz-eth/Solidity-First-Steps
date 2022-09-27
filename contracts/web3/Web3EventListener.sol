//SPDX-License-Identifier: MIT

pragma solidity ^0.8;

contract Web3EventListener {

    mapping(address => bool) public accountEnabled;

    event ChangeEvent (address indexed _from, bool _value);

    function setAccountEnabled (address _from, bool _value) external {
        accountEnabled[_from] = _value;

        emit ChangeEvent(_from, _value);
    }

}