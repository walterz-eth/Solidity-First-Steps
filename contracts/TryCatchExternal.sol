//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract A {

    error LowLevelError(bytes _reason);

    function requireFailure() public pure {
        require(false, "requireFailure");
    }
    
    function revertFailure() public pure {
        revert LowLevelError ("revertFailure");
    }
    
    function assertFailure() public pure {
        assert(false);
    }
}

contract B {
    A instA;
    
    event Error(string _reason);
    event LowLevelEvent(bytes _reason);
    
    constructor() {
        instA = new A();
    }
    
    function testTryCatch() public returns(bool) {

        // Try with each one, and see how each failure is handled!
        // In every case, errors are cathed, BUT TARNSACTION DO NOT FAIL !!!
        // (Try deploying contract A and calling it's functions, to see how transactions fail

        //try instA.assertFailure() {
        try instA.revertFailure() {
        //try instA.requireFailure() {
            return true;
        } catch Error(string memory reason) {
            // This is executed in case
            // revert was called inside getData
            // and a reason string was provided.
            emit Error(reason);
            return false;
        } catch (bytes memory lowLevelData) {
            // This is executed in case revert() was used
            // or there was a failing assertion, division
            // by zero, etc. inside getData.
            emit LowLevelEvent(lowLevelData);
            return false;
        }
    }
}