//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;


contract Base1 {

    event StringEvent (string _string);

    function func () public virtual {
        emit StringEvent("Base1.func");
    }
}
contract Base2 {

    event StringEvent2 (string _string);

    function func () public virtual {
        emit StringEvent2("Base2.func");
    }
}

// Override order is: InheritanceComposition.func overrides Base2.func which overriden Base1.func
contract InheritanceComposition is Base1,Base2 {

    event StringEvent3 (string _string);

    // WARNING: Order of override statement arguments DOESN'T change declared composition order of the contract! 
    function func () public override (Base1,Base2) {
        super.func();
        emit StringEvent3 ("InheritanceComposition.func()");
    }
}