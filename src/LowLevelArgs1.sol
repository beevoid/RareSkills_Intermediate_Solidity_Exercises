// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract LowLevelArgs1 {
    function main(address a, uint256 x) public {
        // call rare(x) using a low-level call
        // if the low level call reverts, revert also

        // bonus challenge: use an interface and a high level call to accomplish the same task

        //low level call
        (bool ok,) = a.call(abi.encodeWithSignature("rare(uint256)", x));
        require(ok);

        //high level call
        IRare(a).rare(x);
    }
}

interface IRare {
    function rare(uint256) external;
}
