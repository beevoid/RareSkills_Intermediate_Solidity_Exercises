// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

contract LowLevelStruct {
    function main(address a) public returns (uint256 x, uint256 y) {
        // call function "point()" on address a
        // do not use an interface
        // point() returns a struct with two uint256 fields, i.e.
        // struct Point {
        //     uint256 x;
        //     uint256 y;
        // }
        // return the two fields
        // revert if the low level call reverts

        //Low Level Call

        (bool ok, bytes memory data) = a.call(
            abi.encodeWithSignature("point()")
        );
        require(ok);
        (x, y) = abi.decode(data, (uint256, uint256));
        return (x, y);

        // bonus challenge: use an interface and a high level call to accomplish the same task

        //High Level Call

        try IPoint(a).point() returns (uint256 _x, uint256 _y) {
            return (_x, _y);
        } catch {
            revert();
        }
    }
}

interface IPoint {
    function point() external returns (uint256, uint256);
}
