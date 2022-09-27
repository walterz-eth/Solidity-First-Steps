//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract Events {

    event BooleanSent (bool indexed booleanValue); 
    // having one 'indexed' fields (up to three) makes the event searchable in the logs sidechain

    /*
        Trying to get an external function's return value from web3 won't work.
        This only works on Javascript VM (transactions ar not actually mined or are mined instantly,
        so you can get a return value synchronously)
        To make this work on an actual blockchain, we should use EVENTS.
    */
    constructor () {
    }

    function getBoolean () external returns (bool) {
        
        emit BooleanSent(true); // Event is triggered once the tx is MINED

        return true;
    }

}
