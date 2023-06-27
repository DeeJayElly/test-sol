// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

import "forge-std/Script.sol";

interface ICounter {
    function counter() external returns (uint256);
    function inc() external;
}
