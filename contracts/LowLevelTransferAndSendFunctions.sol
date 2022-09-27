// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract LowLevelTransferAndSendFunctions {

    event SendCallFailed (string _message);

    receive () external payable {}

    function testTransfer (address payable _to) public {
        /*
            Calling transfer will throw an error and revert if the transfer fails.
         */
        _to.transfer(10);
    }

    function testSend (address payable _to) public {
        /*
            Calling send in the other hand, will only return a boolean, not caring about what happened in the receiver contract.
            It's like a low-level version of 'transfer':

            - It will fail if the call stack depth is at 1024
            - It will fail if receiver runs out of gas (our case)

            *** If it returns TRUE, it doesn't mean that the transaction didn't fail !!!

         */


        /* 
                To overcome this:
                a. check the return value of send, 
                b. use transfer 
                c. even better: use a pattern where the recipient withdraws the money.
        */
        bool isTransfered = _to.send(10);

        if (!isTransfered) {
            // In this case, we can emit an event or err the transaction ourselves.
            emit SendCallFailed ("'send' action to smart contract failed.");
        }

    }

}

// Deploy separately first, then use address to make calls to LowLevelFunctionCalls.testSend and LowLevelFunctionCalls.testTransfer
contract ReceiverWrites {

    uint public myBalance;

    receive() external payable {
        /*         
            We will run out of gas here, since this contract tries to
            write to the blockchain inside the receive function.

            Transaction status will be "false Transaction mined but execution failed"
        */
        myBalance += msg.value;
    }
}