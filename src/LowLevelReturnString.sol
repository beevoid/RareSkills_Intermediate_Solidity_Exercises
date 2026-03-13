// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract LowLevelReturnString {
    function main(address a) public returns (string memory) {
        // call function "baz()" on address a
        // do not use an interface
        // baz() returns a string. Return the string.
        // However, if baz reverts, return an empty string

        // bonus challenge: use an interface and a high level call to accomplish the same task

        //Low Level Call
        (bool ok, bytes memory data) = a.call(abi.encodeWithSignature("baz()"));
        if (!ok) return "";
        string memory output = abi.decode(data, (string));
        return output;

        //High Level Call
        try IBaz(a).baz() returns (string memory value) {
            return value;
        } catch {
            return "";
        }
    }
}

interface IBaz {
    function baz() external returns (string memory);
}
