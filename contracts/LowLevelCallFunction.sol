// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract Receiver {

    mapping (address => uint) public balances;

    function deposit () public payable {
        balances[msg.sender] += msg.value;

        // **WARNING** re-entrance attack:
        // if this contract know address of Sender, it can call payKnowingNothing function again
        // making it call receive fallback function again and increasing it's balance!!
        // (to do this, the amount of gas should be particularly high, that's why this won't happen with .send or .transfer
    }


    // To test the "know nothing about this contract" scenario
    receive () external payable {
        // let's do some writing, so we can force this to fail when running out of GAS
        deposit ();
    }

}

contract Sender {

    // only needed so we can fund this contract for testing purposes
    receive () external payable {}

    function payKnowingContract (address payable _contractAddress) external payable {

        // A - one way to do that, knowing what contract type is at _contractAddress and instantiating it
        // Then call the Receiver.deposit in this form, specifying what will later be the contents of the "msg" object;
        Receiver rec = Receiver(_contractAddress);
        rec.deposit{value: 1, gas: 100000}();
    }

    function payKnowingFunction (address _contractAddress) external payable {

        // B - I don't know the type of the contract, but I know the function and it's signature;
        bytes memory payload = abi.encodeWithSignature("deposit()"); // should we send arguments, we use something like this: ("functionWithArgs(uint)",7);
        

        // SIMILAR TO SEND, we need to get return value to make sure transaction ocurred (this call will not fail otherwise)        
        (bool success, ) = _contractAddress.call{value: 1, gas: 100000}(payload);
        require (success);


        // *** WHY (bool success, ) ???? ***
        // '(bool success' : stores the result of the transaction
        // ', bytes memory _returnData)' : stores any return value of called payload function (nothing in this case)

    }


    function payKnowingNothing (address _contractAddress) external payable {
        // Assume we expect Receiver to call it's fallback (receive) function, not calling a specific function
        // e.g. not providing any specific payload

        // CHECK: conditions
        // check _contractAddress has correct balance and make a 'require' here to stop reentrance
        
        // EFFECTS: write
        // reduce the balance of THIS contract

        // INTERACTION: with external contracts
        (bool success, ) = _contractAddress.call{value: 1, gas:100000}("");
        require (success);
    }
}