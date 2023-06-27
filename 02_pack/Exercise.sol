// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

import "forge-std/Script.sol";

contract Exercise {
    function setValues(uint64 _a, uint64 _b, address _c, uint128 _d) external {}

    function getValues() external view returns (uint64, uint64, address, uint128) {
        return (0, 0, address(this), 0);
    }
}
