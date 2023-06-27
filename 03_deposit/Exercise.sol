// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.16;

import "forge-std/Script.sol";

import "./DepositContract.constant.sol";

// steth is your friend
contract Exercise {
    address dc;

    function getValues() external pure returns (bytes memory, bytes memory, address) {}

    function setDepositContract(address _dc) external {
        dc = _dc;
    }

    function deposit(bytes calldata, bytes calldata, address) external payable {}
}
