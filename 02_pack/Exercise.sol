// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

import "forge-std/Script.sol";

contract Exercise {
    // Packed storage of _a, _b, and _d
    uint256 private packedValues;

    // Separate storage for _c
    address private cValue;

    function setValues(uint64 _a, uint64 _b, address _c, uint128 _d) external {
        // Pack _a, _b, and _d into packedValues
        packedValues = (uint256(_a) << 192) | (uint256(_b) << 128) | uint128(_d);

        // Store _c in separate variable
        cValue = _c;
    }

    function getValues() external view returns (uint64, uint64, address, uint128) {
        // Unpack _a, _b, and _d from packedValues
        uint64 a = uint64(packedValues >> 192);
        uint64 b = uint64(packedValues >> 128);
        uint128 d = uint128(packedValues);

        // Return the values
        return (a, b, cValue, d);
    }
}
